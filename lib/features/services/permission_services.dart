import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class PermissionService {
  Future requestPhotosPermission();
  Future requestCameraPermission();
  Future<bool> handlePhotosPermission(BuildContext context);
  Future<bool> handleCameraPermission(BuildContext context);
}

class PermissionHandler implements PermissionService {
  @override
  Future<bool> handleCameraPermission(BuildContext context) async {
    PermissionStatus status = await requestCameraPermission();
    if (status != PermissionStatus.granted) {
      // await showDialog(
      //   context: context,
      //   builder: (_) => AppAlertDialog(
      //     onConfirm: () => openAppSettings(),
      //     title: 'Camera Permission',
      //     subtitle:
      //         'Camera permission should Be granted to use this feature, would you like to go to app settings to give camera permission?',
      //   ),
      // );
      return false;
    }
    return true;
  }

  @override
  Future<bool> handlePhotosPermission(BuildContext context) async {
    PermissionStatus status = await requestPhotosPermission();
    if (status != PermissionStatus.granted) {
      // await showDialog(
      //   context: context,
      //   builder: (_) => AppAlertDialog(
      //     onConfirm: () => openAppSettings(),
      //     title: 'Photos Permission',
      //     subtitle:
      //         'Photos permission should Be granted to use this feature, would you like to go to app settings to give Photos permission?',
      //   ),
      // );
      return false;
    }
    return true;
  }

  @override
  Future<PermissionStatus> requestCameraPermission() async {
    return await Permission.camera.request();
  }

  @override
  Future<PermissionStatus> requestPhotosPermission() async {
    return await Permission.storage.request();
  }
}
