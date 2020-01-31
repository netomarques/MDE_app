import 'package:flutter/material.dart';
import 'package:mde_app/model/usuario.dart';

class DadosEstudantil extends StatelessWidget {
  BuildContext _context;
  Usuario _usuario;

  DadosEstudantil(this._usuario);

  @override
  Widget build(BuildContext context) {
    this._context = context;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _cardDados(
            _textoDados(
              "Instituição de Ensino: ",
              Colors.greenAccent,
            ),
            _textoDados(
                "Centro de Educação Integral C. Master ", Colors.white70),
          ),
          _cardDados(
            _textoDados("Cursando: ", Colors.greenAccent),
            _textoDados("Ensino Fundamental", Colors.white70),
          ),
          _cardDados(
            _textoDados("Matricula: ", Colors.greenAccent),
            _textoDados("13098284", Colors.white70),
          ),
        ],
      ),
    );
  }

  Container _cardDados(Text _dados, Text _metadados) {
    return Container(
      height: (MediaQuery.of(this._context).size.height * 0.6) * 0.15,
      /*width: MediaQuery.of(this._context).size.width * 0.63,*/
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            /*width: MediaQuery.of(this._context).size.width * 0.63,*/
            child: _dados,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 10),
              child: _metadados,
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
}
