import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pratica_mobx/Controller/controller.dart';
import 'package:pratica_mobx/utlis/CustomCardList.dart';
import 'package:pratica_mobx/utlis/Dialog.dart';
import 'package:pratica_mobx/utlis/Lifecycle.dart';
import 'package:provider/provider.dart';
import 'Home.dart';

class PageB extends StatefulWidget {
  @override
  _PageBState createState() => _PageBState();
}

class _PageBState extends State<PageB> with WidgetsBindingObserver {
  Dialogs dialog = new Dialogs();
  Lifecycle lifecycle = new Lifecycle();
  Controller control;

  @override
  void initState() {
    super.initState();
    lifecycle.addListner(this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    control ??= Provider.of<Controller>(context);
  }

  Future<Null> _refresh() async {
    control.refresh();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.paused:
        if (this.mounted) {
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            lifecycle.removerListner(this);
            control.removeShared();
            Get.offAll(PageB());
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
            title: Text('Page B Lista Simples', style: TextStyle(color: Colors.white)),
            leading: IconButton(
              icon: Icon(Icons.keyboard_backspace),
              onPressed: () => Get.offAll(Home()),
            ),
          ),
          body: RefreshIndicator(
            onRefresh: _refresh,
            child: ListView.builder(
              padding: const EdgeInsets.only(bottom: kFloatingActionButtonMargin + 65),
              itemCount: controller.list.length,
              itemBuilder: (context, index) {
                return CustomCardList(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.deepPurpleAccent, Colors.lightBlue],
                  ),
                  title: Text(controller.list[index]),
                  circleColor: Colors.lightBlueAccent,
                  icon: Icon(FontAwesomeIcons.list, color: Colors.white),
                );
              },
            ),
          ),
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                child: Icon(FontAwesomeIcons.windows),
                heroTag: null,
                onPressed: () => Get.defaultDialog(middleText: controller.numberClick.toString()),
              ),
              SizedBox(width: 5),
              FloatingActionButton(
                onPressed: () => controller.addList(),
                child: Icon(Icons.add),
                heroTag: null,
              )
            ],
          ),
        );
      },
    );
  }
}
