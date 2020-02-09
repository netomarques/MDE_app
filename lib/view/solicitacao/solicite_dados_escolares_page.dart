import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mde_app/utils/alert.dart';
import 'package:mde_app/view/solicitacao/solicite_bloc.dart';
import 'package:mde_app/widgets/app_text_formulario.dart';
import 'package:mde_app/widgets/buttons_formulario.dart';

class SoliciteDadosEscolares extends StatefulWidget {
  SoliciteBloc _bloc;

  SoliciteDadosEscolares(this._bloc);

  @override
  _SoliciteDadosEscolaresState createState() => _SoliciteDadosEscolaresState();
}

class _SoliciteDadosEscolaresState extends State<SoliciteDadosEscolares> {
  final _formKey = GlobalKey<FormState>();

  /*List _tiposUsuarios = ["Aluno(a)", "Professor(a)"];*/
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  StreamController _streamTipoUsuario;

  /*String _tipoUsuario;*/

  /*final _tInstituicao = TextEditingController(text: "Teste");
  final _tCurso = TextEditingController(text: "Teste");
  final _tSemestre = TextEditingController(text: "Teste");
  final _tMatricula = TextEditingController(text: "Teste");
  final _tTurno = TextEditingController(text: "Teste");*/

  final _tInstituicao = TextEditingController();
  final _tCurso = TextEditingController();
  final _tSemestre = TextEditingController();
  final _tMatricula = TextEditingController();
  final _tTurno = TextEditingController();

  @override
  void initState() {
    super.initState();
    _streamTipoUsuario = StreamController<int>();
    /*_dropDownMenuItems = _getDropDownMenuItems();
    _tipoUsuario = _dropDownMenuItems[0].value;*/

    if (widget._bloc.solicitacao.instituicao != null) _preencherCampos();
  }

  void _preencherCampos() {
    _tInstituicao.text = widget._bloc.solicitacao.instituicao;
    _tCurso.text = widget._bloc.solicitacao.curso;
    _tSemestre.text = widget._bloc.solicitacao.semestre;
    _tMatricula.text = widget._bloc.solicitacao.matricula;
    _tTurno.text = widget._bloc.solicitacao.turno;
    if (widget._bloc.solicitacao.aluno_professor == "Aluno")
      _streamTipoUsuario.add(0);
    else
      _streamTipoUsuario.add(1);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Form(
          key: _formKey,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white70,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                AppTextFormulario(
                  "Instituição de ensino",
                  "Informe onde você estuda",
                  controller: _tInstituicao,
                  validator: _validarCampo,
                ),
                SizedBox(height: 10),
                AppTextFormulario(
                  "Curso",
                  "Ensino Fundamental, Administração ...",
                  controller: _tCurso,
                  validator: _validarCampo,
                ),
                SizedBox(height: 10),
                AppTextFormulario(
                  "Semestre",
                  "Série, Periodo ...",
                  controller: _tSemestre,
                  validator: _validarCampo,
                ),
                SizedBox(height: 10),
                AppTextFormulario(
                  "Matricula",
                  "Informe sua matricula",
                  controller: _tMatricula,
                  validator: _validarCampo,
                ),
                SizedBox(height: 10),
                AppTextFormulario(
                  "Turno",
                  "Informe o turno em que você estuda",
                  controller: _tTurno,
                  validator: _validarCampo,
                ),
                SizedBox(height: 10),
                _radioTipoUsuario(),
              ],
            ),
          ),
        ),
        ButtonsFormulario(_onClickVoltar, _onClickContinuar),
      ],
    );
  }

  /*_selecionarUsuario() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 68,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.black38),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 5.0, top: 2.0),
            child: Text("Aluno(a)/Professor(a)",
                style: TextStyle(color: Colors.green, fontSize: 14)),
          ),
          DropdownButton(
            value: _tipoUsuario,
            items: _dropDownMenuItems,
            onChanged: _changedDropDownItem,
          ),
        ],
      ),
    );
  }*/

  _radioTipoUsuario() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      child: InputDecorator(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          labelText: "Aluno(a)/Professor(a)",
          labelStyle: TextStyle(fontSize: 16, color: Colors.indigo),
        ),
        child: StreamBuilder<int>(
            stream: _streamTipoUsuario.stream,
            initialData: -1,
            builder: (context, snapshot) {
              Color cor;
              if (snapshot.data == -2)
                cor = Colors.red;
              else
                cor = Colors.blueGrey;

              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Radio(
                    value: 0,
                    groupValue: snapshot.data,
                    onChanged: _onClickRadioButton,
                  ),
                  Text(
                    "Aluno",
                    style: TextStyle(color: cor, fontSize: 14),
                  ),
                  Radio(
                    value: 1,
                    groupValue: snapshot.data,
                    onChanged: _onClickRadioButton,
                  ),
                  Text(
                    "Professor",
                    style: TextStyle(color: cor, fontSize: 14),
                  ),
                ],
              );
            }),
      ),
    );
  }

  _onClickRadioButton(int value) {
    switch (value) {
      case 0:
        widget._bloc.solicitacao.aluno_professor = "Aluno";
        break;
      case 1:
        widget._bloc.solicitacao.aluno_professor = "Professor";
        break;
    }
    _streamTipoUsuario.add(value);
  }

  void _onClickContinuar() {
    if (!_validarCampos(_formKey)) {
      return;
    }

    _preencherSolicitacao();

    widget._bloc.continuarForm();
  }

  void _onClickVoltar() {
    widget._bloc.voltarForm();
  }

  bool _validarCampos(formKey) {
    if (formKey.currentState.validate()) {
      var msg;

      if (widget._bloc.solicitacao.aluno_professor == null) {
        msg = "Selecione Aluno ou Professor";
        _streamTipoUsuario.add(-2);
      }

      if (msg != null) {
        alert(context, msg);
        return false;
      }

      return true;
    } else {
      alert(context, "Dado(s) incompleto(s)");
      return false;
    }
  }

  _preencherSolicitacao() {
    widget._bloc.solicitacao.instituicao = _tInstituicao.text;
    widget._bloc.solicitacao.curso = _tCurso.text;
    widget._bloc.solicitacao.semestre = _tSemestre.text;
    widget._bloc.solicitacao.matricula = _tMatricula.text;
    widget._bloc.solicitacao.turno = _tTurno.text;
  }

  String _validarCampo(String text) {
    if (text.isEmpty) {
      return "Campo vazio";
    }
    return null;
  }

  @override
  void dispose() {
    // TODO: implement dispose

    _streamTipoUsuario.close();
    _tTurno.dispose();
    _tMatricula.dispose();
    _tSemestre.dispose();
    _tCurso.dispose();
    _tInstituicao.dispose();
    super.dispose();
  }

/*List<DropdownMenuItem<String>> _getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String tipo in _tiposUsuarios) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(
        DropdownMenuItem(
          value: tipo,
          child:
              Text(tipo, style: TextStyle(color: Colors.green, fontSize: 14)),
        ),
      );
    }

    return items;
  }

  _changedDropDownItem(String tipoUsuario) {
    print("Tipo de usuario selecionado: $tipoUsuario");
    setState(() {
      _tipoUsuario = tipoUsuario;
    });
  }*/
}
