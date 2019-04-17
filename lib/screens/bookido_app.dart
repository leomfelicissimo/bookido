import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';

final TextRecognizer textRecognizer = FirebaseVision.instance.textRecognizer();

class BookidoApp extends StatefulWidget {
  @override
  _BookidoState createState() => _BookidoState();
}

class _BookidoState extends State<BookidoApp> {
  File _image;
  String _visionText;

  Future extractTextFromImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    var visionImage = FirebaseVisionImage.fromFile(image);
    var recognizerResult = await textRecognizer.processImage(visionImage);
    var visionText =
        recognizerResult != null ? recognizerResult.text : 'Não detectado';

    setState(() {
      _image = image;
      _visionText = visionText;
    });
  }

  Widget getBodyContent() {
    if (_image != null && _visionText != null) {
      return ListView(
        children: <Widget>[
          Image.file(_image),
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              _visionText,
              softWrap: true,
            ),
          ),
        ],
      );
    } else {
      const textStyle = TextStyle(
        color: Colors.blue,
        fontSize: 24.0,
        fontWeight: FontWeight.w900,
        fontFamily: 'Georgia',
      );

      return Center(
          child: Container(
              child: Center(
                  child: Text('Clique no botão captura para obter uma imagem.',
                      style: textStyle)),
              width: 200.0,
              height: 240.0));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bookido',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Bookido'),
        ),
        body: Container(
          child: getBodyContent(),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add_a_photo),
          tooltip: 'Tirar uma foto',
          onPressed: extractTextFromImage,
        ),
      ),
    );
  }
}
