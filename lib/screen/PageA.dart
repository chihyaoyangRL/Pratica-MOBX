import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pratica_mobx/Controller/controller.dart';
import 'package:pratica_mobx/screen/Home.dart';
import 'package:pratica_mobx/utlis/CustomCardList.dart';
import 'package:pratica_mobx/utlis/Dialog.dart';
import 'package:pratica_mobx/utlis/Lifecycle.dart';
import 'package:provider/provider.dart';

class PageA extends StatefulWidget {
  @override
  _PageAState createState() => _PageAState();
}

class _PageAState extends State<PageA> with WidgetsBindingObserver {
  Dialogs dialog = new Dialogs();
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
            Get.offAll(PageA());
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
            title: Text('Page A Switch Status', style: TextStyle(color: Colors.white)),
            leading: IconButton(
              icon: Icon(Icons.keyboard_backspace),
              onPressed: () => Get.offAll(Home()),
            ),
          ),
          backgroundColor: controller.status ? Colors.yellow : Colors.green,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => Get.defaultDialog(middleText: controller.numberClick.toString()),
                child: CustomCardList(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.orange, Colors.red],
                  ),
                  title: Text('Get Value from Main'),
                  circleColor: Colors.lightBlueAccent,
                  icon: Icon(FontAwesomeIcons.sortNumericUp, color: Colors.white),
                ),
              ),
              GestureDetector(
                onTap: () => Get.defaultDialog(middleText: controller.list.toString()),
                child: CustomCardList(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.purpleAccent, Colors.deepPurpleAccent],
                  ),
                  title: Text('Get Value from List'),
                  circleColor: Colors.lightBlueAccent,
                  icon: Icon(FontAwesomeIcons.list, color: Colors.white),
                ),
              ),
            ],
          ),
          floatingActionButton: new FloatingActionButton(
            child: new Icon(FontAwesomeIcons.toggleOn),
            onPressed: () {
              Get.generalDialog(
                barrierColor: Colors.black.withOpacity(0.5),
                transitionDuration: Duration(milliseconds: 200),
                barrierDismissible: true,
                barrierLabel: '',
                pageBuilder: (context, animation1, animation2) {},
                transitionBuilder: (context, animation, secondaryAnimation, child) {
                  return dialog.transitionBuilder(
                    context,
                    animation,
                    secondaryAnimation,
                    child,
                    Column(
                      children: [
                        Observer(
                          builder: (_) {
                            return Center(
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: controller.status ? Colors.yellow : Colors.green,
                                ),
                              ),
                            );
                          },
                        ),
                        Observer(
                          builder: (_) {
                            return Center(
                              child: Switch(
                                value: controller.status,
                                activeTrackColor: Colors.lightGreenAccent,
                                activeColor: Colors.green,
                                onChanged: (value) {
                                  controller.change(value);
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
