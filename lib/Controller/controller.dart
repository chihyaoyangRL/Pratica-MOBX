import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobx/mobx.dart';
import 'package:pratica_mobx/model/AlocacoesModel.dart';
import 'package:pratica_mobx/model/UsuarioModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../base/Api.dart';

part 'controller.g.dart';

class Controller = ControllerBase with _$Controller;

abstract class ControllerBase with Store {
  @observable
  TextEditingController textController = TextEditingController();

  @observable
  int numberClick = 0;

  @observable
  ObservableList<String> list = ObservableList<String>();

  @observable
  UsuarioModel users;

  @observable
  Future<List<UsuarioModel>> user;

  @observable
  Future<List<Alocacao>> alocacao;

  @observable
  bool status;

  @computed
  bool get getStatus => status;

  @action
  Future<bool> getUu() async {
    if (user != null) {
      List<UsuarioModel> userInfos = await user;
      users = userInfos[0];
      return true;
    } else {
      return false;
    }
  }

  @action
  getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('value_API') == null) {
      print('Get Value from API');
      Api api = Api();
      user = api.getUserInfo();
      prefs.setBool('value_API', true);
    } else {
      print('Não buscar dados API');
    }
  }

  @action
  refreshUser() async {
    print('Recarregando valor API');
    Api api = Api();
    user = api.getUserInfo();
  }

  @action
  buscarPlaca() async {
    print('Buscando dados API');
    Api api = Api();
    alocacao = api.pesquisar('all', textController.text + '/naopagos');
  }

  //Faz get no main para usar em todos lugar e só instanciando
  //var controller = Provider.of<Controller>(context);
  @override
  Future<bool> getSharedStatus() async {
    print('Loading status . . .');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    this.status = prefs.getBool('status') ?? false;
    return prefs.getBool('status') ?? false;
  }

  @action
  addClick() {
    numberClick++;
  }

  @action
  loadTodos() {
    print('Loading data . . .');
    List<String> aa = ['A', 'B', 'C'];
    this.list.addAll(aa);
  }

  @action
  refresh() {
    print('Refresh data . . .');
    list.clear();
    List<String> aa = ['A', 'B', 'C'];
    this.list.addAll(aa);
  }

  @action
  removeList() {
    print('Remove list . . .');
    if (list.isNotEmpty && list != null) {
      this.list.removeLast();
    } else {
      Get.defaultDialog(middleText: 'Lista vazio !');
    }
  }

  @action
  removeAll() {
    print('Remove All list . . .');
    if (list.isNotEmpty && list != null) {
      this.list.clear();
    } else {
      Get.defaultDialog(middleText: 'Lista vazio !');
    }
  }

  @action
  addList() {
    List<String> data = ['D', 'E', 'F', 'G', 'H', 'I', 'J', 'K'];
    this.list.addAll(data);
  }

  @action
  change(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('status', value);
    this.status = value;
  }

  @action
  removeShared() async {
    print('Removido Shared_Key');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('value_API');
  }

  @action
  reset() {
    print('Resertando buscar valor da alocação');
    textController.clear();
    alocacao = null;
  }
}
