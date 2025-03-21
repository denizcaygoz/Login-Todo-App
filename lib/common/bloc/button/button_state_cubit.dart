import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_todo_app/common/bloc/button/button_state.dart';
import '../../../core/usecase/usecase.dart';
import '../../../data/database.dart';
import '../../../data/models/todos.dart';
import '../../../domain/entities/todos.dart';
import '../../../service_locator.dart';

class ButtonStateCubit extends Cubit<ButtonState> {
  ButtonStateCubit() : super(ButtonInitialState());

  void execute({dynamic params, required UseCase usecase}) async {
    emit(ButtonLoadingState());
    await Future.delayed(const Duration(seconds: 2));
    try {
      Either result = await usecase.call(param: params);

      result.fold((error) {
        emit(ButtonFailureState(errorMessage: error));
      }, (data) {
        emit(ButtonSuccessState());
        Response response = data;
        List<dynamic> todosData = response.data['todos'];

        List<TodosModel> todosList =
            todosData.map((todo) => TodosModel.fromMap(todo)).toList();

        List<TodosEntity> todosEntityList =
            todosList.map((todo) => todo.toEntity()).toList();

        ToDoDataBase db = sl<ToDoDataBase>();
        db.toDoList = todosEntityList;
        db.setUpData();
      });
    } catch (e) {
      emit(ButtonFailureState(errorMessage: e.toString()));
    }
  }
}
