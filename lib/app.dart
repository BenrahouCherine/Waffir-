import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:waffir/entry.dart';
import 'package:waffir/utils/bindings/app_bindings.dart';
import 'package:waffir/utils/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Waffir',
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      theme: TAppTheme.lightTheme,
      home: const EntryPage(),
      initialBinding: AppBindings(),
    );
  }
}
