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

  File _imagemSelecionadaAux;
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
            _imagemDocumento("Foto com fundo branco", _onClickFoto, _fileFoto),
            SizedBox(height: 30),
            _imagemDocumento(
                "Frente do RG ou CNH", _onClickFrenteRG, _fileFrenteRG),
            SizedBox(height: 30),
            _imagemDocumento(
                "Verso do RG ou CNH", _onClickVersoRG, _fileVersoRG),
            SizedBox(height: 30),
            _imagemDocumento("Comprovante de Matricula",
                 _onClickComprovanteMatricula, _fileComprovanteMatricula),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  _imagemDocumento(text, onTap, file) {
    return Container(
      child: Column(
        children: <Widget>[
          Text(
            text,
            style: TextStyle(fontSize: 16, color: Colors.green),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: onTap,
              child: file != null
                  ? Image.file(file)
                  : Image.asset(
                "assets/images/camera.png",
                width: MediaQuery.of(context).size.width * 0.3,
              ),
            ),
          ),
          Text(
            "Clique na imagem",
            style: TextStyle(fontSize: 10),
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


  void _onClickFoto() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);

    if(image !=null){
      setState(() {
        _fileFoto = image;
      });
    }
  }

  void _onClickFrenteRG() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);

    if(image !=null){
      setState(() {
        _fileFrenteRG = image;
      });
    }
  }

  void _onClickVersoRG() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);

    if(image !=null){
      setState(() {
        _fileVersoRG = image;
      });
    }
  }

  void _onClickComprovanteMatricula() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);

    if(image !=null){
      setState(() {
        _fileComprovanteMatricula = image;
      });
    }
  }
}
