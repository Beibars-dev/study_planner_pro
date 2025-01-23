import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_planner_pro_app/cubit/app_cubit_states.dart';
import 'package:study_planner_pro_app/cubit/app_cubits.dart';
import 'package:study_planner_pro_app/pages/log_in_page.dart';
import 'package:study_planner_pro_app/pages/welcome_page.dart';

class AppCubitLogics extends StatefulWidget {
  const AppCubitLogics({super.key});

  @override
  State<AppCubitLogics> createState() => _AppCubitLogicsState();
}

class _AppCubitLogicsState extends State<AppCubitLogics> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AppCubits, CubitStates>(builder: (context, state) {
        if (state is LoginState) {
          return LoginPage();
        } else {
          return Container();
        }
      }),
    );
  }
}
