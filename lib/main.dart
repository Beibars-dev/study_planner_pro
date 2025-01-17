import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_planner_pro_app/cubit/app_cubit_logics.dart';
import 'package:study_planner_pro_app/cubit/app_cubits.dart';
import 'package:study_planner_pro_app/firebase_options.dart';
import 'package:study_planner_pro_app/pages/home_page.dart';
import 'package:study_planner_pro_app/pages/log_in_page.dart';
import 'package:study_planner_pro_app/pages/registration_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BlocProvider<AppCubits>(
            create: (context) => AppCubits(), child: AppCubitLogics()));
  }
}
