import 'package:bot_toast/bot_toast.dart';
import 'package:cry/common/application_context.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'home.dart';

void main() async {
  await init();
  runApp(MyApp());
}

init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ApplicationContext.instance.init();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'FLUTTER_PORTAL',
      builder: BotToastInit(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}
