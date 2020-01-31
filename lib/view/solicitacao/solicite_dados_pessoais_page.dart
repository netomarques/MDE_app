import 'package:flutter/material.dart';
import 'package:mde_app/widgets/app_text_formulario.dart';

class SoliciteDadosPessoais extends StatefulWidget {
  final _formDadosPessoaisKey = GlobalKey<FormState>();

  @override
  _SoliciteDadosPessoaisState createState() =>
      _SoliciteDadosPessoaisState(this._formDadosPessoaisKey);

  get formKey => _formDadosPessoaisKey;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.debug}) {
    // TODO: implement toString
    return "Dados Pessoais";
  }
}

class _SoliciteDadosPessoaisState extends State<SoliciteDadosPessoais> {
  final _formDadosPessoaisKey;

  int _radioIndex = 0;

  final _tNome = TextEditingController(text: "Teste");
  final _tEmail = TextEditingController(text: "Teste");
  final _tTelefone = TextEditingController(text: "Teste");
  final _tRg = TextEditingController(text: "Teste");
  final _tCPF = TextEditingController(text: "Teste");
  final _tDtAniversario = TextEditingController(text: "Teste");
  /*final _tSexo = TextEditingController(text: "Teste");*/
  final _tNomeMae = TextEditingController(text: "Teste");
  final _tNomePai = TextEditingController();

  _SoliciteDadosPessoaisState(this._formDadosPessoaisKey);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formDadosPessoaisKey,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            AppTextFormulario(
              "Nome",
              "Informe seu nome completo",
              controller: _tNome,
              validator: _validateCampo,
            ),
            SizedBox(height: 10),
            AppTextFormulario(
              "Email",
              "Informe seu email",
              controller: _tEmail,
              validator: _validateCampo,
            ),
            SizedBox(height: 10),
            AppTextFormulario(
              "Telefone",
              "(92) 99999-9999",
              controller: _tTelefone,
              validator: _validateCampo,
            ),
            SizedBox(height: 10),
            AppTextFormulario(
              "RG",
              "Informe seu RG",
              controller: _tRg,
              validator: _validateCampo,
            ),
            SizedBox(height: 10),
            AppTextFormulario(
              "CPF",
              "000.000.000-00",
              controller: _tCPF,
              validator: _validateCampo,
            ),
            SizedBox(height: 10),
            AppTextFormulario(
              "Data de aniversário",
              "01/01/1900",
              controller: _tDtAniversario,
              validator: _validateCampo,
            ),
            SizedBox(height: 10),
            /*AppTextFormulario(
              "Sexo",
              "M/F",
              controller: _tSexo,
              validator: _validateCampo,
            ),*/
            _radioSexo(),
            SizedBox(height: 10),
            AppTextFormulario(
              "Nome da Mãe",
              "Informe o nome da sua mãe",
              controller: _tNomeMae,
              validator: _validateCampo,
            ),
            SizedBox(height: 10),
            AppTextFormulario(
              "Nome do Pai",
              "Informe o nome do seu pai",
              controller: _tNomePai,
            ),
          ],
        ),
      ),
    );
  }

  _radioSexo() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.black38),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Radio(
            value: 0,
            groupValue: _radioIndex,
            onChanged: _onClickSexo,
          ),
          Text(
            "Masculino",
            style: TextStyle(color: Colors.green, fontSize: 14),
          ),
          Radio(
            value: 1,
            groupValue: _radioIndex,
            onChanged: _onClickSexo,
          ),
          Text(
            "Feminino",
            style: TextStyle(color: Colors.green, fontSize: 14),
          ),
        ],
      ),
    );
  }

  _onClickSexo(int value){
    setState(() {
      _radioIndex = value;
    });
  }

  String _validateCampo(String text) {
    if (text.isEmpty) {
      return "Campo vazio";
    }
    return null;
  }
}
