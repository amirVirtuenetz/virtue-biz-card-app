import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:biz_card/core/helpers/alert_message.dart';
import 'package:biz_card/features/model/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:social_share/social_share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_share/whatsapp_share.dart';

import '../../core/helpers/app_colors.dart';
import '../components/text_button.dart';
import '../model/model.dart';
import '../providers/user_provider.dart';
import 'components/list_tile_widget.dart';

class ShareQRCodeScreen extends StatefulWidget {
  const ShareQRCodeScreen({Key? key}) : super(key: key);

  @override
  State<ShareQRCodeScreen> createState() => _ShareQRCodeScreenState();
}

class _ShareQRCodeScreenState extends State<ShareQRCodeScreen> {
  GlobalKey globalKey = GlobalKey();
  QrCodeData data = QrCodeData();
  UserDataModel userDataModel = UserDataModel();
  String? encodedJson;
  bool isInternet = false;
  File? file;
  @override
  void initState() {
    data = QrCodeData(
        name: "Amir Nazir",
        jobTitle: "Flutter Developer",
        company: "Virtuenetz",
        address: "Rahim Yar Khan",
        bio: "Hi!, I am flutter developer",
        link: "https://www.instagram.com/raisamir7082");
    // setState(() {
    //   encodedJson = jsonEncode(data);
    //   log("My Data: $encodedJson");
    // });
    setBrightness(1.0);
    super.initState();
  }

  Future<void> setBrightness(double brightness) async {
    try {
      await ScreenBrightness().setScreenBrightness(brightness);
    } catch (e) {
      print(e);
      throw 'Failed to set brightness';
    }
  }

  Future<void> capture() async {
    try {
      RenderRepaintBoundary boundary =
          globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
      var image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();
      Directory? directory;
      if (Platform.isAndroid) {
        directory = await getExternalStorageDirectory();
      } else {
        directory = await getApplicationDocumentsDirectory();
      }
      // final tempDir = await getTemporaryDirectory();
      final file = await File('${directory?.path}/image.png').create();
      log("File in ABC: $file");
      this.file = file;
      var ed = await file.writeAsBytes(pngBytes);
      log("File in ED: $ed");
      saveImageToGallery(ed);
      // final channel = const MethodChannel('channel:me.alfian.share/share');
      // channel.invokeMethod('shareFile', 'image.png');
    } catch (e) {
      print("Error while sharing QR Code  : ${e.toString()}");
    }
  }

  sharQRCodeToSocial(File ed) async {
    // Share.shareXFiles([XFile(ed.path)],
    //     text: 'Please Scan QR Code', subject: "Scan QR Code");
  }

  saveImageToGallery(File recordedImage) async {
    GallerySaver.saveImage(recordedImage.path, albumName: "Biz Card")
        .then((path) {
      AlertMessage.successMessage("Your QR Code has been saved in gallery");
    }).catchError((e) {
      log("Error while saving image to gallery");
    });
  }

  Future<void> resetBrightness() async {
    try {
      await ScreenBrightness().resetScreenBrightness();
    } catch (e) {
      print(e);
      throw 'Failed to reset brightness';
    }
  }

  @override
  void dispose() {
    resetBrightness();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final bodyHeight = MediaQuery.of(context).size.height -
    //     MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        leading: Transform.translate(
          offset: const Offset(5, 0),
          child: IconButton(
            onPressed: () {
              // GoRouter.of(context).backButtonDispatcher;
              if (kIsWeb) {
                context.go("/");
              } else {
                Navigator.pop(context);
              }
            },
            icon: const Icon(FontAwesomeIcons.xmark),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Consumer(builder: (context, ref, _) {
            final userpro = ref.watch(userProvider);
            if (userpro != null) {
              log("Consumer Widget");
              userpro.getDataFromFireStore();
              log("profile Link: ${userpro.userModel.profileLink}");
              encodedJson = jsonEncode(userpro.userModel);
              log("Encoded Json : $encodedJson");
              // selectedColor = Color(
              //     int.parse("0XFF${auth.userModel.brandColor.toString()}"));
              // log("brand color: ${selectedColor}");
            } else {
              log("Loading...............");
            }

            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 10.0),
                  margin: const EdgeInsets.symmetric(horizontal: 50),
                  // margin: const EdgeInsets.symmetric(horizontal: 0),
                  width: double.infinity,
                  child: MaterialButton(
                    onPressed: () {},
                    // textColor: Colors.blue.shade700,
                    elevation: 2,
                    hoverElevation: 2,
                    highlightElevation: 2,
                    disabledElevation: 2,
                    enableFeedback: false,
                    color: Colors.white,
                    // textTheme: ButtonTextTheme.accent,
                    textColor: Colors.blueAccent,
                    // minWidth: 100,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                      // side: BorderSide(color: Colors.blue.shade700),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Sharing ${userpro.userModel.displayName}",
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Icon(
                            Icons.keyboard_arrow_down_outlined,
                            size: 30,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: GestureDetector(
                    onTap: capture,
                    child: RepaintBoundary(
                      key: globalKey,
                      child: Container(
                        color: Colors.white,
                        child: QrImage(
                          data: "$encodedJson",
                          size: 250,
                          embeddedImage:
                              const AssetImage("assets/images/bizCardLogo.png"),
                          embeddedImageStyle: QrEmbeddedImageStyle(
                            size: const Size(60, 60),
                          ),
                          errorStateBuilder: (context, ex) {
                            log("[QR] ERROR - $ex");
                            return Center(
                              child: Text("Error: $ex"),
                            );
                            // setState((){
                            //   _inputErrorText = "Error! Maybe your input value is too long?";
                            // });
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AppTextButton(
                      size: const Size(100, 50),
                      backgroundColor: AppColor.primaryBackgroundColor,
                      textColor: Colors.black,
                      onPressed: () {},
                      title: "Edit QR",
                    ),
                    AppTextButton(
                      size: const Size(100, 50),
                      onPressed: () {},
                      title: "Share",
                    ),
                  ],
                ),

                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0XFFF4F4F4),
                    border: Border.all(width: 0.5, color: Colors.grey),
                    // color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Copy Cod Link",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          await Clipboard.setData(const ClipboardData(
                                  text: "Your link has been saved"))
                              .then((value) {
                            AlertMessage.successMessage("Card Link Copied");
                          });
                        },
                        icon: Icon(Icons.copy),
                      )
                    ],
                  ),
                ),

