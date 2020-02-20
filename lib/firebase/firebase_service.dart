import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:mde_app/model/usuario.dart';
import 'package:mde_app/utils/api_response.dart';
import 'package:mde_app/view/solicitacao/solicitacao_model.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final Firestore _firestore = Firestore.instance;

  Future<ApiResponse> login(String email, String senha) async {
    try {
      // Login no Firebase
      await _auth.signInWithEmailAndPassword(email: email, password: senha);

      // Resposta genérica
      return ApiResponse.ok();
    } catch (error) {
      //mensagem padrão caso não identifique o erro ao logar.
      var msg = "Erro ao logar";
      /*print("Firebase error $error.code");*/

      // if para tratar erros referente a autenticação do usuário.
      if (error is PlatformException) {
        switch (error.code) {
          case "ERROR_INVALID_EMAIL":
            msg = "Email invalido. \n\n"
                "O endereço de email está com formato inválido";
            break;
          case "ERROR_USER_DISABLED":
            msg =
                "Usuario aguardando confirmação dos dados de soliticação. \n\n"
                "Prazo de até 5 dias após solicitação da Carteira Estudantil MDE";
            break;
          case "ERROR_USER_NOT_FOUND":
            msg = "Email não cadastrado. \n\n"
                "Verifique se o email informado está correto.";
            break;
          case "ERROR_WRONG_PASSWORD":
            msg = "Senha errada. \n\n"
                "Caso tenha esquecido, toque em esqueci senha. Será enviado um email com informações para troca de senha.";
            break;
          default:
        }
      }

      return ApiResponse.error(msg: msg);
    }
  }

  Future<FirebaseUser> userFirebase() => _auth.currentUser();

  Future<ApiResponse> getDadosUsuarioLogado() async {
    try {
      FirebaseUser firebaseUser = await userFirebase();

      Firestore db = Firestore.instance;

      DocumentSnapshot document = await db
          .collection("usuarios")
          .document("hJtDicoD6EXJL2o5HhWz")
          .get();

      Usuario usuarioLogado = Usuario.fromMap(document);

      return ApiResponse.ok(result: usuarioLogado);
    } catch (e) {
      print(e.toString());
      return ApiResponse.error(
          result: e, msg: "Não foi possivel carregar os dados");
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  Future<ApiResponse> enviarSolicitacao(Solicitacao solicitacao) async {
    try {
      print("Iniciado envio de solicitação");

      await _auth.signInWithEmailAndPassword(email: "mdesolicitacoes@gmail.com", password: "123321");
      print("Inicio de envio de arquivos");

      solicitacao.urlFoto = await uploadFirebaseStorage(
          solicitacao.foto, solicitacao.cpf, "foto");
      solicitacao.urlFrenteRgCnh = await uploadFirebaseStorage(
          solicitacao.frenteRgCnh, solicitacao.cpf, "frente_rg_cnh");
      solicitacao.urlVersoRgCnh = await uploadFirebaseStorage(
          solicitacao.versoRgCnh, solicitacao.cpf, "verso_rg_cnh");
      solicitacao.urlComprovanteMatricula = await uploadFirebaseStorage(
          solicitacao.comprovanteMatricula,
          solicitacao.cpf,
          "comprovante_matricula");
      solicitacao.urlFotoCpf = await uploadFirebaseStorage(
          solicitacao.fotoCpf, solicitacao.cpf, "cpf");

      /*solicitacao.urlFoto = "teste";
      solicitacao.urlFrenteRgCnh = "teste";
      solicitacao.urlVersoRgCnh = "teste";
      solicitacao.urlComprovanteMatricula = "teste";
      solicitacao.urlFotoCpf = "teste";*/

      print("Documentos enviados");

      CollectionReference _solicitacoes = _firestore.collection("solicitacoes");
      await _solicitacoes
          .document(solicitacao.cpf)
          .setData(solicitacao.toMap());

      print("Solicitação enviada");
      return ApiResponse.ok();
    } on PlatformException catch (e) {
      print(e.toString());
      logout();
      return ApiResponse.error(msg: "Já existe uma solicitação vinculada ao cpf ${solicitacao.cpf}");
    } on Exception catch (e) {
      print(e.toString());
      logout();
      return ApiResponse.error(msg: "Erro: não identificado");
    }
  }

  Future<String> uploadFirebaseStorage(
      File file, String cpf, String nomeArquivo) async {
    final storageRef =
        _storage.ref().child("/documentos/${cpf}/${nomeArquivo}");

    final StorageTaskSnapshot task = await storageRef.putFile(file).onComplete;

    final String url = await task.ref.getDownloadURL();
    print(url);
    return url;
  }
}
