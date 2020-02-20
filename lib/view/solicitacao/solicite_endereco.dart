import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:mde_app/utils/alert.dart';
import 'package:mde_app/view/solicitacao/solicite_bloc.dart';
import 'package:mde_app/widgets/app_text_formulario.dart';
import 'package:mde_app/widgets/buttons_formulario.dart';

class SoliciteEndereco extends StatefulWidget {
  SoliciteBloc _bloc;

  SoliciteEndereco(this._bloc);

  @override
  _SoliciteEnderecoState createState() => _SoliciteEnderecoState();
}

class _SoliciteEnderecoState extends State<SoliciteEndereco> {
  final _formKey = GlobalKey<FormState>();

  final _tRua = TextEditingController(text: "Teste");
  final _tNumero = TextEditingController(text: "Teste");
  final _tCidade = TextEditingController(text: "Teste");
  final _tEstado = TextEditingController(text: "Teste");
  final _tCep = MaskedTextController(
      text: "69090635",
      mask: '00000-000',
      translator: {'0': new RegExp(r'[0-9]')});

  /*final _tRua = TextEditingController();
  final _tNumero = TextEditingController();
  final _tCidade = TextEditingController();
  final _tEstado = TextEditingController();
  final _tCep = MaskedTextController(
      mask: '00000-000', translator: {'0': new RegExp(r'[0-9]')});*/

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget._bloc.solicitacao.rua != null) {
      _preencherCampos();
    }
  }

  void _preencherCampos() {
    _tRua.text = widget._bloc.solicitacao.rua;
    _tNumero.text = widget._bloc.solicitacao.numero;
    _tCidade.text = widget._bloc.solicitacao.cidade;
    _tEstado.text = widget._bloc.solicitacao.estado;
    _tCep.text = widget._bloc.solicitacao.cep;
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
                  "Rua/Avenida/Logradouro",
                  "Informe rua/avenida/logradouro",
                  controller: _tRua,
                  validator: _validateCampo,
                ),
                SizedBox(height: 10),
                AppTextFormulario(
                  "Numero",
                  "Informe o numero da sua casa",
                  controller: _tNumero,
                  validator: _validateCampo,
                ),
                SizedBox(height: 10),
                AppTextFormulario(
                  "Cidade",
                  "Informe a sua cidade",
                  controller: _tCidade,
                  validator: _validateCampo,
                ),
                SizedBox(height: 10),
                AppTextFormulario(
                  "Estado",
                  "Informe o seu estado",
                  controller: _tEstado,
                  validator: _validateCampo,
                ),
                SizedBox(height: 10),
                AppTextFormulario(
                  "CEP",
                  "Informe seu CEP",
                  controller: _tCep,
                  validator: _validateCep,
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
        ),
        ButtonsFormulario(_onClickVoltar, _onClickContinuar),
      ],
    );
  }

  String _validateCampo(String text) {
    if (text.isEmpty) {
      return "Campo vazio";
    }
    return null;
  }

  String _validateCep(String text) {
    if (text.isEmpty) {
      return "Campo vazio";
    }
    if (text.length < 9) {
      return "Campo precisa ter 8 digitos";
    }
    return null;
  }

  preencherSolicitacao() {
    widget._bloc.solicitacao.rua = _tRua.text;
    widget._bloc.solicitacao.numero = _tNumero.text;
    widget._bloc.solicitacao.cidade = _tCidade.text;
    widget._bloc.solicitacao.estado = _tEstado.text;

    _tCep.updateMask('00000000');
    widget._bloc.solicitacao.cep = _tCep.text;
  }

  bool _validarCampos(formKey) {
    if (formKey.currentState.validate()) {
      return true;
    } else {
      alert(context, "Dado(s) incompleto(s)");
      return false;
    }
  }

  void _onClickContinuar() {
    if (!_validarCampos(_formKey)) {
      return;
    }

    preencherSolicitacao();

    widget._bloc.continuarForm();
  }

  void _onClickVoltar() {
    widget._bloc.voltarForm();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tCep.dispose();
    _tEstado.dispose();
    _tCidade.dispose();
    _tNumero.dispose();
    _tRua.dispose();
    super.dispose();
  }
}
