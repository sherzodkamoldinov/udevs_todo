import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:udevs_todo/presentation/tabs/tab_page.dart';

import 'presentation/on_boarding/pages/on_boarding_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // PORTRAIT VIEW SET
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.lightBlue,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.lightBlue),
      ),
      home: TabPage(),
    );
  }
}