                ///add card to wallet
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 1),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  decoration: BoxDecoration(
                    color: const Color(0XFFF4F4F4),
                    border: Border.all(width: 0.2, color: Colors.grey),
                    // color: Colors.grey.shade300,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                      bottomLeft: Radius.circular(1),
                      bottomRight: Radius.circular(1),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Icon(Icons.wallet),
                      ),
                      Expanded(
                        child: Text(
                          "Add Card to Wallet",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                ///add QR Code to photos
                GestureDetector(
                  onTap: () {
                    capture();
                  },
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    decoration: BoxDecoration(
                      color: const Color(0XFFF4F4F4),
                      border: Border.all(width: 0.2, color: Colors.grey),
                      // color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(1),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Icon(Icons.qr_code),
                        ),
                        Expanded(
                          child: Text(
                            "Save QR Code to Photos",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                /// Share with no internet
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 1),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  decoration: BoxDecoration(
                    color: const Color(0XFFF4F4F4),
                    border: Border.all(width: 0.2, color: Colors.grey),
                    // color: Colors.grey.shade300,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(1),
                      topRight: Radius.circular(1),
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Icon(Icons.wifi_off_outlined),
                      ),
                      const Expanded(
                        child: Text(
                          "Share with no internet",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 40,
                        height: 30,
                        child: Switch(
                            value: isInternet,
                            onChanged: (val) {
                              setState(() {
                                isInternet = val;
                              });
                            }),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),

                ///
                // Padding(
                //   padding:
                //       const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                //   child: SwitchListTile(
                //       tileColor: const Color(0XFFF4F4F4),
                //       inactiveThumbColor: const Color(0XFFC8DCF7),
                //       inactiveTrackColor: const Color(0XFFA5C6F3),
                //       activeColor: Colors.blueAccent,
                //       activeTrackColor: const Color(0XFFA5C6F3),
                //       shape: const RoundedRectangleBorder(
                //         borderRadius: BorderRadius.only(
                //           topLeft: Radius.circular(1),
                //           topRight: Radius.circular(1),
                //           bottomLeft: Radius.circular(12),
                //           bottomRight: Radius.circular(12),
                //         ),
                //         side: BorderSide(width: 0.2, color: Colors.grey),
                //       ),
                //       secondary: const Icon(
                //         Icons.wifi_off_outlined,
                //         color: Colors.black,
                //       ),
                //       title: const Text(
                //         "Share with no internet",
                //         textAlign: TextAlign.start,
                //         style: TextStyle(
                //           fontSize: 16,
                //           fontWeight: FontWeight.w400,
                //         ),
                //       ),
                //       value: isInternet,
                //       onChanged: (val) {
                //         setState(() {
                //           isInternet = val;
                //         });
                //       }),
                // ),

                ///  share with social
                ///share via Email
                QRCodeScanListTile(
                  title: 'Share Card via Email',
                  bottomRadius: 1,
                  topRadius: 12,
                  iconData: CupertinoIcons.envelope,
                  onTap: shareViaEmail,
                ),

                ///add Card via Text
                QRCodeScanListTile(
                  onTap: shareViaText,
                  title: 'Share Card via Text',
                  bottomRadius: 1,
                  iconData: CupertinoIcons.chat_bubble,
                ),

                QRCodeScanListTile(
                  onTap: shareViaWhatsapp,
                  title: 'Share Card via Whatsapp',
                  bottomRadius: 1,
                  iconData: FontAwesomeIcons.whatsapp,
                ),

                ///Share card via LinkedIn
                QRCodeScanListTile(
                  onTap: () {
                    shareMore();
                  },
                  title: 'Share Card via LinkedIn',
                  bottomRadius: 1,
                  iconData: FontAwesomeIcons.linkedin,
                ),

                ///Share Card via Instagram
                QRCodeScanListTile(
                  onTap: () {
                    shareViaInstagram(Share.share_system);
                  },
                  title: 'Share Card via Instagram',
                  bottomRadius: 1,
                  iconData: FontAwesomeIcons.instagram,
                ),

                // /// Share card via whatsapp
                // QRCodeScanListTile(
                //   onTap: () {},
                //   title: 'Share Card via Whatsapp',
                //   bottomRadius: 1,
                //   iconData: FontAwesomeIcons.whatsapp,
                // ),

                /// Share another way
                QRCodeScanListTile(
                  onTap: shareOtherWay,
                  title: 'Share another way',
                  iconData: Icons.more_horiz_outlined,
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  /// social share function

  shareViaEmail() async {
    String email = Uri.encodeComponent("");
    String subject = Uri.encodeComponent("Hello Flutter");
    String body = Uri.encodeComponent(
        "Here is my digital business card link : https://biz-card/flutter/QRCode23432");
    print(subject); //output: Hello%20Flutter
    Uri mail = Uri.parse("mailto:$email?subject=$subject&body=$body");
    if (await launchUrl(mail)) {
      canLaunchUrl(mail);
    } else {
      AlertMessage.showMessage(context, "Error while opening Email");
      //email app is not opened
    }
  }

  shareViaText() async {
    /// this is for text message
    Uri sms = Uri.parse('sms:101022?body=hey+dear+friend');
    if (await launchUrl(sms)) {
      canLaunchUrl(sms);
    } else {
      AlertMessage.showMessage(context, "Error while opening Text Message");
    }

    /// this is for call
    // Uri phoneno = Uri.parse('tel:+923081326685');
    // if (await launchUrl(phoneno)) {
    //   canLaunchUrl(phoneno);
    // } else {
    //   AlertMessage.showMessage(context, "Error while opening Text Message");
    // }
  }

  Future<bool?> isInstalled() async {
    final val = await WhatsappShare.isInstalled(package: Package.whatsapp);
    debugPrint('Whatsapp is installed: $val');
    return val;
  }

  shareViaWhatsapp() async {
    isInstalled().then((value) async {
      await WhatsappShare.shareFile(
        filePath: [file!.path],
        text: 'VirtueBizz Card App',
        // linkUrl: 'https://flutter.dev/',
        phone: '911234567890',
      );
    }).catchError((e) {
      AlertMessage.showMessage(context, "No Platform found");
    });
  }

  shareViaInstagram(Share share) async {
    String msg =
        'Flutter share is great!!\n Check out full example at https://pub.dev/packages/flutter_share_me';
    String url = 'https://pub.dev/packages/flutter_share_me';

    String? response;
    final FlutterShareMe flutterShareMe = FlutterShareMe();
    switch (share) {
      case Share.facebook:
        response = await flutterShareMe.shareToFacebook(url: url, msg: msg);
        break;
      case Share.messenger:
        response = await flutterShareMe.shareToMessenger(url: url, msg: msg);
        break;
      case Share.twitter:
        response = await flutterShareMe.shareToTwitter(url: url, msg: msg);
        break;
      case Share.whatsapp:
        response = await flutterShareMe.shareToWhatsApp(
          imagePath: '',
          msg: "Share it",
        );
        // response = await flutterShareMe.shareToWhatsApp(msg: msg);
        break;
      case Share.whatsapp_business:
        response = await flutterShareMe.shareToWhatsApp(msg: msg);
        break;
      case Share.share_system:
        response = await flutterShareMe.shareToSystem(msg: msg);
        break;
      case Share.whatsapp_personal:
        response = await flutterShareMe.shareWhatsAppPersonalMessage(
            message: msg, phoneNumber: 'phone-number-with-country-code');
        break;
      case Share.share_instagram:
        response = await flutterShareMe.shareToInstagram(
          filePath: "abc.txt",
        );
        break;
      case Share.share_telegram:
        response = await flutterShareMe.shareToTelegram(msg: msg);
        break;
    }
    debugPrint(response);
  }

  shareMore() async {
    SocialShare.checkInstalledAppsForShare().then((data) {
      print("checkInstalledAppsForShare : ${data.toString()}");
    });
  }

  shareOtherWay() async {
    final box = context.findRenderObject() as RenderBox?;
    // Share.share('https://bizCard.co/flutter/QRCcode12455',
    //     subject: "Scan QR Code",
    //     sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
  }
}

enum Share {
  facebook,
  messenger,
  twitter,
  whatsapp,
  linkedIn,
  whatsapp_personal,
  whatsapp_business,
  share_system,
  share_instagram,
  share_telegram
}
