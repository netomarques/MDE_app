import 'package:flutter/material.dart';

class ButtonsFormulario extends StatelessWidget {
  Function _onPressedVoltar;
  Function _onPressedContinuar;
  var textoVoltar;
  var textoContinuar;

  ButtonsFormulario(this._onPressedVoltar, this._onPressedContinuar, {this.textoContinuar});

  @override
  Widget build(BuildContext context) {
    return _containerButtons();
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
              this.textoContinuar != null ? this.textoContinuar : "Continuar",
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
        onPressed: _onPressedContinuar,
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
        onPressed: _onPressedVoltar,
      ),
    );
  }
}
