// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Controller on ControllerBase, Store {
  Computed<bool> _$getStatusComputed;

  @override
  bool get getStatus =>
      (_$getStatusComputed ??= Computed<bool>(() => super.getStatus,
              name: 'ControllerBase.getStatus'))
          .value;

  final _$textControllerAtom = Atom(name: 'ControllerBase.textController');

  @override
  TextEditingController get textController {
    _$textControllerAtom.reportRead();
    return super.textController;
  }

  @override
  set textController(TextEditingController value) {
    _$textControllerAtom.reportWrite(value, super.textController, () {
      super.textController = value;
    });
  }

  final _$numberClickAtom = Atom(name: 'ControllerBase.numberClick');

  @override
  int get numberClick {
    _$numberClickAtom.reportRead();
    return super.numberClick;
  }

  @override
  set numberClick(int value) {
    _$numberClickAtom.reportWrite(value, super.numberClick, () {
      super.numberClick = value;
    });
  }

  final _$listAtom = Atom(name: 'ControllerBase.list');

  @override
  ObservableList<String> get list {
    _$listAtom.reportRead();
    return super.list;
  }

  @override
  set list(ObservableList<String> value) {
    _$listAtom.reportWrite(value, super.list, () {
      super.list = value;
    });
  }

  final _$usersAtom = Atom(name: 'ControllerBase.users');

  @override
  UsuarioModel get users {
    _$usersAtom.reportRead();
    return super.users;
  }

  @override
  set users(UsuarioModel value) {
    _$usersAtom.reportWrite(value, super.users, () {
      super.users = value;
    });
  }

  final _$userAtom = Atom(name: 'ControllerBase.user');

  @override
  Future<List<UsuarioModel>> get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(Future<List<UsuarioModel>> value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  final _$alocacaoAtom = Atom(name: 'ControllerBase.alocacao');

  @override
  Future<List<Alocacao>> get alocacao {
    _$alocacaoAtom.reportRead();
    return super.alocacao;
  }

  @override
  set alocacao(Future<List<Alocacao>> value) {
    _$alocacaoAtom.reportWrite(value, super.alocacao, () {
      super.alocacao = value;
    });
  }

  final _$statusAtom = Atom(name: 'ControllerBase.status');

  @override
  bool get status {
    _$statusAtom.reportRead();
    return super.status;
  }

  @override
  set status(bool value) {
    _$statusAtom.reportWrite(value, super.status, () {
      super.status = value;
    });
  }

  final _$getUuAsyncAction = AsyncAction('ControllerBase.getUu');

  @override
  Future<bool> getUu() {
    return _$getUuAsyncAction.run(() => super.getUu());
  }

  final _$getUserAsyncAction = AsyncAction('ControllerBase.getUser');

  @override
  Future getUser() {
    return _$getUserAsyncAction.run(() => super.getUser());
  }

  final _$refreshUserAsyncAction = AsyncAction('ControllerBase.refreshUser');

  @override
  Future refreshUser() {
    return _$refreshUserAsyncAction.run(() => super.refreshUser());
  }

  final _$buscarPlacaAsyncAction = AsyncAction('ControllerBase.buscarPlaca');

  @override
  Future buscarPlaca() {
    return _$buscarPlacaAsyncAction.run(() => super.buscarPlaca());
  }

  final _$changeAsyncAction = AsyncAction('ControllerBase.change');

  @override
  Future change(bool value) {
    return _$changeAsyncAction.run(() => super.change(value));
  }

  final _$removeSharedAsyncAction = AsyncAction('ControllerBase.removeShared');

  @override
  Future removeShared() {
    return _$removeSharedAsyncAction.run(() => super.removeShared());
  }

  final _$ControllerBaseActionController =
      ActionController(name: 'ControllerBase');

  @override
  dynamic addClick() {
    final _$actionInfo = _$ControllerBaseActionController.startAction(
        name: 'ControllerBase.addClick');
    try {
      return super.addClick();
    } finally {
      _$ControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic loadTodos() {
    final _$actionInfo = _$ControllerBaseActionController.startAction(
        name: 'ControllerBase.loadTodos');
    try {
      return super.loadTodos();
    } finally {
      _$ControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic refresh() {
    final _$actionInfo = _$ControllerBaseActionController.startAction(
        name: 'ControllerBase.refresh');
    try {
      return super.refresh();
    } finally {
      _$ControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic removeList() {
    final _$actionInfo = _$ControllerBaseActionController.startAction(
        name: 'ControllerBase.removeList');
    try {
      return super.removeList();
    } finally {
      _$ControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic removeAll() {
    final _$actionInfo = _$ControllerBaseActionController.startAction(
        name: 'ControllerBase.removeAll');
    try {
      return super.removeAll();
    } finally {
      _$ControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic addList() {
    final _$actionInfo = _$ControllerBaseActionController.startAction(
        name: 'ControllerBase.addList');
    try {
      return super.addList();
    } finally {
      _$ControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic reset() {
    final _$actionInfo = _$ControllerBaseActionController.startAction(
        name: 'ControllerBase.reset');
    try {
      return super.reset();
    } finally {
      _$ControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
textController: ${textController},
numberClick: ${numberClick},
list: ${list},
users: ${users},
user: ${user},
alocacao: ${alocacao},
status: ${status},
getStatus: ${getStatus}
    ''';
  }
}
