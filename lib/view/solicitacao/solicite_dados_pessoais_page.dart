import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:intl/intl.dart';
import 'package:mde_app/utils/alert.dart';
import 'package:mde_app/view/solicitacao/solicite_bloc.dart';
import 'package:mde_app/widgets/app_text_formulario.dart';

class SoliciteDadosPessoais extends StatefulWidget {
  SoliciteBloc _bloc;

  SoliciteDadosPessoais(this._bloc);

  @override
  _SoliciteDadosPessoaisState createState() => _SoliciteDadosPessoaisState();
}

class _SoliciteDadosPessoaisState extends State<SoliciteDadosPessoais> {
  StreamController _streamDtAniversario;
  StreamController _streamDtExpedidoRG;
  StreamController _streamSexo;
  var _dateFormat = DateFormat("dd/MM/yyyy");
  final _formKey = GlobalKey<FormState>();

  /*final _tNome = TextEditingController(text: "JoseFina Silva");
  final _tEmail = TextEditingController(text: "Teste@gmail.com");
  final _tTelefone = MaskedTextController(
      text: "92999999999",
      mask: '(00) 00000-0000',
      translator: {'0': new RegExp(r'[0-9]')});
  final _tRg = TextEditingController(text: "Teste");
  final _tCPF = MaskedTextController(
      text: "99999999999",
      mask: '000.000.000-00',
      translator: {'0': new RegExp(r'[0-9]')});
  final _tNomeMae = TextEditingController(text: "JoseFina Silva Queiros");
  final _tNomePai = TextEditingController(text: "Jose Silva Queiros");*/

