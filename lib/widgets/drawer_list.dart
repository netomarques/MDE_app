import 'package:flutter/material.dart';

class DrawerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Container(
          color: Colors.blueAccent,
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: _textoDados("Ana Beatriz Pereira Medeiros", Colors.white70),
                accountEmail: _textoDados("anabeatriz@gmail.com", Colors.white70),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(
                    "https://ca.portaldeassinaturas.com.br/Repositories/67a8fb49-68f7-4332-8a2e-bddf1817c589/HolderPhoto?id=13098284&pass=NNZ39PXB",
                  ),
                ),
              ),
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
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
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
        fontSize: 16,
        color: corTexto,
        fontFamily: "Roboto",
        fontStyle: fonteStyle,
        fontWeight: fontWeight,
      ),
      textAlign: TextAlign.start,
    );
  }
}
