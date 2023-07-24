import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pratica_mobx/Controller/controller.dart';
import 'package:pratica_mobx/model/AlocacoesModel.dart';
import 'package:pratica_mobx/utlis/snackbar.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import '../model/UsuarioModel.dart';

const BASE_URL = "https://dev.api.cde.estacionamientodigital.com.py/v1/motorista/";
const BASE_URLF = "https://dev.api.cde.estacionamientodigital.com.py/v1/fiscal/";
int timeout = 0; //quando passou tempo return null
Controller controller;

class Api {
  String countryCode = Platform.localeName.split('_')[0];

  String apiUrlGet() {
    return BASE_URL;
  }

  Future getHeaders() async {
    final _random = new Random();
    var list = ['3e3ddc387242e7cb5856ddb75b3c1ba3', '93c32008cebe7943a9f57d49c68b9dbf'];
    var token = list[_random.nextInt(list.length)];
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'language': countryCode == 'pt' ? 'pt' : 'es',
      'token': token
    };
    return headers;
  }

  Future getHeadersF() async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'token': 'd2f821f432c55d62d96d354e76bc2d33',
      'hash': 'aed4da5f38ea1e2552929d40ac3cbb41',
      'imei': '865150033682383',
    };
    return headers;
  }

  Future<List<UsuarioModel>> getUserInfo() async {
    try {
      http.Response response =
          await http.get(BASE_URL + 'user/', headers: await getHeaders()).timeout(Duration(seconds: timeout));
      if (response.statusCode == 200) {
        List<UsuarioModel> user = json.decode(response.body).map<UsuarioModel>((map) {
          return UsuarioModel.fromJson(map);
        }).toList();
        return user;
      } else {
        return null;
      }
    } on TimeoutException catch (e) {
      print('Timeout Error: $e');
      controller = Provider.of<Controller>(Get.context, listen: false);
      controller.removeShared();
      Get.rawSnackbar(
          title: Snackbar.title,
          message: Snackbar.message,
          snackPosition: Snackbar.snackPosition,
          backgroundColor: Snackbar.backgroundColor,
          duration: Snackbar.duration,
          isDismissible: false,
          margin: Snackbar.margin,
          icon: Snackbar.icon,
          borderRadius: Snackbar.borderRadius,
          mainButton: FlatButton(
              child: MaterialButton(
                  shape: RoundedRectangleBorder(borderRadius: Snackbar.borderRadiusG),
                  minWidth: Snackbar.minWidth,
                  height: Snackbar.height,
                  color: Snackbar.colorButton,
                  child: Snackbar.iconButton,
                  onPressed: () {
                    //Remover shared_key e buscar dados API e atualizar a tela
                    timeout = 20;
                    Get.back();
                    controller.getUser();
                  })));
    } on SocketException catch (e) {
      print('Socket Error: $e');
      return null;
    } on Error catch (e) {
      print('General Error: $e');
      return null;
    }
  }

  Future<List<Alocacao>> pesquisar(String codigoQuadrante, String pesquisa) async {
    try {
      http.Response response = await http
          .get(BASE_URLF + "auditoria/buscar/" + codigoQuadrante + "/" + (pesquisa == null ? '' : pesquisa),
              headers: await getHeadersF())
          .timeout(Duration(seconds: timeout));
      if (response.statusCode == 200) {
        List<Alocacao> alocacoes = json.decode(response.body).map<Alocacao>((map) {
          return Alocacao.fromJson(map);
        }).toList();
        return alocacoes;
      } else {
        return null;
      }
    } on TimeoutException catch (e) {
      print('Timeout Error: $e');
      Get.rawSnackbar(
          title: Snackbar.title,
          message: Snackbar.message,
          snackPosition: Snackbar.snackPosition,
          backgroundColor: Snackbar.backgroundColor,
          duration: Snackbar.duration,
          isDismissible: false,
          margin: Snackbar.margin,
          icon: Snackbar.icon,
          borderRadius: Snackbar.borderRadius,
          mainButton: FlatButton(
              child: MaterialButton(
                  shape: RoundedRectangleBorder(borderRadius: Snackbar.borderRadiusG),
                  minWidth: Snackbar.minWidth,
                  height: Snackbar.height,
                  color: Snackbar.colorButton,
                  child: Snackbar.iconButton,
                  onPressed: () {
                    //Remover shared_key e buscar dados API e atualizar a tela
                    timeout = 20;
                    Get.back();
                    controller = Provider.of<Controller>(Get.context, listen: false);
                    controller.buscarPlaca();
                  })));
    } on SocketException catch (e) {
      print('Socket Error: $e');
      return null;
    } on Error catch (e) {
      print('General Error: $e');
      return null;
    }
  }
}
