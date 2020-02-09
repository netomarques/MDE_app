import 'package:flutter/material.dart';
import 'package:mde_app/utils/alert.dart';
import 'package:mde_app/utils/nav.dart';
import 'package:mde_app/view/home/logo_mde_home_page.dart';
import 'package:mde_app/view/home_page.dart';
import 'package:mde_app/view/solicitacao/solicite_bloc.dart';

class Solicite extends StatefulWidget {
  @override
  _SoliciteState createState() => _SoliciteState();
}

class _SoliciteState extends State<Solicite> {
  SoliciteBloc _bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    this._bloc = SoliciteBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("MDE - Solicite"),
        leading: IconButton(
          tooltip: 'Sair',
          icon: const Icon(Icons.arrow_back),
          onPressed: _sairDoformulario,
        ),
      ),
      body: _body(),
    );
  }

  _body() {
    return WillPopScope(
      onWillPop: _sairDoformulario,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Center(
                  child: Text(
                    "Quais são os seus dados",
                    style: TextStyle(color: Colors.green, fontSize: 22),
                  ),
                ),
              ),
              Expanded(
                flex: 9,
                child: ListView(
                  children: <Widget>[
                    StreamBuilder(
                        stream: this._bloc.streamController.stream,
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          return snapshot.data;
                        }),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _sairDoformulario() {
     return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            title: Text("MDE"),
            content: Text(
                "Se você sair do formulário os dados preenchidos serão apagados! Deseja realmente sair do formulário?"),
            actions: <Widget>[
              FlatButton(
                child: Text("NÃO"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                child: Text("sim"),
                onPressed: () {
                  push(context, HomePage(), replace: true);
                },
              )
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _bloc.dispose();
  }
}
