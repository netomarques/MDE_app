import 'dart:io';

class Solicitacao{

  String _nome;
  String _email;
  String _telefone;
  String _rg;
  DateTime _dtExpedidoRg;
  String _cpf;
  DateTime _dtAniversario;
  String _sexo;
  String _nomeMae;
  String _nomePai;

  String _rua;
  String _numero;
  String _cidade;
  String _estado;
  String _cep;

  String _instituicao;
  String _curso;
  String _semestre;
  String _matricula;
  String _turno;
  String _aluno_professor;

  File _foto;
  File _frenteRgCnh;
  File _versoRgCnh;
  File _comprovanteMatricula;
  File _fotoCpf;

  String get nome => _nome;

  set nome(String value) {
    _nome = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get telefone => _telefone;

  File get fotoCpf => _fotoCpf;

  set fotoCpf(File value) {
    _fotoCpf = value;
  }

  File get comprovanteMatricula => _comprovanteMatricula;

  set comprovanteMatricula(File value) {
    _comprovanteMatricula = value;
  }

  File get versoRgCnh => _versoRgCnh;

  set versoRgCnh(File value) {
    _versoRgCnh = value;
  }

  File get frenteRgCnh => _frenteRgCnh;

  set frenteRgCnh(File value) {
    _frenteRgCnh = value;
  }

  File get foto => _foto;

  set foto(File value) {
    _foto = value;
  }

  String get aluno_professor => _aluno_professor;

  set aluno_professor(String value) {
    _aluno_professor = value;
  }

  String get turno => _turno;

  set turno(String value) {
    _turno = value;
  }

  String get matricula => _matricula;

  set matricula(String value) {
    _matricula = value;
  }

  String get semestre => _semestre;

  set semestre(String value) {
    _semestre = value;
  }

  String get curso => _curso;

  set curso(String value) {
    _curso = value;
  }

  String get instituicao => _instituicao;

  set instituicao(String value) {
    _instituicao = value;
  }

  String get cep => _cep;

  set cep(String value) {
    _cep = value;
  }

  String get estado => _estado;

  set estado(String value) {
    _estado = value;
  }

  String get cidade => _cidade;

  set cidade(String value) {
    _cidade = value;
  }

  String get numero => _numero;

  set numero(String value) {
    _numero = value;
  }

  String get rua => _rua;

  set rua(String value) {
    _rua = value;
  }

  String get nomePai => _nomePai;

  set nomePai(String value) {
    _nomePai = value;
  }

  String get nomeMae => _nomeMae;

  set nomeMae(String value) {
    _nomeMae = value;
  }

  String get sexo => _sexo;

  set sexo(String value) {
    _sexo = value;
  }

  DateTime get dtAniversario => _dtAniversario;

  set dtAniversario(DateTime value) {
    _dtAniversario = value;
  }

  String get cpf => _cpf;

  set cpf(String value) {
    _cpf = value;
  }

  DateTime get dtExpedidoRg => _dtExpedidoRg;

  set dtExpedidoRg(DateTime value) {
    _dtExpedidoRg = value;
  }

  String get rg => _rg;

  set rg(String value) {
    _rg = value;
  }

  set telefone(String value) {
    _telefone = value;
  }

}