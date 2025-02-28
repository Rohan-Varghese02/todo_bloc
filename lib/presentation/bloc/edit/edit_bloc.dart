import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_bloc/core/api/api.dart';
import 'package:todo_bloc/data/models/todo_model.dart';

part 'edit_event.dart';
part 'edit_state.dart';

class EditBloc extends Bloc<EditEvent, EditState> {
  EditBloc() : super(EditInitial()) {
    on<EditCancelButtonClicked>(editCancelButtonClicked);
    on<TaskCompleteButtonClicked>(taskCompleteButtonClicked);
    on<EditSubmitButton>(editSubmitButton);
  }

  FutureOr<void> editCancelButtonClicked(
    EditCancelButtonClicked event,
    Emitter<EditState> emit,
  ) {
    print('Cancel Clicked');
    emit(EditCancelButtonAction());
  }

  FutureOr<void> taskCompleteButtonClicked(
    TaskCompleteButtonClicked event,
    Emitter<EditState> emit,
  ) {
    emit(TaskCompletedState(isCompleted: event.isCompleted));
  }

  FutureOr<void> editSubmitButton(
    EditSubmitButton event,
    Emitter<EditState> emit,
  ) async {
    print(event.todo.title);
    await editTodo(event.todo);
    emit(SumbitButtonAction());
  }
}
