import 'package:flutter/material.dart';
import 'package:mde_app/utils/nav.dart';
import 'package:mde_app/view/home_page.dart';

class SoliciteFim extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("MDE - Solicite"),
      ),
      body: _body(context),
    );
  }

  _body(context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            Text(
              "Após validarmos seus dados, enviaremos um email para o endereço de email informado com as orientações dos próximos passos em até 5 dias úteis para finalizar a solicitação da carteira MDE.",
              style: TextStyle(color: Colors.white70, fontSize: 18),
              textAlign: TextAlign.justify,
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Obrigado!",
              style: TextStyle(color: Colors.white70, fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 30,
            ),
            RaisedButton(
              color: Colors.teal,
              onPressed: () => {push(context, HomePage(), replace: true)},
              child: Text(
                "OK",
                style: TextStyle(fontSize: 30, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
