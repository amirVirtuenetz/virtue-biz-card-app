import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class AlertMessage {
  static void showMessage(BuildContext context, String message) {
    var snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static successMessage(String message) {
    EasyLoading.showSuccess(message);
  }

  static toastMessage(String message) {
    EasyLoading.showToast(message);
  }

  static dismissLoading() {
    EasyLoading.dismiss();
  }

  static warningMessage(String message) {
    EasyLoading.showError(message);
  }
}
