import 'package:flutter/material.dart';

class DadosQrcode extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Container(
            child: Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  _textoDados("Código de uso: ", Colors.greenAccent),
                  _textoDados("NNZ39PXB", Colors.white70),
                  Expanded(
                    child: _imagemQrcode(),
                  ),
                  _textoDados("www.mde.org.br", Colors.white70),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Text _textoDados(
    String texto,
    Color corTexto, {
    FontStyle fonteStyle = FontStyle.normal,
    FontWeight fontWeight = FontWeight.normal,
  }) {
    return Text(
      texto,
      style: TextStyle(
        fontSize: 15,
        color: corTexto,
        fontFamily: "Roboto",
        fontStyle: fonteStyle,
        fontWeight: fontWeight,
      ),
      textAlign: TextAlign.start,
    );
  }

  _imagemQrcode() {
    return SizedBox.expand(
      child: Image.asset(
        "assets/images/frame.png",
        fit: BoxFit.contain,
      ),
    );
  }
}
