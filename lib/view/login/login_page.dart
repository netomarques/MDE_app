import 'package:flutter/material.dart';
import 'package:mde_app/utils/nav.dart';
import 'package:mde_app/view/carteira/carteira_page.dart';
import 'package:mde_app/widgets/app_text.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  final _tLogin = TextEditingController();

  final _tSenha = TextEditingController();

  final _focusSenha = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MDE"),
        centerTitle: true,
      ),
      body: _body(),
    );
  }

  _body() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Container(
              alignment: Alignment.topCenter,
              child: _imagemLogo(),
            ),
          ),
          Expanded(
            flex: 5,
            child: _form(),
          ),
          Expanded(
            flex: 2,
            child: _buttonLogar(),
          ),
        ],
      ),
    );
  }

  _imagemLogo() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Image.asset(
        "assets/images/logo_mde.png",
        fit: BoxFit.fill,
      ),
    );
  }

  _form() {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: <Widget>[
            AppText(
              "Email",
              "Digite o email",
              controller: _tLogin,
              validator: _validateLogin,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              nextFocus: _focusSenha,
            ),
            SizedBox(height: 10),
            AppText(
              "Senha",
              "Digite a senha",
              password: true,
              controller: _tSenha,
              validator: _validateSenha,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              focusNode: _focusSenha,
            ),
          ],
        ),
      ),
    );
  }

  _buttonLogar() {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: ((MediaQuery.of(context).size.height * 0.2) * 0.5),
        child: RaisedButton(
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: Colors.green,
          child: Text(
            "Entrar",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
            ),
          ),
          onPressed: _onClickLogin,
        ),
      ),
    );
  }

  void _onClickLogin() async {
    if (!_formKey.currentState.validate()) {
      return;
    }

    String login = _tLogin.text;
    String senha = _tSenha.text;

    print("Login: $login, Senha: $senha");

    push(context, CarteiraPage(), replace: true);
  }

  String _validateLogin(String text) {
    if (text.isEmpty) {
      return "Digite o login";
    }
    return null;
  }

  String _validateSenha(String text) {
    if (text.isEmpty) {
      return "Digite a senha";
    }
    if (text.length < 3) {
      return "A senha precisa ter pelo menos 3 números";
    }
    return null;
  }

  @override
  void dispose() {
    super.dispose();
  }

}
