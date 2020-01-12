import 'dart:ui' as prefix0;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VantagensHome extends StatelessWidget {
  BuildContext _context;

  @override
  Widget build(BuildContext context) {
    this._context = context;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: _conteudoTop(),
          ),
          Expanded(
            flex: 6,
            child: _conteudoCenter(),
          ),
          Expanded(
            flex: 2,
            child: _containerButtons(),
          ),
        ],
      ),
    );
  }

  Container _conteudoCenter() {
    return Container(
      alignment: Alignment.topCenter,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _iconeVantagem(Icons.videocam, "Cinema", "50%"),
              _iconeVantagem(Icons.account_balance, "Teatro", "50%"),
              _iconeVantagem(Icons.music_note, "Espetáculos Musicais", "50%"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _iconeVantagem(
                  Icons.question_answer, "Eventos Educativos", "50%"),
              _iconeVantagem(Icons.blur_circular, "Jogos de Futebol", "50%"),
              _iconeVantagem(Icons.local_airport, "Passagens Aéreas", "15%"),
            ],
          )
        ],
      ),
    );
  }

  Container _iconeVantagem(IconData icone, String vantagem, String desconto) {
    return Container(
      width: MediaQuery.of(_context).size.width * 0.3,
      height: MediaQuery.of(_context).size.height * 0.2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Icon(
            icone,
            color: Colors.green,
            size: 60,
          ),
          Text(
            vantagem,
            style: TextStyle(
              fontSize: 14,
              color: Colors.green,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            desconto,
            style: TextStyle(
              fontSize: 14,
              color: Colors.green,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Container _conteudoTop() {
    return Container(
      alignment: Alignment.topCenter,
      child: Column(
        children: <Widget>[
          Text(
            "Já tenho a Carteira",
            style: TextStyle(
              fontSize: 35,
              color: Colors.green,
            ),
          ),
          Text(
            "VEJA AS VANTAGENS",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  _containerButtons() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buttons("Login"),
          SizedBox(
            width: 50,
          ),
          _buttons("Solicite"),
        ],
      ),
    );
  }

  _buttons(text) {
    return Container(
      height: 50,
      width: 130,
      child: RaisedButton(
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: Colors.green,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        onPressed: () => {},
      ),
    );
  }
}
