import 'package:flutter/material.dart';
import 'package:mde_app/view/solicitacao/solicite_dados_escolares_page.dart';
import 'package:mde_app/view/solicitacao/solicite_dados_pessoais_page.dart';
import 'package:mde_app/view/solicitacao/solicite_documentos_page.dart';
import 'package:mde_app/widgets/app_text_formulario.dart';

class Solicite extends StatefulWidget {
  @override
  _SoliciteState createState() => _SoliciteState();
}

class _SoliciteState extends State<Solicite> {

  /*final _formDadosEscolaresKey = GlobalKey<FormState>();
  final _formDadosPessoaisKey = GlobalKey<FormState>();*/

  var _formAtual;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _formAtual =  SoliciteDadosPessoais();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("MDE - Solicite"),
      ),
      body: _body(),
    );
  }

  _body() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  "Quais são os seus dados",
                  style: TextStyle(color: Colors.green, fontSize: 22),
                ),
              ),
            ),
            Expanded(
              flex: 9,
              child: ListView(
                children: <Widget>[
                  _formAtual,
                  _containerButtons(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _containerButtons() {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _buttonVoltar(),
          _buttonContinuar(),
        ],
      ),
    );
  }

  _buttonContinuar() {
    return Container(
      height: 40,
      width: 120,
      child: RaisedButton(
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: Colors.green,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text(
              "Continuar",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
              size: 16,
            ),
          ],
        ),
        onPressed: _onClickContinuar,
      ),
    );
  }

  _buttonVoltar() {
    return Container(
      height: 40,
      width: 120,
      child: RaisedButton(
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: Colors.green,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 16,
            ),
            Text(
              "Voltar",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ],
        ),
        onPressed: _onClickVoltar,
      ),
    );
  }

  bool _validarCampos(formKey) {
    if(formKey.currentState.validate()){
      return true;
    } else {
      return false;
    }
  }

  void _onClickContinuar(){
    var form;
    
    if(! _validarCampos(_formAtual.formKey)){
      return;
    }

    if(_formAtual.toString() == "Dados Pessoais"){
      form = SoliciteDadosEscolares();
    } else if(_formAtual.toString() == "Dados Escolares") {
      form = SoliciteDocumentos();
    } else if(_formAtual.toString() == "Documentos") {
      return;
    }

    setState(() {
      _formAtual = form;
    });
  }

  void _onClickVoltar(){
    var form;

    if(_formAtual.toString() == "Documentos"){
      form = SoliciteDadosEscolares();
    } else if(_formAtual.toString() == "Dados Escolares"){
      form = SoliciteDadosPessoais();
    } else if(_formAtual.toString() == "Dados Pessoais") {
      print("Ok ");
      return;
    }

    setState(() {
      _formAtual = form;
    });
  }

}
