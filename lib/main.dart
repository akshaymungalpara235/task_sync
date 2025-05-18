import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_sync/data/database/database_helper.dart';
import 'package:task_sync/presentation/task/bloc/task_bloc.dart';
import 'package:task_sync/presentation/task/screen/task_screen.dart';
import 'package:task_sync/utils/app_strings/app_strings.dart';
import 'package:task_sync/utils/network_utils/network_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize SQLite database
  await DatabaseHelper.instance.database;
  // Initialize NetworkUtils
  await NetworkUtils().initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskBloc()..add(LoadTasks()),
      child: MaterialApp(
        title: AppStrings.appName,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        home: TaskScreen(),
      ),
    );
  }
}
