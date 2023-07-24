import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:pratica_mobx/Controller/controller.dart';
import 'package:pratica_mobx/model/AlocacoesModel.dart';
import 'package:pratica_mobx/utlis/Lifecycle.dart';
import 'package:provider/provider.dart';
import 'Home.dart';

class PageD extends StatefulWidget {
  @override
  _PageDState createState() => _PageDState();
}

class _PageDState extends State<PageD> with WidgetsBindingObserver {
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
            controll = Provider.of<Controller>(context, listen: false);
            controll.removeShared();
            Get.offAll(PageD());
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
    controll.reset();
    lifecycle.removerListner(this);
  }

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<Controller>(context);
    return Observer(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Page D Formulário', style: TextStyle(color: Colors.white)),
            leading: IconButton(
              icon: Icon(Icons.keyboard_backspace),
              onPressed: () => Get.offAll(Home()),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 80,
                  width: Get.width,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.deepPurpleAccent.withOpacity(0.9), Colors.blueAccent],
                    ),
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.elliptical(150, 200),
                    ),
                  ),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(left: 10, right: 30),
                      child: TextField(
                        controller: controller.textController,
                        style: TextStyle(color: Colors.white),
                        keyboardType: TextInputType.emailAddress,
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 10, right: 3),
                          labelText: 'Placa',
                          hintText: 'Digite uma placa',
                          prefixIcon: Container(child: Icon(FontAwesomeIcons.idCard, color: Colors.white)),
                          labelStyle: TextStyle(color: Colors.white),
                          hintStyle: TextStyle(color: Colors.white),
                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                        ),
                        onEditingComplete: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          controller.buscarPlaca();
                        },
                      ),
                    ),
                  ),
                ),
                Container(
                  child: FutureBuilder<List<Alocacao>>(
                    future: controller.alocacao,
                    builder: (context, snapshot) {
                      return list(context, snapshot, controller);
                    },
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget list(context, snapshot, Controller controller) {
    switch (snapshot.connectionState) {
      case ConnectionState.none:
      case ConnectionState.waiting:
        return (controller.alocacao != null)
            ? Padding(
                padding: EdgeInsets.only(top: 150),
                child: Container(
                    height: 50,
                    width: 50,
                    child: Center(child: LoadingIndicator(indicatorType: Indicator.ballRotateChase))))
            : ListView(
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
        break;
      case ConnectionState.active:
      case ConnectionState.done:
        if (snapshot.data != null && !snapshot.data.isEmpty) {
          return ListView.builder(
            padding: const EdgeInsets.only(bottom: kFloatingActionButtonMargin + 5),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              List<Alocacao> alocacoes = snapshot.data;
              Alocacao alocacao = alocacoes[index];
              return Container(
                width: Get.width,
                child: Stack(
                  children: [
                    //todo card left ↓
                    Positioned(
                      top: 13,
                      left: Get.width * 0.2,
                      child: Container(
                        width: 80,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.deepPurpleAccent,
                          shape: BoxShape.rectangle,
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.elliptical(15, 10),
                            bottomLeft: Radius.elliptical(15, 10),
                            topRight: Radius.elliptical(350, 400),
                            topLeft: Radius.elliptical(350, 400),
                          ),
                        ),
                        child: Center(
                          child: Text(alocacao.veiculoNacao, style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ),
                    //todo card left ↑
                    //todo
                    Positioned(
                      top: 22,
                      right: 0,
                      child: RotationTransition(
                        turns: AlwaysStoppedAnimation(35 / 360),
                        child: Icon(FontAwesomeIcons.chessQueen, color: Colors.pinkAccent, size: 20),
                      ),
                    ),
                    //todo
                    //todo card Right ↓
                    Positioned(
                      top: 13,
                      left: Get.width * 0.6,
                      child: Container(
                        width: 80,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.deepPurpleAccent,
                          shape: BoxShape.rectangle,
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.elliptical(15, 10),
                            bottomLeft: Radius.elliptical(15, 10),
                            topRight: Radius.elliptical(350, 400),
                            topLeft: Radius.elliptical(350, 400),
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.timer, size: 15, color: Colors.white),
                            Text(alocacao.tempo, style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                    //todo card Right ↑
                    Padding(
                      padding: const EdgeInsets.only(top: 32, left: 8, right: 8),
                      child: Container(
                        height: 55,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Colors.deepPurpleAccent, Colors.lightBlue],
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(5.0),
                            bottomLeft: Radius.circular(5.0),
                            bottomRight: Radius.circular(15.0),
                            topRight: Radius.circular(15.0),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 35, right: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(alocacao.placa),
                                  Row(
                                    children: [
                                      Icon(FontAwesomeIcons.portrait, size: 15),
                                      Container(
                                        margin: EdgeInsets.only(top: 3),
                                        child: Text(' ' + alocacao.idNoHash),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            //todo divider ↓
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 15.0, right: 10.0),
                                    child: Divider(color: Colors.white, height: 5),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(Icons.location_on, size: 15),
                                    Text(alocacao.rua + ' - '),
                                    Text(alocacao.vaga),
                                  ],
                                ),
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 10.0, right: 15.0),
                                    child: Divider(color: Colors.white, height: 5),
                                  ),
                                ),
                              ],
                            ),
                            //todo divider ↑
                            Padding(
                              padding: EdgeInsets.only(right: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.calendar_today, size: 15),
                                  Text(alocacao.dataHora),
                                  Text(' ~ '),
                                  Text(alocacao.dataHoraExpiracao),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 15,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(color: Colors.lightBlueAccent, shape: BoxShape.circle),
                      ),
                    ),
                    (alocacao.tipo == 'auto')
                        ? Positioned(top: 22, left: 7, child: Icon(FontAwesomeIcons.car, color: Colors.white))
                        : Positioned(top: 22, left: 5, child: Icon(FontAwesomeIcons.motorcycle, color: Colors.white))
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
