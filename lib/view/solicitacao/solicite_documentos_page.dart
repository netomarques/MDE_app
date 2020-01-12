import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mde_app/widgets/app_text_formulario.dart';

class SoliciteDocumentos extends StatefulWidget {
  final _formDocumentosKey = GlobalKey<FormState>();

  @override
  _SoliciteDocumentosState createState() =>
      _SoliciteDocumentosState(_formDocumentosKey);

  get formKey => _formDocumentosKey;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.debug}) {
    // TODO: implement toString
    return "Documentos";
  }
}

class _SoliciteDocumentosState extends State<SoliciteDocumentos> {
  var _formDocumentosKey;

  File _fileFoto;
  File _fileFrenteRG;
  File _fileVersoRG;
  File _fileComprovanteMatricula;

  _SoliciteDocumentosState(this._formDocumentosKey);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formDocumentosKey,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            _imagemDocumento("Foto com fundo branco", _fileFoto, _onClickFoto),
            SizedBox(height: 10),
            _imagemDocumento("Frente do RG ou CNH", _fileFrenteRG, _onClickFrenteRG),
            SizedBox(height: 10),
            _imagemDocumento("Verso do RG ou CNH", _fileVersoRG, _onClickVersoRG),
            SizedBox(height: 10),
            _imagemDocumento(
                "Comprovante de Matricula", _fileComprovanteMatricula, _onClickComprovanteMatricula),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  _imagemDocumento(_text, _file, _onPressed) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            _text,
            style: TextStyle(fontSize: 16),
          ),
          _file != null
              ? Image.file(_file)
              : Image.asset(
                  "assets/images/camera.png",
                  width: MediaQuery.of(context).size.width * 0.3,
                ),
          FloatingActionButton(
            onPressed: _onPressed,
            tooltip: "Selecioner uma imagem ou tirar foto",
            child: Icon(Icons.camera),
          )
        ],
      ),
    );
  }

  String _validateCampo(String text) {
    if (text.isEmpty) {
      return "Campo vazio";
    }
    return null;
  }

  String nomeForm() {
    return "Dados Escolares";
  }

  formKey() {
    return _formDocumentosKey;
  }

  void _onClickImage(_file) async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    print(_file);
    setState(() {
      _file = image;
    });

    print(_file);
  }

  void _onClickFoto() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _fileFoto = image;
    });
  }

  void _onClickFrenteRG() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _fileFrenteRG = image;
    });
  }

  void _onClickVersoRG() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _fileVersoRG = image;
    });
  }

  void _onClickComprovanteMatricula() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _fileComprovanteMatricula = image;
    });
  }
}
