import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get/get.dart';
import 'package:pratica_mobx/utlis/theme_service.dart';
import 'package:provider/provider.dart';
import 'Controller/controller.dart';
import 'ControllerTheme/theme.dart';
import 'screen/Home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ThemeStore>(create: (_) => ThemeStore(ThemeService(ThemeRepository()))..getTheme()),
        // load data from controller
        Provider<Controller>(
            create: (_) => Controller()
              ..getSharedStatus()
              ..loadTodos()
              //Quando entra APP remove shared_key
              ..removeShared()),
      ],
      child: Consumer<ThemeStore>(
        builder: (_, ThemeStore value, __) => Observer(
          builder: (_) => GetMaterialApp(
            debugShowCheckedModeBanner: false,
            theme: value.theme,
            home: Home(),
          ),
        ),
      ),
    );
  }
}
