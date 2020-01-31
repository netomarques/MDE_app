import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mde_app/model/usuario.dart';

class DadosSituacao extends StatelessWidget {
  BuildContext _context;
  Usuario _usuario;

  DadosSituacao(this._usuario);

  @override
  Widget build(BuildContext context) {
    this._context = context;
    var _dateFormat = DateFormat("MM/yyyy");

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _cardDados(
            _textoDados(
              "Numero Carteira: ",
              Colors.greenAccent,
            ),
            _textoDados(this._usuario.numeroCarteira/*"RSM24288/19"*/, Colors.white70),
          ),
          _cardDados(
            _textoDados("Validade: ", Colors.greenAccent),
            _textoDados(/*"02/2020"*/ _dateFormat.format(this._usuario.validade), Colors.white70),
          ),
          _cardDados(
            _textoDados("Situação: ", Colors.greenAccent),
            _textoDados(_usuario.situacao, Colors.white70),
          ),
          _cardObservacao(
            _textoDados("Observações: ", Colors.greenAccent),
            _textoDados(
                "Valida em todo o território Nacional e Internacional Lei"
                " Federal 12.933/2013 e Lei Estadual 311/2016 AM. Tratados"
                " Internacionais Decretos 7.030/2009 Artigo 33.",
                Colors.white70),
          ),
        ],
      ),
    );
  }

  Container _cardDados(Text _dados, Text _metadados) {
    return Container(
      height: (MediaQuery.of(this._context).size.height * 0.6) * 0.1,
      width: MediaQuery.of(this._context).size.width * 0.63,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            /*width: (MediaQuery.of(this._context).size.width * 0.63) * 0.3,*/
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

  Container _cardObservacao(Text _dados, Text _metadados) {
    return Container(
      height: (MediaQuery.of(this._context).size.height * 0.6) * 0.4,
      width: MediaQuery.of(this._context).size.width * 0.63,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            /*width: (MediaQuery.of(this._context).size.width * 0.63) * 0.3,*/
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
      textAlign: TextAlign.justify,
    );
  }
}
