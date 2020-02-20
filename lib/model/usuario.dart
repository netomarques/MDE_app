import 'dart:core';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'base_model.dart';

class Usuario extends BaseModel {
  String _documentId;
  String _nome;
  int _cpf;
  DateTime _dtAniversario;
  String _rg;
  DateTime _dtExpedidoRG;
  String _mae;
  String _pai;
  String _email;

  String _instituicao;
  String _curso;
  String _matricula;

  String _qrcode;
  String _qrcodeImagem;
  String _foto;

  String _numeroCarteira;
  String _situacao;
  DateTime _validade;

  Usuario();

  Usuario.fromMap(DocumentSnapshot document) {
    this._documentId = document.documentID;

    this._nome = document.data["nome"];
    this._cpf = document.data["cpf"];
    this._dtAniversario = DateTime.fromMillisecondsSinceEpoch(
        document.data["dt_aniversario"].millisecondsSinceEpoch);
    this._rg = document.data["rg"];
    this._dtExpedidoRG = DateTime.fromMillisecondsSinceEpoch(
        document.data["dt_expedido_rg"].millisecondsSinceEpoch);
    this._mae = document.data["mae"];
    this._pai = document.data["pai"];
    this._email = document.data["email"];
    this._instituicao = document.data["instituicao"];
    this._curso = document.data["curso"];
    this._matricula = document.data["matricula"];
    this._qrcode =  document.data["qrcode"];
    this._qrcodeImagem =  document.data["qrcode_imagem"];
    this._foto = document.data["foto"];
    this._numeroCarteira = document.data["numero_carteira"];
    this._situacao = document.data["situacao"];
    this._validade = DateTime.fromMillisecondsSinceEpoch(
        document.data["validade"].millisecondsSinceEpoch);
  }

  @override
  toMap() {
    Map<String, dynamic> map = {
      "nome": this._nome,
      "cpf": this._cpf,
      "dtAniversario": this._dtAniversario,
      "rg": this._rg,
      "dtExpedicaoRG": this._dtExpedidoRG,
      "mae": this._mae,
      "pai": this._pai,
      "email": this._email,
      "instituicao": this._instituicao,
      "curso": this._curso,
      "matricula": this._matricula,
      "qrcode": this._qrcode,
      "qrcodeImagem": this._qrcodeImagem,
      "foto": this._foto,
      "numeroCarteira": this._numeroCarteira,
      "situacao": this._situacao,
      "validade": this._validade,
    };

    return map;
  }

  @override
  String documentId() => _documentId;

  String get qrcodeImagem => _qrcodeImagem;

  DateTime get validade => _validade;

  String get situacao => _situacao;

  String get numeroCarteira => _numeroCarteira;

  String get foto => _foto;

  String get qrcode => _qrcode;

  String get matricula => _matricula;

  String get curso => _curso;

  String get instituicao => _instituicao;

  String get email => _email;

  String get pai => _pai;

  String get mae => _mae;

  DateTime get dtExpedidoRG => _dtExpedidoRG;

  String get rg => _rg;

  DateTime get dtAniversario => _dtAniversario;

  int get cpf => _cpf;

  String get nome => _nome;

}
