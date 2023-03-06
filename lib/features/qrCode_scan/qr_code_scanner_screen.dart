import 'dart:io';

import 'package:biz_card/core/helpers/helpers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../components/circle_button.dart';

class QRCodeScannerScreen extends StatefulWidget {
  const QRCodeScannerScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRCodeScannerScreenState();
}

class _QRCodeScannerScreenState extends State<QRCodeScannerScreen>
    with AutomaticKeepAliveClientMixin {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  // final GlobalKey<QRViewController> qrKey1 = GlobalKey();
  String qrText = "";
  File? _pickedImage;
  bool isResumeCamera = true;
  Future<void> pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      final imageBytes = File(pickedImage.path).readAsBytesSync();
      // final qrCode = await QRCodeReader().decode(imageBytes);
      controller?.scannedDataStream.listen((scanData) {
        setState(() {
          print("Data from image: ${scanData.rawBytes}");
        });
      });

      // setState(() {
      //   _pickedImage = File(pickedImage.path);
      //   qrText = qrCode;
      // });
    }
  }

  void toggleCamera() async {
    if (isResumeCamera) {
      await controller?.resumeCamera();
    } else {
      await controller?.pauseCamera();
    }
    setState(() {
      isResumeCamera = !isResumeCamera;
    });
  }

  @override
  void initState() {
    super.initState();
    controller?.resumeCamera();
  }

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Positioned.fill(child: _buildQrView(context)),
            Positioned(
              bottom: 40,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  if (result != null)
                    Text(
                        'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
                  else
                    const Text('Scan a code'),
                  Container(
                    width: screenWidth(context),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                minimumSize: const Size(50, 50),
                                maximumSize: const Size(50, 50),
                                elevation: 0,
                                side: const BorderSide(
                                    width: 1, color: Colors.white),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              onPressed: pickImage,
                              child: const SizedBox(),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 6.0),
                              child: Text(
                                "Upload",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            ),
                          ],
                        ),

                        ///
                        // CircleButton(
                        //     onPressed: () async {
                        //       await controller?.flipCamera();
                        //       setState(() {});
                        //     },
                        //     child: FutureBuilder(
                        //       future: controller?.getCameraInfo(),
                        //       builder: (context, snapshot) {
                        //         if (snapshot.data != null) {
                        //           return Icon(
                        //               snapshot.data.toString().contains("back")
                        //                   ? FontAwesomeIcons.cameraRotate
                        //                   : FontAwesomeIcons.cameraRotate);
                        //           // Text(
                        //           //   'Camera facing ${describeEnum(snapshot.data!)}');
                        //         } else {
                        //           return const Text('loading');
                        //         }
                        //       },
                        //     )),
                        ///
                        CircleButton(
                          onPressed: () async {
                            toggleCamera();
                          },
                          child: Icon(isResumeCamera == true
                              ? Icons.play_circle_fill_outlined
                              : Icons.pause_circle_filled_outlined),
                        ),
                        CircleButton(
                          onPressed: () async {
                            await controller?.toggleFlash();
                            setState(() {});
                          },
                          child: FutureBuilder(
                            future: controller?.getFlashStatus(),
                            builder: (context, snapshot) {
                              return Icon(snapshot.data == true
                                  ? FontAwesomeIcons.boltLightning
                                  : FontAwesomeIcons.bolt);
                              // Text('Flash: ${snapshot.data}');
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 0,
              left: 10,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
              child: _pickedImage != null
                  ? Image.file(_pickedImage!)
                  : const Center(
                      child: Text('No image selected'),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 300.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.white,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        print("Data: $result");
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    print('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
