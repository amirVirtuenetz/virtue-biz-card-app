import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

class QRCodeScannerScreen extends StatefulWidget {
  const QRCodeScannerScreen({Key? key}) : super(key: key);

  @override
  _QRCodeScannerScreenState createState() => _QRCodeScannerScreenState();
}

class _QRCodeScannerScreenState extends State<QRCodeScannerScreen>
    with SingleTickerProviderStateMixin {
  BarcodeCapture? barcode;

  final MobileScannerController controller = MobileScannerController(
    torchEnabled: false, formats: [BarcodeFormat.all],

    // facing: CameraFacing.front,
    // detectionSpeed: DetectionSpeed.normal
    // detectionTimeoutMs: 1000,
    // returnImage: false,
  );
  File? qrImage;
  bool isStarted = true;

  void _startOrStop() {
    try {
      if (isStarted) {
        controller.stop();
      } else {
        controller.start();
      }
      setState(() {
        isStarted = !isStarted;
      });
    } on Exception catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Something went wrong! $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void pickImageFromGallery() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
      );
      if (image != null) {
        // launchInBrowser(Uri.parse("https://www.google.com"));
        log("Image  abs: ${image.path}");
        if (await controller.analyzeImage(image.path)) {
          setState(() {
            qrImage = File(image.path);
          });
          log(" qrImage =$qrImage");
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('QR Code Found!'),
              backgroundColor: Colors.green,
            ),
          );
        } else {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('No qrcode found!'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      log("QR Scan Error ${e}");
    }
  }

  Future<void> launchInBrowser(Uri url) async {
    if (await canLaunchUrl(
      url,
    )) {
      await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
    } else {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Builder(
        builder: (context) {
          return Stack(
            children: [
              MobileScanner(
                controller: controller,
                errorBuilder: (context, error, child) {
                  return Center(
                    child: Text("Error: ${error.errorDetails}"),
                  );
                },
                fit: BoxFit.cover,
                onDetect: (barcode) async {
                  setState(() {
                    this.barcode = barcode;
                    log("Bar Code Detail: ${barcode.barcodes.first.rawValue}");
                  });
                  Map<String, dynamic> jsonMap =
                      jsonDecode("${barcode.barcodes.first.rawValue}");
                  // barcode.barcodes.first.rawBytes.toString()
                  print("Link url : ${jsonMap['profileLink']}");
                  launchInBrowser(Uri.parse(jsonMap['profileLink']));
                },
              ),
              Positioned(
                bottom: 40,
                // width: screenWidth(context),
                left: 10,
                right: 10,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white12,
                            shadowColor: Colors.transparent,
                            minimumSize: const Size(50, 50),
                            maximumSize: const Size(50, 50),
                            elevation: 0,
                            side:
                                const BorderSide(width: 1, color: Colors.white),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          onPressed: pickImageFromGallery,
                          child: const SizedBox(),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 6.0),
                          child: Text(
                            "Upload",
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                      ],
                    ),

                    ///
                    // IconButton(
                    //   color: Colors.white,
                    //   icon: const Icon(Icons.image),
                    //   iconSize: 32.0,
                    //   onPressed: () async {
                    //     final ImagePicker picker = ImagePicker();
                    //     final XFile? image = await picker.pickImage(
                    //       source: ImageSource.gallery,
                    //     );
                    //     if (image != null) {
                    //       if (await controller.analyzeImage(image.path)) {
                    //         if (!mounted) return;
                    //         ScaffoldMessenger.of(context).showSnackBar(
                    //           const SnackBar(
                    //             content: Text('QR Code Found!'),
                    //             backgroundColor: Colors.green,
                    //           ),
                    //         );
                    //       } else {
                    //         if (!mounted) return;
                    //         ScaffoldMessenger.of(context).showSnackBar(
                    //           const SnackBar(
                    //             content: Text('No qrcode found!'),
                    //             backgroundColor: Colors.red,
                    //           ),
                    //         );
                    //       }
                    //     }
                    //   },
                    // ),
                    ///
                    // Center(
                    //   child: SizedBox(
                    //     width: MediaQuery.of(context).size.width - 200,
                    //     height: 50,
                    //     child: FittedBox(
                    //       child: Text(
                    //         // barcode?.barcodes.first.rawValue ??
                    //         'Scan qrcode!',
                    //         overflow: TextOverflow.fade,
                    //         style: Theme.of(context)
                    //             .textTheme
                    //             .headlineMedium!
                    //             .copyWith(color: Colors.white),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    IconButton(
                      color: Colors.white,
                      icon: isStarted
                          ? const Icon(Icons.stop)
                          : const Icon(Icons.play_arrow),
                      iconSize: 32.0,
                      onPressed: _startOrStop,
                    ),
                    ValueListenableBuilder(
                      valueListenable: controller.hasTorchState,
                      builder: (context, state, child) {
                        if (state != true) {
                          return const SizedBox.shrink();
                        }
                        return IconButton(
                          color: Colors.white,
                          icon: ValueListenableBuilder(
                            valueListenable: controller.torchState,
                            builder: (context, state, child) {
                              if (state == null) {
                                return const Icon(
                                  Icons.flash_off,
                                  color: Colors.grey,
                                );
                              }
                              switch (state as TorchState) {
                                case TorchState.off:
                                  return const Icon(
                                    Icons.flash_off,
                                    color: Colors.grey,
                                  );
                                case TorchState.on:
                                  return const Icon(
                                    Icons.flash_on,
                                    color: Colors.yellow,
                                  );
                              }
                            },
                          ),
                          iconSize: 32.0,
                          onPressed: () => controller.toggleTorch(),
                        );
                      },
                    ),

                    ///
                    // IconButton(
                    //   color: Colors.white,
                    //   icon: ValueListenableBuilder(
                    //     valueListenable: controller.cameraFacingState,
                    //     builder: (context, state, child) {
                    //       if (state == null) {
                    //         return const Icon(Icons.camera_front);
                    //       }
                    //       switch (state as CameraFacing) {
                    //         case CameraFacing.front:
                    //           return const Icon(Icons.camera_front);
                    //         case CameraFacing.back:
                    //           return const Icon(Icons.camera_rear);
                    //       }
                    //     },
                    //   ),
                    //   iconSize: 32.0,
                    //   onPressed: () => controller.switchCamera(),
                    // ),
                    ///
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
