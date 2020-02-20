import 'dart:async';

import 'package:mde_app/view/solicitacao/solicitacao_model.dart';
import 'package:mde_app/view/solicitacao/solicite_confirmar_dados_page.dart';
import 'package:mde_app/view/solicitacao/solicite_dados_escolares_page.dart';
import 'package:mde_app/view/solicitacao/solicite_dados_pessoais_page.dart';
import 'package:mde_app/view/solicitacao/solicite_documentos_page.dart';
import 'package:mde_app/view/solicitacao/solicite_endereco.dart';

class SoliciteBloc {
  StreamController _streamController;

  Solicitacao _solicitacao;

  /*Inicializar a variavel "_page" com o nome do
  formulario que será o primeiro a receber as informações.*/
  String _page;

  SoliciteBloc() {
    this._streamController = StreamController();
    this._page = "Dados Pessoais";
    this._solicitacao = Solicitacao();
    this._streamController.add(SoliciteDadosPessoais(this));
  }

  Solicitacao get solicitacao => _solicitacao;

  StreamController get streamController => _streamController;

  voltarForm() {
    switch (this._page) {
      case "Confirmação de dados":
        {
          this._page = "Documentos";
          this._streamController.add(SoliciteDocumentos(this));
        }
        break;
      case "Documentos":
        {
          this._page = "Dados Escolares";
          this._streamController.add(SoliciteDadosEscolares(this));
        }
        break;
      case "Dados Escolares":
        {
          this._page = "Endereco";
          this._streamController.add(SoliciteEndereco(this));
        }
        break;
      case "Endereco":
        {
          this._page = "Dados Pessoais";
          this._streamController.add(SoliciteDadosPessoais(this));
        }
        break;
    }
  }

  continuarForm() {
    switch (this._page) {
      case "Dados Pessoais":
        {
          this._page = "Endereco";
          this._streamController.add(SoliciteEndereco(this));
        }
        break;
      case "Endereco":
        {
          this._page = "Dados Escolares";
          this._streamController.add(SoliciteDadosEscolares(this));
        }
        break;
      case "Dados Escolares":
        {
          this._page = "Documentos";
          this._streamController.add(SoliciteDocumentos(this));
        }
        break;
      case "Documentos":
        {
          this._page = "Confirmação de dados";
          this._streamController.add(SoliciteConfirmarDados(this));
        }
        break;
    }
  }

  dispose() {
    _streamController.close();
  }
}
