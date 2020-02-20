import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mde_app/firebase/firebase_service.dart';
import 'package:mde_app/utils/alert.dart';
import 'package:mde_app/utils/api_response.dart';
import 'package:mde_app/utils/nav.dart';
import 'package:mde_app/view/solicitacao/solicite_bloc.dart';
import 'package:mde_app/view/solicitacao/solicite_fim.dart';
import 'package:mde_app/widgets/buttons_formulario.dart';

class SoliciteConfirmarDados extends StatefulWidget {
  SoliciteBloc _bloc;

  SoliciteConfirmarDados(this._bloc);

  @override
  _SoliciteConfirmarDadosState createState() => _SoliciteConfirmarDadosState();
}

class _SoliciteConfirmarDadosState extends State<SoliciteConfirmarDados> {
  var _dateFormat = DateFormat("dd/MM/yyyy");

  StreamController stream = StreamController<bool>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    stream.add(false);
  }

  @override
  Widget build(BuildContext context) {
    return _body();
  }

  _body() {
    return StreamBuilder<bool>(
        stream: stream.stream,
        initialData: false,
        builder: (context, snapshot) {
          if (snapshot.data) {
            return Center(
              child: Column(
                children: <Widget>[
                  CircularProgressIndicator(),
                  Text(
                    "Aguarde",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.yellow,
                    ),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            );
          }

          return Column(
            children: <Widget>[
              Text(
                "Se algum dado está informado errado toque em voltar para corrigir. Caso os dados estejam corretos toque em confirmar e será enviado a solicitacão da Carteira MDE",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.yellow,
                ),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.all(16),
                child: Column(
                  children: <Widget>[
                    _text("Nome completo",
                        dados: this.widget._bloc.solicitacao.nome),
                    SizedBox(height: 10),
                    _text("Email", dados: this.widget._bloc.solicitacao.email),
                    SizedBox(height: 10),
                    _text("Telefone",
                        dados: this.widget._bloc.solicitacao.telefone),
                    SizedBox(height: 10),
                    _text("RG", dados: this.widget._bloc.solicitacao.rg),
                    SizedBox(height: 10),
                    _text("Data emissão RG",
                        dados: _dateFormat.format(
                            this.widget._bloc.solicitacao.dtExpedidoRg)),
                    SizedBox(height: 10),
                    _text("CPF", dados: this.widget._bloc.solicitacao.cpf),
                    SizedBox(height: 10),
                    _text("Data de aniversário",
                        dados: _dateFormat.format(
                            this.widget._bloc.solicitacao.dtAniversario)),
                    SizedBox(height: 10),
                    _text("Sexo", dados: this.widget._bloc.solicitacao.sexo),
                    SizedBox(height: 10),
                    _text("Nome da Mãe",
                        dados: this.widget._bloc.solicitacao.nomeMae),
                    SizedBox(height: 10),
                    _text("Nome do Pai",
                        dados: this.widget._bloc.solicitacao.nomePai),
                    SizedBox(height: 10),
                    _text("Rua/Avenida/Logradouro",
                        dados: this.widget._bloc.solicitacao.rua),
                    SizedBox(height: 10),
                    _text("Numero",
                        dados: this.widget._bloc.solicitacao.numero),
                    SizedBox(height: 10),
                    _text("Cidade",
                        dados: this.widget._bloc.solicitacao.cidade),
                    SizedBox(height: 10),
                    _text("Estado",
                        dados: this.widget._bloc.solicitacao.estado),
                    SizedBox(height: 10),
                    _text("CEP", dados: this.widget._bloc.solicitacao.cep),
                    SizedBox(height: 10),
                    _text("Instituiçãoo de ensino",
                        dados: this.widget._bloc.solicitacao.instituicao),
                    SizedBox(height: 10),
                    _text("Curso", dados: this.widget._bloc.solicitacao.curso),
                    SizedBox(height: 10),
                    _text("Semestre",
                        dados: this.widget._bloc.solicitacao.semestre),
                    SizedBox(height: 10),
                    _text("Matricula",
                        dados: this.widget._bloc.solicitacao.matricula),
                    SizedBox(height: 10),
                    _text("Turno", dados: this.widget._bloc.solicitacao.turno),
                    SizedBox(height: 10),
                    _text("Aluno(a)/Professor(a)",
                        dados: this.widget._bloc.solicitacao.aluno_professor),
                    SizedBox(height: 10),
                    _text("Foto com fundo branco",
                        file: this.widget._bloc.solicitacao.foto),
                    SizedBox(height: 10),
                    _text("Frente do RG/CNH",
                        file: this.widget._bloc.solicitacao.frenteRgCnh),
                    SizedBox(height: 10),
                    _text("Verso do RG/CNH",
                        file: this.widget._bloc.solicitacao.versoRgCnh),
                    SizedBox(height: 10),
                    _text("CPF", file: this.widget._bloc.solicitacao.fotoCpf),
                    SizedBox(height: 10),
                    _text("Comprovante de Matricula",
                        file:
                            this.widget._bloc.solicitacao.comprovanteMatricula),
                    SizedBox(height: 10),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Se algum dado está informado errado toque em voltar para corrigir. Caso os dados estejam corretos toque em confirmar e será enviado a solicitacão da Carteira MDE",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.yellow,
                ),
                textAlign: TextAlign.justify,
              ),
              ButtonsFormulario(
                _onClickVoltar,
                _onClickContinuar,
                textoContinuar: "Confirmar",
              ),
            ],
          );
        });
  }

  _text(_titulo, {dados, file}) {
    return Container(
      child: InputDecorator(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          labelText: _titulo,
          labelStyle: TextStyle(fontSize: 16, color: Colors.indigo),
        ),
        child: file != null
            ? Image.file(file)
            : Text(
                dados,
                style: TextStyle(fontSize: 16, color: Colors.blueGrey),
              ),
      ),
    );
  }

  void _onClickContinuar() async {
    stream.add(true);
    ApiResponse result = await FirebaseService()
        .enviarSolicitacao(this.widget._bloc.solicitacao);
    stream.add(false);
    if (result.ok) {
      push(context, SoliciteFim(), replace: true);
    } else {
      alert(context, result.msg);
    }
  }

  void _onClickVoltar() {
    this.widget._bloc.voltarForm();
  }
}
