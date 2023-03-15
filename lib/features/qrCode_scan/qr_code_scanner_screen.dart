import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:biz_card/core/helpers/helpers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

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
  QRViewController? controller1;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  StreamSubscription<Barcode>? streamSubscription;
  // final GlobalKey<QRViewController> qrKey1 = GlobalKey();
  String qrText = "";
  File? _pickedImage;
  bool isResumeCamera = true;

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
    controller1?.resumeCamera();
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
    // setState(() {
    this.controller = controller;
    // });
    // streamSubscription?.cancel();
    // streamSubscription =
    controller.scannedDataStream.listen((scanData) {
      if (mounted) {
        controller.pauseCamera();
        controller.dispose();
        setState(() {
          result = scanData;
          print("Data: $result");
        });
        _launchURL(scanData.code.toString());
      }
    });
  }

  Future<void> pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      _onQRViewCreated1(
        controller!,
      );
      // final imageBytes = File(pickedImage.path).readAsBytesSync();
      // log("PickedImageByte: $imageBytes");
      // await scanQRCodeFromImage(File(pickedImage.path));
      // final qrCode = await QRCodeReader().decode(imageBytes);
      // streamSubscription?.cancel();
      // streamSubscription =
      // setState(() {
      //   print("Data from image: ${scanData.rawBytes}");
      // });
      ///
      // controller?.scannedDataStream.listen((scanData) {
      //   setState(() {
      //     print("Data from image: ${scanData.rawBytes}");
      //   });
      //   _launchURL(scanData.code.toString());
      // });

    }
  }

  void _onQRViewCreated1(QRViewController controller) {
    log("function call");
    this.controller = controller1;
    controller.scannedDataStream.listen((scanData) async {
      controller.pauseCamera();
      if (await canLaunchUrl(Uri.parse("${scanData.code}"))) {
        await launchUrl(Uri.parse("${scanData.code}"));
        controller.resumeCamera();
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Could not find viable url'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text('Barcode Type: ${describeEnum(scanData.format)}'),
                    Text('Data: ${scanData.code}'),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Ok'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        ).then((value) => controller.resumeCamera());
      }
    });
  }

  Future<void> scanQRCodeFromImage(File file) async {
    final bytes = await file.readAsBytes();
    String bar = utf8.decode(bytes);
    log("Image Response: ${bar}");

    // final controller = QRViewController(
    //   key: qrKey,
    //   options: QRCodeOptions(
    //     formats: const [QRCodeFormat.qr],
    //     tryHarder: true,
    //   ),
    // );
    // await controller.prepareScanner();
    // controller.resumeCamera();
    // await controller.scannedDataStream(bytes);
  }

  _launchURL(String url) async {
    if (result != null) {
      // Check if the scanned data contains a URL
      final RegExp regExp = RegExp(r'(http|https):\/\/[^\s]+');
      if (regExp.hasMatch("${result?.rawBytes?.first.toString()}")) {
        // Open the URL in the default browser
        if (await canLaunchUrl(Uri.parse(url))) {
          await launchUrl(Uri.parse(url));
        } else {
          throw 'Could not launch ${result?.rawBytes}';
        }
      } else {
        // Show an alert dialog if the scanned data is not a URL
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Scan Result'),
              content: Text("${result?.rawBytes.toString()}"),
              actions: <Widget>[
                ElevatedButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    }
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
    streamSubscription?.cancel();
    controller?.dispose();
    super.dispose();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

///

class ScannerQR extends StatefulWidget {
  @override
  _ScannerQRState createState() => _ScannerQRState();
}

class _ScannerQRState extends State<ScannerQR> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scanner"),
      ),
      body: Stack(
        children: [
          Column(
            children: <Widget>[
              Expanded(
                flex: 5,
                child: Stack(
                  children: [
                    QRView(
                      key: qrKey,
                      onQRViewCreated: _onQRViewCreated,
                    ),
                    Center(
                      child: Container(
                        width: 300,
                        height: 300,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.red,
                            width: 4,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Center(
                  child: Text('Scan a code'),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      controller.pauseCamera();
      if (await canLaunchUrl(Uri.parse(scanData.code.toString()))) {
        await launchUrl(Uri.parse(scanData.code.toString()));
        controller.resumeCamera();
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Could not find viable url'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text('Barcode Type: ${describeEnum(scanData.format)}'),
                    Text('Data: ${scanData.code}'),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Ok'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        ).then((value) => controller.resumeCamera());
      }
    });
  }
}

///
class QRScanner extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  final GlobalKey _qrKey = GlobalKey();
  QRViewController? _controller;
  bool _scanned = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('QR Scanner')),
      body: Column(
        children: [
          Expanded(
            child: QRView(
              key: _qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          if (_scanned)
            ElevatedButton(onPressed: _launchURL, child: Text('Open Link')),
        ],
      ),
    );
  }

  var data;
  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      _controller = controller;
    });
    _controller?.scannedDataStream.listen((scanData) {
      setState(() {
        data = scanData.code;
        _scanned = true;
      });
    });
    _controller?.resumeCamera();
  }

  void _launchURL() async {
    if (await canLaunchUrl(Uri.parse(data))) {
      await launchUrl(Uri.parse(data));
    } else {
      throw 'Could not launch ${_controller?.scannedDataStream}';
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
