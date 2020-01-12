import 'package:flutter/material.dart';

class LatamHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: _conteudoTop(),
          ),
          Expanded(
            flex: 4,
            child: _imagemLatam(),
          ),
          Expanded(
            flex: 2,
            child: _containerButtons(),
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
            "Vantagens? Sim, é lei!",
            style: TextStyle(
              fontSize: 35,
              color: Colors.green,
            ),
          ),
          _texto(),
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

  _texto() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          "Aos estudantes e professores é assegurado através do documento do estudante, " +
              "o pagamento da meia-entrada em cinemas, shows, teatros, circos, parques e casas de diversão, " +
              "eventos culturais, desportivos, artísticos e educacionais, tais como seminários, palestras, " +
              "e conferências a nível nacional. " +
              "O diferencial da MDE é a oportunidade de viajar com desconto pela Latam. Consulte valores.",
          style: TextStyle(
            fontSize: 14,
            color: Colors.white70,
          ),
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }

  _imagemLatam() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Image.asset(
        "assets/images/latam_banner.jpg",
        fit: BoxFit.fill,
      ),
    );
  }
}
