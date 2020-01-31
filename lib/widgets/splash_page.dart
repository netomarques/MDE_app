import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mde_app/firebase/firebase_service.dart';
import 'package:mde_app/utils/nav.dart';
import 'package:mde_app/view/carteira/carteira_page.dart';
import 'package:mde_app/view/home_page.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {

    Future futureDelay = Future.delayed(Duration(seconds: 5));

    Future<FirebaseUser> futureFirebase = FirebaseService().userFirebase();

    /*Future.delayed(Duration(seconds: 7)).then((_) {
      push(context, HomePage(), replace: true);
    });*/

    Future.wait([futureDelay, futureFirebase]).then((List values) {
      FirebaseUser user = values[1];

      if(user != null) {
        push(context, CarteiraPage(), replace: true);
      } else {
        push(context, HomePage(), replace: true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.indigo,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        "assets/images/logo_mde.png",
                        fit: BoxFit.contain,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                    ),
                    Text(
                      "Movimento Democrático Estudantil",
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
