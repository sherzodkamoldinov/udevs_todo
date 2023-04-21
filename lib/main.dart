import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:udevs_todo/bloc/category_bloc/category_bloc.dart';
import 'package:udevs_todo/bloc/setting_bloc/setting_bloc.dart';
import 'package:udevs_todo/bloc/todo_bloc/todo_bloc.dart';
import 'package:udevs_todo/core/assets/constants/route_keys.dart';
import 'package:udevs_todo/core/assets/constants/storage_keys.dart';
import 'package:udevs_todo/data/models/category_model/category_hive_model.dart';
import 'package:udevs_todo/data/models/todo_model/todo_hive_model.dart';
import 'package:udevs_todo/data/repositories/shared_pref.dart';
import 'package:udevs_todo/presentation/router/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // init storage repo
  await StorageRepository.getInstance();

  // init hive
  await Hive.initFlutter();
  Hive.registerAdapter(TodoHiveModelAdapter());
  Hive.registerAdapter(CategoryHiveModelAdapter());
  await Hive.openBox<TodoHiveModel>(StorageKeys.todoBox);
  await Hive.openBox<CategoryHiveModel>(StorageKeys.categoryBox);
  

  // portrait view set
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
        BlocProvider<TodoBloc>(
          create: (context) => TodoBloc()..add(GetTodosEvent()),
        ),
        BlocProvider<CategoryBloc>(
          create: (context) => CategoryBloc()..add(GetCategoryEvent()),
        ),
        BlocProvider<SettingBloc>(
          create: (context) => SettingBloc()..add(GetUserInfoEvent()),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.lightBlue,
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.lightBlue),
        ),
        onGenerateRoute: AppRouter.onGenerateRoute,
        initialRoute: splashPage,
      ),
    );
  }
}
