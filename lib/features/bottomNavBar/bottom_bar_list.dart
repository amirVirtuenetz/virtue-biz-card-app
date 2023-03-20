import '../contacts/screen/contact_screen.dart';
import '../qrCode_scan/qr_image_scan.dart';
import '../screens/biz_card.dart';
import '../setting/screens/setting_screen.dart';

final List list = [
  const BizCardMain(),
  // MyWidget(),
  const ContactScreen(),
  // Container(
  //   alignment: Alignment.center,
  //   child: const Text("Contacts"),
  // ),
  // QRScanner(),
  // Container(
  //   alignment: Alignment.center,
  //   child: const Text("Scan"),
  // ),
  const QRCodeScannerScreens(),
  // Container(
  //   alignment: Alignment.center,
  //   child: const Text("Setting"),
  // ),
  const SettingScreen(),
];
