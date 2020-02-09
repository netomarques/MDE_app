import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mde_app/utils/alert.dart';
import 'package:mde_app/view/solicitacao/solicite_bloc.dart';
import 'package:mde_app/widgets/buttons_formulario.dart';

class SoliciteDocumentos extends StatefulWidget {
  SoliciteBloc _bloc;

  SoliciteDocumentos(this._bloc);

  @override
  _SoliciteDocumentosState createState() => _SoliciteDocumentosState();
}

class _SoliciteDocumentosState extends State<SoliciteDocumentos> {
  final _formKey = GlobalKey<FormState>();

  StreamController _streamFoto = StreamController<File>();
  StreamController _streamFrenteRG = StreamController<File>();
  StreamController _streamVersoRG = StreamController<File>();
  StreamController _streamComprovanteMatricula = StreamController<File>();
  StreamController _streamCpf = StreamController<File>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _preecherCampos();
  }

  _preecherCampos(){
    if(widget._bloc.solicitacao.foto != null)
      _streamFoto.add(widget._bloc.solicitacao.foto);

    if(widget._bloc.solicitacao.frenteRgCnh != null)
      _streamFrenteRG.add(widget._bloc.solicitacao.frenteRgCnh);

    if(widget._bloc.solicitacao.versoRgCnh != null)
      _streamVersoRG.add(widget._bloc.solicitacao.versoRgCnh);

    if(widget._bloc.solicitacao.fotoCpf != null)
      _streamCpf.add(widget._bloc.solicitacao.fotoCpf);

    if(widget._bloc.solicitacao.comprovanteMatricula != null)
      _streamComprovanteMatricula.add(widget._bloc.solicitacao.comprovanteMatricula);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Form(
          key: _formKey,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white70,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                _containerDocumento(
                    "Foto com fundo branco", _streamFoto, _adicionarFoto),
                SizedBox(height: 30),
                _containerDocumento(
                    "Frente do RG/CNH", _streamFrenteRG, _adicionarFrenteRgCnh),
                SizedBox(height: 30),
                _containerDocumento(
                    "Verso do RG/CNH", _streamVersoRG, _adicionarVersoRgCnh),
                SizedBox(height: 30),
                _containerDocumento("Cpf", _streamCpf, _adicionarCpf),
                SizedBox(height: 30),
                _containerDocumento(
                    "Comprovante de matricula",
                    _streamComprovanteMatricula,
                    _adicionarComprovanteMatricula),
              ],
            ),
          ),
        ),
        ButtonsFormulario(_onClickVoltar, _onClickContinuar),
      ],
    );
  }

  _containerDocumento(
      String _titulo, StreamController _streamController, Function _function) {
    return Container(
      /*height: MediaQuery.of(context).size.height * 0.1,*/
      child: InputDecorator(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          labelText: _titulo,
          labelStyle: TextStyle(fontSize: 16, color: Colors.indigo),
        ),
        child: StreamBuilder<File>(
            stream: _streamController.stream,
            /*initialData: -1,*/
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Container();
              }

              if (snapshot.hasData) {
                _function(snapshot.data);
              }

              return _imagemDocumento(
                  () => _selecionarImagem(_streamController), snapshot.data);
            }),
      ),
    );
  }

  _imagemDocumento(onTap, file) {
    return Container(
      child: Column(
        children: <Widget>[
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

  void _selecionarImagem(StreamController _stream) async {
    await _cameraOuGaleria(_stream);
  }

  Future<void> _cameraOuGaleria(_stream) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: new SingleChildScrollView(
              child: new ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: new Text('Camera'),
                    onTap: () => _abrirCamera(_stream),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  GestureDetector(
                    child: new Text('Galeria'),
                    onTap: () => _abrirGaleria(_stream),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<void> _abrirCamera(_stream) async {
    File _imagem = await ImagePicker.pickImage(source: ImageSource.camera);
    if (_imagem != null) _stream.add(_imagem);

    Navigator.pop(context);
  }

  Future<void> _abrirGaleria(_stream) async {
    File _imagem = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (_imagem != null) _stream.add(_imagem);

    Navigator.pop(context);
  }

  _adicionarFoto(_file) {
    widget._bloc.solicitacao.foto = _file;
  }

  _adicionarFrenteRgCnh(_file) {
    widget._bloc.solicitacao.frenteRgCnh = _file;
  }

  _adicionarVersoRgCnh(_file) {
    widget._bloc.solicitacao.versoRgCnh = _file;
  }

  _adicionarCpf(_file) {
    widget._bloc.solicitacao.fotoCpf = _file;
  }

  _adicionarComprovanteMatricula(_file) {
    widget._bloc.solicitacao.comprovanteMatricula = _file;
  }

  _onClickContinuar() {
    if (!_validarCampos()) {
      return;
    }

    print("Continuaaaaaaaaaaaaar");
  }

  _onClickVoltar() {
    widget._bloc.voltarForm();
  }

  _validarCampos() {
    if (widget._bloc.solicitacao.foto == null) {
      alert(context, "Necessário informar uma foto com fundo branco");
      return false;
    } else if (widget._bloc.solicitacao.frenteRgCnh == null) {
      alert(context,
          "Necessário informar uma foto da frente do documento RG ou CNH");
      return false;
    } else if (widget._bloc.solicitacao.versoRgCnh == null) {
      alert(context,
          "Necessário informar uma foto do verso do documento RG ou CNH");
      return false;
    } else if (widget._bloc.solicitacao.fotoCpf == null) {
      alert(context, "Necessário informar uma foto do documento CPF");
      return false;
    } else if (widget._bloc.solicitacao.comprovanteMatricula == null) {
      alert(context, "Necessário informar o comprovante de matricula");
      return false;
    }

    return true;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _streamComprovanteMatricula.close();
    _streamVersoRG.close();
    _streamFrenteRG.close();
    _streamFoto.close();

    super.dispose();
  }
}
