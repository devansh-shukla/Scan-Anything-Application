import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:textrecognition/mlkitdemo.dart';
import 'dart:io';

const String TEXT_SCANNER = 'TEXT_SCANNER';
const String BARCODE_SCANNER = 'BARCODE_SCANNER';
const String LABEL_SCANNER = 'LABEL_SCANNER';
const String FACE_SCANNER = 'FACE_SCANNER';

class SelectScanner4 extends StatefulWidget {
  @override
  _SelectScanner4State createState() {
    return _SelectScanner4State();
  }
}

class _SelectScanner4State extends State<SelectScanner4> {
  static const String CAMERA_SOURCE = 'CAMERA_SOURCE';
  static const String GALLERY_SOURCE = 'GALLERY_SOURCE';

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


  String _selectedScanner = FACE_SCANNER;

  @override
  Widget build(BuildContext context) {
    final columns = List<Widget>();
    columns.add(buildRowTitle(context, 'Pick Image'));
    columns.add(buildSelectImageRowWidget(context));
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Scan Face',
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
            children: columns,
          )),
    );
  }

  Widget buildRowTitle(context, String title) {
    return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
          child: Text(
            title,
            style: Theme
                .of(context)
                .textTheme
                .headline,
          ),
        ));
  }

  Widget buildSelectImageRowWidget(context) {
    return Column(
      children: <Widget>[
        Container(height: 200,),
        Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: SizedBox(
                    width: 200,
                    height: 100,
                    child: RaisedButton.icon(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      color: Colors.blueAccent,
                      textColor: Colors.white,
                      splashColor: Colors.blueGrey,
                      icon: Icon(Icons.camera),
                      label: Text('Camera'),
                      onPressed: () {
                        onPickImageSelected(CAMERA_SOURCE);
                      },
                    ),
                  )),
            ),
            Expanded(
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 9.0),
                    child: SizedBox(
                      width: 200,
                      height: 100,
                      child: RaisedButton.icon(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        color: Colors.redAccent,
                        textColor: Colors.white,
                        splashColor: Colors.blueGrey,
                        icon: Icon(Icons.image),
                        label: Text('Gallery'),
                        onPressed: () {
                          onPickImageSelected(GALLERY_SOURCE);
                        },
                      ),
                    ))),
          ],
        ),
      ],
    );
  }

  Widget buildImageRow(BuildContext context, File file) {
    return SizedBox(
      height: 500,
      child: Image.file(
        file,
        fit: BoxFit.fitWidth,
      ),
    );
  }

  Widget buildDeleteRow(BuildContext context) {
    File _file;
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: RaisedButton(
          color: Colors.red,
          textColor: Colors.white,
          splashColor: Colors.blueGrey,
          onPressed: () {
            setState(() {
              _file = null;
            });
          },
          child: const Text('Delete Image'),
        ),
      ),
    );
  }

  void onScannerSelected(String scanner) {
    setState(() {
      _selectedScanner = scanner;
    });
  }

  void onPickImageSelected(String source) async {
    var imageSource;
    if (source == CAMERA_SOURCE) {
      imageSource = ImageSource.camera;
    } else {
      imageSource = ImageSource.gallery;
    }

    final scaffold = _scaffoldKey.currentState;

    try {
      // ignore: deprecated_member_use
      final file = await ImagePicker.pickImage(source: imageSource);
      if (file == null) {
        throw Exception('File is not available');
      }

      Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => MLkitDemo(file, _selectedScanner)),
      );
    } catch (e) {
      scaffold.showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
    }
  }
}