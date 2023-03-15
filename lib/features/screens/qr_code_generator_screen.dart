import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

class QRGeneratorScreen extends StatefulWidget {
  final String? data;
  const QRGeneratorScreen({super.key, this.data});

  @override
  State<StatefulWidget> createState() => QRGeneratorScreenState();
}

class QRGeneratorScreenState extends State<QRGeneratorScreen> {
  static const double _topSectionTopPadding = 50.0;
  static const double _topSectionBottomPadding = 20.0;
  static const double _topSectionHeight = 50.0;

  GlobalKey globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code Generator'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: _captureAndSharePng,
          )
        ],
      ),
      body: _contentWidget(),
    );
  }

  Future<void> _captureAndSharePng() async {
    try {
      RenderRepaintBoundary boundary =
          globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
      var image = await boundary.toImage();
      ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      final tempDir = await getTemporaryDirectory();
      final file = await File('${tempDir.path}/image.png').create();
      log("File in ABC: $file");
      var ed = await file.writeAsBytes(pngBytes);
      log("File in ED: $ed");
      Share.shareXFiles([XFile(ed.path)],
          text: 'Please Scan QR Code', subject: "Scan QR Code");
      // final channel = const MethodChannel('channel:me.alfian.share/share');
      // channel.invokeMethod('shareFile', 'image.png');
    } catch (e) {
      print("Error while sharing QR Code  : ${e.toString()}");
    }
  }

  _contentWidget() {
    final bodyHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).viewInsets.bottom;
    return Container(
      color: const Color(0xFFFFFFFF),
      // height: bodyHeight,
      // width: MediaQuery.of(context).size.width,
      child: Column(
        children: <Widget>[
          Expanded(
            child: Center(
              child: RepaintBoundary(
                key: globalKey,
                child: Container(
                  color: Colors.white,
                  child: QrImage(
                    data: widget.data.toString(),
                    size: 0.5 * bodyHeight,
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
        ],
      ),
    );
  }
}
