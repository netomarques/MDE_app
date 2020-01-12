import 'package:flutter/material.dart';
import 'package:mde_app/view/home/latam_home_page.dart';
import 'package:mde_app/view/home/logo_mde_home_page.dart';
import 'package:mde_app/view/home/vantagens_home_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(context),
    );
  }

  _body(context) {
    return Container(
      padding: EdgeInsets.only(top: 50),
      child: PageView(
        children: <Widget>[
          LogoMdeHome(),
          VantagensHome(),
          LatamHome(),
        ],
      ),
    );
  }
}
