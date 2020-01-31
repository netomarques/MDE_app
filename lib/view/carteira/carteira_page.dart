import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mde_app/firebase/firebase_service.dart';
import 'package:mde_app/model/usuario.dart';
import 'package:mde_app/utils/api_response.dart';
import 'package:mde_app/view/carteira/dados_estudantil_page.dart';
import 'package:mde_app/view/carteira/dados_pessoais_page.dart';
import 'package:mde_app/view/carteira/dados_situacao_page.dart';
import 'package:mde_app/view/carteira/qrcode_page.dart';
import 'package:mde_app/widgets/drawer_list.dart';

class CarteiraPage extends StatefulWidget {
  @override
  _CarteiraPageState createState() => _CarteiraPageState();

  Usuario _usuario;
}

class _CarteiraPageState extends State<CarteiraPage> {
  final _streamController = StreamController<Usuario>();
  final _streamPage = StreamController<Widget>();
  final _streamButtonDp = StreamController<Color>();
  final _streamButtonDe = StreamController<Color>();
  final _streamButtonDs = StreamController<Color>();
  final _streamButtonQr = StreamController<Color>();
  StreamController _streamAux;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _inicializarUsuario();
  }

  _inicializarUsuario() async {
    ApiResponse response = await FirebaseService().getDadosUsuarioLogado();
    if (response.ok) {
      _streamController.add(response.result);
      _streamButtonDp.add(Colors.white30);
      _streamAux = _streamButtonDp;
    } else {
      _streamController.addError(response.msg);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        title: Text("MDE"),
        centerTitle: true,
      ),
      body: _body(),
      drawer: DrawerList(),
    );
  }

  _body() {
    return StreamBuilder<Usuario>(
      stream: _streamController.stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(
              snapshot.error,
              style: TextStyle(
                color: Colors.red,
                fontSize: 22,
              ),
            ),
          );
        }

        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        widget._usuario = snapshot.data;
        return _carteira();
      },
    );
  }

  Padding _carteira() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: _conteudoResumido(),
          ),
          Expanded(
            flex: 7,
            child: _conteudo(),
          ),
        ],
      ),
    );
  }

  _conteudoResumido() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
           flex: 3,
            child: _imagemUsuario(),
          ),
          Expanded(
            flex: 6,
            child: _dadosResumo(),
          )
        ],
      ),
    );
  }

  _conteudo() {
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.33,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                _buttonDados(
                    "Dados Pessoais",
                    () => _onClickConteudo(
                        DadosPessoais(widget._usuario), _streamButtonDp),
                    _streamButtonDp),
                _buttonDados(
                    "Dados Estudantil",
                    () => _onClickConteudo(
                        DadosEstudantil(widget._usuario), _streamButtonDe),
                    _streamButtonDe),
                _buttonDados(
                    "QRCODE",
                    () => _onClickConteudo(
                        DadosQrcode(widget._usuario), _streamButtonQr),
                    _streamButtonQr),
                _buttonDados(
                    "Situação",
                    () => _onClickConteudo(
                        DadosSituacao(widget._usuario), _streamButtonDs),
                    _streamButtonDs),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<Widget>(
                stream: _streamPage.stream,
                initialData: DadosPessoais(widget._usuario),
                builder: (context, snapshot) {
                  return Container(
                    color: Colors.white30,
                    child: snapshot.data,
                  );
                }),
          ),
        ],
      ),
    );
  }

  _imagemUsuario() {
    return Container(
      color: Colors.blueAccent,
      child: Image.network("https://ca.portaldeassinaturas.com.br/Repositories/67a8fb49-68f7-4332-8a2e-bddf1817c589/HolderPhoto?id=13098284&pass=NNZ39PXB"),
    );
  }

  /*CircleAvatar(
  backgroundImage: NetworkImage(
  "https://ca.portaldeassinaturas.com.br/Repositories/67a8fb49-68f7-4332-8a2e-bddf1817c589/HolderPhoto?id=13098284&pass=NNZ39PXB",
  ),
  )*/

  _dadosResumo() {
    return Container(
      color: Colors.blueAccent,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _textoResumo(
              widget._usuario.nome
              /*"Ana Beatriz Pereira Medeiros"*/,
              Colors.white,
            ),
            Divider(
              height: (MediaQuery.of(context).size.height * 0.3) * 0.01,
              color: Colors.black,
            ),
            _textoResumo(
              widget._usuario.instituicao
              /*"Centro De Educação Integral C. Master"*/,
              Colors.white70,
              fontSize: 14,
            ),
            _textoResumo(
              widget._usuario.curso
              /*"Ensino Fundamental"*/,
              Colors.white70,
              fontSize: 14,
            ),
          ],
        ),
      ),
    );
  }

  Text _textoResumo(
    String _texto,
    Color _corTexto, {
    double fontSize = 16,
  }) {
    return Text(
      _texto,
      style: TextStyle(
        fontSize: fontSize,
        color: _corTexto,
        fontFamily: "Roboto",
      ),
    );
  }

  _buttonDados(String _nomeBotao, _onPressed, _stream) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: ((MediaQuery.of(context).size.height * 0.2) * 0.4),
        child: StreamBuilder<Color>(
          stream: _stream.stream,
          initialData: Colors.green,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return RaisedButton(
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: Colors.pink,
                child: Text(
                  _nomeBotao,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.center,
                ),
                onPressed: _onPressed,
              );
            }

            return RaisedButton(
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: snapshot.data,
              child: Text(
                _nomeBotao,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
                textAlign: TextAlign.center,
              ),
              onPressed: _onPressed,
            );
          },
        ),
      ),
    );
  }

  void _onClickConteudo(Widget _page, _streamCorButton) {
    if (_streamCorButton != _streamAux) {
      _streamCorButton.add(Colors.white30);
      _streamAux.add(Colors.green);
      _streamAux = _streamCorButton;
      _streamPage.add(_page);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _streamController.close();
    _streamPage.close();
    _streamButtonDp.close();
    _streamButtonDe.close();
    _streamButtonDs.close();
    _streamButtonQr.close();
  }
}