  final _tNome = TextEditingController();
  final _tEmail = TextEditingController();
  final _tTelefone = MaskedTextController(
      mask: '(00) 00000-0000',
      translator: {'0': new RegExp(r'[0-9]')});
  final _tRg = TextEditingController();
  final _tCPF = MaskedTextController(
      mask: '000.000.000-00',
      translator: {'0': new RegExp(r'[0-9]')});
  final _tNomeMae = TextEditingController();
  final _tNomePai = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _streamDtExpedidoRG = StreamController<DateTime>();
    _streamDtAniversario = StreamController<DateTime>();
    _streamSexo = StreamController<int>();
    if (widget._bloc.solicitacao.nome != null) {
      _preencherCampos();
    }
  }

  void _preencherCampos() {
    _tNome.text = widget._bloc.solicitacao.nome;
    _tEmail.text = widget._bloc.solicitacao.email;
    _tTelefone.text = widget._bloc.solicitacao.telefone;
    _tRg.text = widget._bloc.solicitacao.rg;
    _tCPF.text = widget._bloc.solicitacao.cpf;
    _tNomeMae.text = widget._bloc.solicitacao.nomeMae;
    _tNomePai.text = widget._bloc.solicitacao.nomePai;
    _streamDtAniversario.add(widget._bloc.solicitacao.dtAniversario);
    _streamDtExpedidoRG.add(widget._bloc.solicitacao.dtExpedidoRg);
    if (widget._bloc.solicitacao.sexo == "Masculino")
      _streamSexo.add(0);
    else
      _streamSexo.add(1);
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
                  "Nome",
                  "Informe seu nome completo",
                  controller: _tNome,
                  validator: _validateCampoVazio,
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: 10),
                AppTextFormulario(
                  "Email",
                  "Informe seu email",
                  controller: _tEmail,
                  validator: _validateEmail,
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 10),
                AppTextFormulario(
                  "Telefone",
                  "(92) 99999-9999",
                  controller: _tTelefone,
                  validator: _validateTelefone,
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(height: 10),
                AppTextFormulario(
                  "RG",
                  "Informe seu rg",
                  controller: _tRg,
                  validator: _validateCampoVazio,
                ),
                SizedBox(height: 10),
                _ContainerData(_streamDtExpedidoRG, "rg", "Data emissão RG"),
                SizedBox(height: 10),
                AppTextFormulario(
                  "CPF",
                  "000.000.000-00",
                  controller: _tCPF,
                  validator: _validateCPF,
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 10),
                _ContainerData(
                    _streamDtAniversario, "aniversario", "Data de aniversário"),
                SizedBox(height: 10),
                _radioSexo(),
                SizedBox(height: 10),
                AppTextFormulario(
                  "Nome da Mãe",
                  "Informe o nome da sua mãe",
                  controller: _tNomeMae,
                  validator: _validateCampoVazio,
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: 10),
                AppTextFormulario(
                  "Nome do Pai",
                  "Informe o nome do seu pai",
                  controller: _tNomePai,
                  keyboardType: TextInputType.text,
                ),
              ],
            ),
          ),
        ),
        _containerButtons(),
      ],
    );
  }

  _radioSexo() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      child: InputDecorator(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          labelText: "Sexo",
          labelStyle: TextStyle(fontSize: 16, color: Colors.indigo),
        ),
        child: StreamBuilder<int>(
            stream: _streamSexo.stream,
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
                    onChanged: _onClickSexo,
                  ),
                  Text(
                    "Masculino",
                    style: TextStyle(color: cor, fontSize: 14),
                  ),
                  Radio(
                    value: 1,
                    groupValue: snapshot.data,
                    onChanged: _onClickSexo,
                  ),
                  Text(
                    "Feminino",
                    style: TextStyle(color: cor, fontSize: 14),
                  ),
                ],
              );
            }),
      ),
    );
  }

  _ContainerData(StreamController stream, String opcao, String textoInput) {
    return StreamBuilder<DateTime>(
      stream: stream.stream,
      initialData: DateTime.now(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Container();

        return InkWell(
          onTap: () => _selecionarData(stream, opcao),
          child: InputDecorator(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              labelText: textoInput,
              labelStyle: TextStyle(fontSize: 16, color: Colors.indigo),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  _dateFormat.format(snapshot.data),
                  style: TextStyle(color: Colors.blueGrey, fontSize: 14),
                ),
                Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
        );
      },
    );
  }

  _containerButtons() {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      child: _buttonContinuar(),
    );
  }

  _buttonContinuar() {
    return Container(
      height: 40,
      width: 120,
      child: RaisedButton(
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: Colors.green,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text(
              "Continuar",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
              size: 16,
            ),
          ],
        ),
        onPressed: _onClickContinuar,
      ),
    );
  }

  bool _validarCampos(formKey) {
    if (formKey.currentState.validate()) {
      var msg;

      if (widget._bloc.solicitacao.dtExpedidoRg == null) {
        msg = "Informe a data de emissao do rg";
      } else if (widget._bloc.solicitacao.dtAniversario == null) {
        msg = "Informe a data de aniversário";
      } else if (widget._bloc.solicitacao.sexo == null) {
        msg = "Selecione o sexo";
        _streamSexo.add(-2);
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

  void _onClickContinuar() {
    if (!_validarCampos(_formKey)) {
      return;
    }

    preencherSolicitacao();

    widget._bloc.continuarForm();
  }

  Future _selecionarData(StreamController stream, String opcao) async {
    final DateTime dataSelecionada = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(DateTime.now().year + 1));

    if (dataSelecionada != null) {
      switch (opcao) {
        case "aniversario":
          widget._bloc.solicitacao.dtAniversario = dataSelecionada;
          break;
        case "rg":
          widget._bloc.solicitacao.dtExpedidoRg = dataSelecionada;
          break;
      }
      stream.add(dataSelecionada);
    }
  }

  _onClickSexo(int value) {
    if (value == 0)
      widget._bloc.solicitacao.sexo = "Masculino";
    else if (value == 1) widget._bloc.solicitacao.sexo = "Feminino";

    _streamSexo.add(value);
  }

  String _validateCampoVazio(String text) {
    if (text.isEmpty) {
      return "Campo vazio ou inválido";
    }
    return null;
  }

  String _validateTelefone(String text) {
    if (text.isEmpty) {
      return "Campo vazio";
    }
    if (text.length < 15) {
      return "Campo precisa ter 11 digitos";
    }
    return null;
  }

  String _validateCPF(String text) {
    if (text.isEmpty) {
      return "Campo vazio";
    }
    if (text.length < 14) {
      return "Campo precisa ter 11 digitos";
    }
    return null;
  }

  String _validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Informe um email válido';
    else
      return null;
  }

  preencherSolicitacao() {
    widget._bloc.solicitacao.nome = _tNome.text;
    widget._bloc.solicitacao.email = _tEmail.text;
    widget._bloc.solicitacao.nomeMae = _tNomeMae.text;
    widget._bloc.solicitacao.nomePai = _tNomePai.text;

    _tTelefone.updateMask('00000000000');
    widget._bloc.solicitacao.telefone = _tTelefone.text;

    widget._bloc.solicitacao.rg = _tRg.text;

    _tCPF.updateMask('00000000000');
    widget._bloc.solicitacao.cpf = _tCPF.text;
  }

  @override
  void dispose() {
    // TODO: implement dispose

    _streamDtAniversario.close();
    _streamDtExpedidoRG.close();
    _streamSexo.close();

    _tNome.dispose();
    _tEmail.dispose();
    _tTelefone.dispose();
    _tRg.dispose();
    _tCPF.dispose();
    _tNomeMae.dispose();
    _tNomePai.dispose();

    super.dispose();
  }
}
