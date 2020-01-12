import 'package:flutter/material.dart';
import 'package:mde_app/utils/nav.dart';
import 'package:mde_app/view/login/login_page.dart';
import 'package:mde_app/view/solicitacao/solicite_page.dart';

class LogoMdeHome extends StatelessWidget {
  BuildContext _context;

  @override
  Widget build(BuildContext context) {
    this._context = context;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 8,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                "assets/images/logo_mde.png",
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: _containerButtons(),
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
          _buttons("Login", () => push(this._context, Login())),
          SizedBox(
            width: 50,
          ),
          _buttons("Solicite", () => push(this._context, Solicite())),
        ],
      ),
    );
  }

  _buttons(text, onPressed) {
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
        onPressed: onPressed,
      ),
    );
  }
}
