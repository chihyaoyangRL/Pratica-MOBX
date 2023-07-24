import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pratica_mobx/Controller/controller.dart';
import 'package:pratica_mobx/ControllerTheme/theme.dart';
import 'package:pratica_mobx/screen/PageA.dart';
import 'package:pratica_mobx/screen/PageB.dart';
import 'package:pratica_mobx/screen/PageC.dart';
import 'package:pratica_mobx/screen/PageD.dart';
import 'package:pratica_mobx/utlis/CustomCard.dart';
import 'package:pratica_mobx/utlis/CustomCardList.dart';
import 'package:pratica_mobx/utlis/Dialog.dart';
import 'package:pratica_mobx/utlis/Lifecycle.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with WidgetsBindingObserver {
  Dialogs dialog = new Dialogs();
  Lifecycle lifecycle = new Lifecycle();
  ThemeStore themeServers;
  Controller controll;
  var valor;

  @override
  void initState() {
    super.initState();
    lifecycle.addListner(this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    themeServers ??= Provider.of<ThemeStore>(context);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.paused:
        if (this.mounted) {
          //Quando widget estiver carregado
          //remover listner primeiro, depois remover shared_Key
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            lifecycle.removerListner(this);
            controll = Provider.of<Controller>(context, listen: false);
            controll.removeShared();
            Get.offAll(Home());
          });
        }
        break;
    }
  }

  @override
  void dispose() {
    super.dispose();
    lifecycle.removerListner(this);
  }

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<Controller>(context);
    return Observer(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: Text('MobX', style: TextStyle(color: Colors.white)),
            actions: [
              Switch(
                value: themeServers.isDark,
                onChanged: (value) => themeServers.toggleTheme(),
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(bottom: kFloatingActionButtonMargin + 55),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 80,
                    width: Get.width,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.pinkAccent, Colors.blueAccent],
                      ),
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.elliptical(400, 200),
                        bottomLeft: Radius.elliptical(400, 200),
                      ),
                    ),
                    child: Center(
                      child: Text('${controller.numberClick}', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  Container(
                    height: 216,
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: [
                        GestureDetector(
                          onTap: () {
                            lifecycle.removerListner(this);
                            Get.to(PageA());
                          },
                          child: CustomCard(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Colors.purple, Colors.blue],
                            ),
                            title: Text('Page A'),
                            description: Text('Switch de Status'),
                            circleColor: Colors.orange,
                            icon: Icon(FontAwesomeIcons.toggleOn, color: Colors.white),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            lifecycle.removerListner(this);
                            Get.to(PageB());
                          },
                          child: CustomCard(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Colors.blueAccent, Colors.greenAccent],
                            ),
                            title: Text('Page B'),
                            description: Text('Listas Simples'),
                            circleColor: Colors.pinkAccent,
                            icon: Icon(Icons.list, color: Colors.white),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            lifecycle.removerListner(this);
                            Get.to(PageC());
                          },
                          child: CustomCard(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Colors.pinkAccent, Colors.tealAccent],
                            ),
                            title: Text('Page C'),
                            description: Text('Valor API'),
                            circleColor: Colors.purpleAccent,
                            icon: Icon(FontAwesomeIcons.database, color: Colors.white),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            lifecycle.removerListner(this);
                            Get.to(PageD());
                          },
                          child: CustomCard(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Colors.blueAccent, Colors.greenAccent],
                            ),
                            title: Text('Page D'),
                            description: Text('Formulário'),
                            circleColor: Colors.indigoAccent,
                            icon: Icon(FontAwesomeIcons.edit, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //todo divider ↓
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(left: 15.0, right: 20.0),
                          child: Divider(color: Colors.blue, height: 5),
                        ),
                      ),
                      Icon(Icons.assistant_photo, size: 25),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(left: 20.0, right: 15.0),
                          child: Divider(color: Colors.blue, height: 5),
                        ),
                      ),
                    ],
                  ),
                  //todo divider ↑
                  GestureDetector(
                    onTap: () async {
                      if (await controller.getUu()) {
                        Get.defaultDialog(middleText: controller.users.nome.toString());
                      } else {
                        Get.defaultDialog(middleText: 'Nada Encontrado');
                      }
                    },
                    child: CustomCardList(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.greenAccent, Colors.redAccent],
                      ),
                      title: Text('Get Value API from Page C'),
                      circleColor: Colors.lightBlue,
                      icon: Icon(FontAwesomeIcons.pagelines, color: Colors.white),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.defaultDialog(middleText: controller.getStatus.toString()),
                    child: CustomCardList(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.blueAccent.withOpacity(0.9), Colors.green.withOpacity(0.4)],
                      ),
                      title: Text('Get Status from Page A'),
                      circleColor: Colors.lightBlueAccent,
                      icon: Icon(FontAwesomeIcons.paperPlane, color: Colors.white),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => controller.removeList(),
                    child: CustomCardList(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.teal, Colors.lightBlue],
                      ),
                      title: Text('Remove último item da lista da Page B'),
                      circleColor: Colors.tealAccent,
                      icon: Icon(FontAwesomeIcons.trash, color: Colors.white),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => controller.removeAll(),
                    child: CustomCardList(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.pinkAccent, Colors.purpleAccent],
                      ),
                      title: Text('Remove toda item da lista da Page B'),
                      circleColor: Colors.yellow,
                      icon: Icon(FontAwesomeIcons.eraser, color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () => controller.addClick(),
          ),
        );
      },
    );
  }
}
