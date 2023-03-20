import 'package:share_plus/share_plus.dart';

class ShareClass {
  static shareOnOtherWay(String path) {
    Share.shareXFiles([XFile(path)],
        text: 'Please Scan QR Code', subject: "Scan QR Code");
  }
}
