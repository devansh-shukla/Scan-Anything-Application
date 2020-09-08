import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:url_launcher/url_launcher.dart';

class QRScan extends StatefulWidget {
  @override
  _QRScanState createState() {
    return _QRScanState();
  }
}

class _QRScanState extends State<QRScan> {
  String result = 'Hello There!';

  Future _scanQR() async {
    try {
      String qrResult = await BarcodeScanner.scan();
      setState(() {
        checkingValue(qrResult);
      });
    } on PlatformException catch (ex) {
      if (ex.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          result = "Camera permission was denied";
        });
      } else {
        setState(() {
          result = "Unknown Error $ex";
        });
      }
    } on FormatException {
      setState(() {
        result = "You pressed the back button before scanning anything";
      });
    } catch (ex) {
      setState(() {
        result = "Unknown Error $ex";
      });
    }
  }

  checkingValue(String url) {
    if (url != null || url != "") {
      return _launchURL(url);
    } else {
      return null;
    }
  }

  _launchURL(String urlQRCode) async {
    String url = urlQRCode;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Scan QR Code',
          )),
      body: Column(
        children: <Widget>[
          Container(
            height: 300,
          ),
//
//            child: RaisedButton.icon(
//              shape: RoundedRectangleBorder(
//                  borderRadius: BorderRadius.circular(50)),
//              icon: Icon(Icons.camera),
//              label: Text('Scan QR Code'),
//              onPressed: () {
//                _scanQR();
//                print(result);
//              },
//              color: Colors.white70,
//            ),
//          ),
          SizedBox(
            width: 150,
            height: 60,
            child: FloatingActionButton.extended(
              onPressed: _scanQR,
              label: Text('Scan'),
              icon: Icon(Icons.camera),
            ),
          )
        ],
      ),
    );
  }
}
