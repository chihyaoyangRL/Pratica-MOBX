import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:pratica_mobx/Controller/controller.dart';
import 'package:pratica_mobx/model/UsuarioModel.dart';
import 'package:pratica_mobx/utlis/Lifecycle.dart';
import 'package:provider/provider.dart';
import 'Home.dart';

class PageC extends StatefulWidget {
  @override
  _PageCState createState() => _PageCState();
}

class _PageCState extends State<PageC> with WidgetsBindingObserver {
  Lifecycle lifecycle = new Lifecycle();
  Controller controll;

  @override
  void initState() {
    super.initState();
    lifecycle.addListner(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.paused:
        if (this.mounted) {
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            lifecycle.removerListner(this);
            controll.removeShared();
            Get.offAll(PageC());
          });
        }
        break;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    controll ??= Provider.of<Controller>(context);
  }

  @override
  void dispose() {
    super.dispose();
    lifecycle.removerListner(this);
  }

  Future<Null> _refresh() async {
    controll.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<Controller>(context);
    //Mas quando colocar shared é chamada apenas uma vez
    //e com AppLifecycle quando app ta em segundo plano
    //é removido key da shared e quando entra de novo será
    //chamado mais uma vez(Atualizando dados)
    controller.getUser();
    //todo Calll todas vez como initState ↑
    return Observer(
      builder: (_) {
        return Scaffold(
          body: RefreshIndicator(
            onRefresh: _refresh,
            child: Stack(
              children: <Widget>[
                CustomScrollView(
                  slivers: <Widget>[
                    SliverAppBar(
                      pinned: true,
                      floating: false,
                      expandedHeight: 50,
                      title: Text('Page C API', style: TextStyle(color: Colors.white)),
                      leading: IconButton(
                        icon: Icon(Icons.keyboard_backspace),
                        onPressed: () => Get.offAll(Home()),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate(
                        <Widget>[
                          Container(
                            child: FutureBuilder<List<UsuarioModel>>(
                              future: controller.user,
                              builder: (context, snapshot) {
                                return list(context, snapshot);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget list(context, snapshot) {
    switch (snapshot.connectionState) {
      case ConnectionState.none:
      case ConnectionState.waiting:
        return Padding(
            padding: EdgeInsets.only(top: 150),
            child: Container(
                height: 50,
                width: 50,
                child: Center(child: LoadingIndicator(indicatorType: Indicator.ballRotateChase))));
        break;
      case ConnectionState.active:
      case ConnectionState.done:
        if (snapshot.data != null && !snapshot.data.isEmpty) {
          return ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              List<UsuarioModel> userInfos = snapshot.data;
              UsuarioModel userInfo = userInfos[index];
              return Container(
                height: 350,
                width: Get.width,
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 32, left: 8, right: 8, bottom: 16),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Colors.lightBlueAccent, Colors.blueGrey],
                          ),
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(5.0),
                            bottomLeft: Radius.circular(45.0),
                            topLeft: Radius.circular(5.0),
                            topRight: Radius.circular(45.0),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 24, left: 8, right: 8, bottom: 8),
                          child: Column(
                            children: <Widget>[
                              Center(
                                  child:
                                      Text('User Info', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold))),
                              Expanded(
                                  child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                    Text('Nome: ', style: TextStyle(fontSize: 18)),
                                    Expanded(
                                      child: Text(
                                        userInfo.nome,
                                        maxLines: 1,
                                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                                      ),
                                    )
                                  ])),
                              Divider(height: 1, color: Colors.white),
                              Expanded(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text('Email: ', style: TextStyle(fontSize: 18)),
                                    Expanded(
                                      child: Text(
                                        userInfo.email,
                                        maxLines: 1,
                                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(height: 1, color: Colors.white),
                              Expanded(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text('RUC: ', style: TextStyle(fontSize: 18)),
                                    Expanded(
                                      child: Text(
                                        userInfo.ruc == "" ? 'nada ' : userInfo.ruc,
                                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(height: 1, color: Colors.white),
                              Expanded(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text('DOC: ', style: TextStyle(fontSize: 18)),
                                    Expanded(
                                      child: Text(
                                        userInfo.documento == "" ? 'nada ' : userInfo.documento,
                                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(height: 1, color: Colors.white),
                              Expanded(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text('Telefone: ', style: TextStyle(fontSize: 18)),
                                    Expanded(
                                        child: (userInfo.telefone != null)
                                            ? Text(
                                                userInfo.telefone,
                                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                                              )
                                            : Container()),
                                  ],
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(left: 15), child: Divider(height: 1, color: Colors.white))
                            ],
                          ),
                        ),
                      ),
                    ),
                    //todo posicionar elemento em cima de outro usando stack ↓
                    Positioned(
                      top: 15,
                      child: Container(
                        width: 55,
                        height: 55,
                        decoration: BoxDecoration(color: Colors.deepPurpleAccent, shape: BoxShape.circle),
                      ),
                    ),
                    Positioned(
                      top: 29,
                      left: 15,
                      child: Icon(FontAwesomeIcons.userAlt, color: Colors.white),
                    )
                    //todo posicionar elemento em cima de outro usando stack ↑
                  ],
                ),
              );
            },
          );
        } else {
          return ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              padding: EdgeInsets.fromLTRB(16, 150, 16, 50),
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(FontAwesomeIcons.search, color: Colors.red),
                    Text('Nada Encontrado !', style: TextStyle(color: Colors.red)),
                  ],
                )
              ]);
        }
        break;
    }
  }
}
