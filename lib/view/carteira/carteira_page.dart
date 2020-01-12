import 'package:flutter/material.dart';
import 'package:mde_app/view/carteira/dados_estudantil_page.dart';
import 'package:mde_app/view/carteira/dados_pessoais_page.dart';
import 'package:mde_app/view/carteira/dados_situacao_page.dart';
import 'package:mde_app/view/carteira/qrcode_page.dart';
import 'package:mde_app/widgets/drawer_list.dart';

class CarteiraPage extends StatefulWidget {
  @override
  _CarteiraPageState createState() => _CarteiraPageState();
}

class _CarteiraPageState extends State<CarteiraPage> {
  Widget _page = DadosPessoais();

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
            child: _imagemUsuario(),
          ),
          Expanded(
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
                    "Dados Pessoais", () => _onClickConteudo(DadosPessoais())),
                _buttonDados("Dados Estudantil",
                    () => _onClickConteudo(DadosEstudantil())),
                _buttonDados("QRCODE", () => _onClickConteudo(DadosQrcode())),
                _buttonDados(
                    "Situação", () => _onClickConteudo(DadosSituacao())),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white30,
              child: _page,
            ),
          )
        ],
      ),
    );
  }

  _imagemUsuario() {
    return Container(
      color: Colors.blueAccent,
      child: SizedBox.expand(
        child: CircleAvatar(
          backgroundImage: NetworkImage(
            "https://ca.portaldeassinaturas.com.br/Repositories/67a8fb49-68f7-4332-8a2e-bddf1817c589/HolderPhoto?id=13098284&pass=NNZ39PXB",
          ),
        ),
      ),
    );
  }

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
              "Ana Beatriz Pereira Medeiros",
              Colors.white,
            ),
            Divider(
              height: (MediaQuery.of(context).size.height * 0.3) * 0.01,
              color: Colors.black,
            ),
            _textoResumo(
              "Centro De Educação Integral C. Master",
              Colors.white70,
              fontSize: 14,
            ),
            _textoResumo(
              "Ensino Fundamental",
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

  _buttonDados(String _nomeBotao, _onPressed) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: ((MediaQuery.of(context).size.height * 0.2) * 0.4),
        child: RaisedButton(
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: Colors.green,
          child: Text(
            _nomeBotao,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
            textAlign: TextAlign.center,
          ),
          onPressed: _onPressed,
        ),
      ),
    );
  }

  void _onClickConteudo(Widget _page) {
    setState(() {
      this._page = _page;
      print((MediaQuery.of(context).size.height));
      print((MediaQuery.of(context).size.width));
    });
  }
}
