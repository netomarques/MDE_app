import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mde_app/firebase/firebase_service.dart';
import 'package:mde_app/utils/nav.dart';
import 'package:mde_app/view/login/login_page.dart';

class DrawerList extends StatelessWidget {
  UserAccountsDrawerHeader _header(FirebaseUser user) {
    return UserAccountsDrawerHeader(
      accountName: user.displayName != null ? Text(user.displayName) : Text(""),
      accountEmail: Text(user.email),
      currentAccountPicture: user.photoUrl != null
          ? CircleAvatar(
              backgroundImage: NetworkImage(user.photoUrl),
            )
          : CircleAvatar(
              backgroundImage: AssetImage("assets/images/camera.png"),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Future<FirebaseUser> future = FirebaseAuth.instance.currentUser();

    return SafeArea(
      child: Drawer(
        child: Container(
          color: Colors.blueAccent,
          child: ListView(
            children: <Widget>[
              FutureBuilder<FirebaseUser>(
                future: future,
                builder: (context, snapshot) {
                  FirebaseUser user = snapshot.data;

                  if (snapshot.hasError) {
                    return Container();
                  }

                  return user != null ? _header(user) : Container();
                },
              ),
              /*UserAccountsDrawerHeader(
                accountName: _textoDados(usuario.nome, Colors.white70),
                accountEmail: _textoDados(usuario.email, Colors.white70),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(
                    "https://ca.portaldeassinaturas.com.br/Repositories/67a8fb49-68f7-4332-8a2e-bddf1817c589/HolderPhoto?id=13098284&pass=NNZ39PXB",
                  ),
                ),
              ),*/
              ListTile(
                leading: Icon(Icons.help),
                title: Text("Ajuda"),
                subtitle: Text("mais informações..."),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text("Logout"),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  _onClickLogout(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  /*Text _textoDados(
    String texto,
    Color corTexto, {
    FontStyle fonteStyle = FontStyle.normal,
    FontWeight fontWeight = FontWeight.normal,
  }) {
    return Text(
      texto,
      style: TextStyle(
        fontSize: 16,
        color: corTexto,
        fontFamily: "Roboto",
        fontStyle: fonteStyle,
        fontWeight: fontWeight,
      ),
      textAlign: TextAlign.start,
    );
  }*/

  _onClickLogout(BuildContext context) {
    FirebaseService().logout();
    Navigator.pop(context);
    push(context, Login(), replace: true);
  }
}
