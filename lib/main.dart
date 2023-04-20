import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:udevs_todo/bloc/todo_bloc.dart';
import 'package:udevs_todo/core/assets/constants/storage_keys.dart';
import 'package:udevs_todo/data/models/todo_hive_model.dart';
import 'package:udevs_todo/presentation/tabs/tab_page.dart';

import 'presentation/on_boarding/pages/on_boarding_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // INIT HIVE
  await Hive.initFlutter();
  await Hive.openBox(StorageKeys.todoBox);
  Hive.registerAdapter(TodoHiveModelAdapter());

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
    return MultiBlocProvider(
      providers: [
        BlocProvider<TodoBloc>(create: (context) => TodoBloc(),)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.lightBlue,
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.lightBlue),
        ),
        home: TabPage(),
      ),
    );
  }
}
