import 'package:flutter/material.dart';
import 'package:mde_app/widgets/app_text_formulario.dart';

class SoliciteDadosEscolares extends StatefulWidget {

  final _formDadosEscolaresKey = GlobalKey<FormState>();

  @override
  _SoliciteDadosEscolaresState createState() => _SoliciteDadosEscolaresState(_formDadosEscolaresKey);

  get formKey => _formDadosEscolaresKey;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.debug}) {
    // TODO: implement toString
    return "Dados Escolares";
  }
}

class _SoliciteDadosEscolaresState extends State<SoliciteDadosEscolares> {

  var _formDadosEscolaresKey;

  final _tInstituicao = TextEditingController(text: "Teste");
  final _tCurso = TextEditingController(text: "Teste");
  final _tSemestre = TextEditingController(text: "Teste");
  final _tMatricula = TextEditingController(text: "Teste");
  final _tTurno = TextEditingController(text: "Teste");


  _SoliciteDadosEscolaresState(this._formDadosEscolaresKey);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formDadosEscolaresKey,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            AppTextFormulario(
              "Instituição de ensino", "Informe onde você estuda", controller: _tInstituicao, validator: _validateCampo,),
            SizedBox(height: 10),
            AppTextFormulario("Curso", "Informe  o seu curso", controller: _tCurso, validator: _validateCampo,),
            SizedBox(height: 10),
            AppTextFormulario("Semestre", "Série/Periodo", controller: _tSemestre, validator: _validateCampo,),
            SizedBox(height: 10),
            AppTextFormulario("Matricula", "Informe sua matricula", controller: _tMatricula, validator: _validateCampo,),
            SizedBox(height: 10),
            AppTextFormulario("Turno", "Informe o turno em que você estuda", controller: _tTurno, validator: _validateCampo,),
          ],
        ),
      ),
    );
  }

  String _validateCampo(String text) {
    if(text.isEmpty) {
      return "Campo vazio";
    }
    return null;
  }

  String nomeForm(){
    return "Dados Escolares";
  }

  formKey(){
    return _formDadosEscolaresKey;
  }
}
