import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mde_app/model/usuario.dart';

class DadosPessoais extends StatelessWidget {
  BuildContext _context;
  Usuario _usuario;


  DadosPessoais(this._usuario);

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
              "Nome: ",
              Colors.greenAccent,
            ),
            _textoDados(_usuario.nome, Colors.white70),
          ),
          _cardFiliacao(
            _textoDados("Filiação: ", Colors.greenAccent),
            _textoDados(_usuario.mae, Colors.white70),
            _textoDados(_usuario.pai, Colors.white70),
          ),
          _cardDados(
            _textoDados("Data de Nascimento: ", Colors.greenAccent),
            _textoDados(_dateFormat.format(_usuario.dtAniversario), Colors.white70),
          ),
          _cardDados(
            _textoDados("CPF: ", Colors.greenAccent),
            _textoDados(_usuario.cpf.toString(), Colors.white70),
          ),
          _cardDados(
            _textoDados("RG: ", Colors.greenAccent),
            _textoDados(_usuario.rg, Colors.white70),
          ),
          _cardDados(
            _textoDados("Expedido: ", Colors.greenAccent),
            _textoDados(_dateFormat.format(_usuario.dtExpedidoRG), Colors.white70),
          ),
        ],
      ),
    );
  }

  Container _cardFiliacao(Text _dados, Text _mae, Text _pai) {
    return Container(
      height: (MediaQuery.of(this._context).size.height * 0.6) * 0.3,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _mae,
                  Divider(
                    height: 3.0,
                  ),
                  _pai,
                ],
              ),
            ),
          )
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
    double fontSize = 15,
  }) {
    return Text(
      texto,
      style: TextStyle(
        fontSize: fontSize,
        color: corTexto,
        fontFamily: "Roboto",
      ),
      textAlign: TextAlign.start,
    );
  }
}
