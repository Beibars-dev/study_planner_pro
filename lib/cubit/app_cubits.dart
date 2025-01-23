import 'package:bloc/bloc.dart';
import 'package:study_planner_pro_app/cubit/app_cubit_states.dart';

class AppCubits extends Cubit<CubitStates> {
  AppCubits() : super(InitialState()) {
    emit(LoginState());
  }
}
