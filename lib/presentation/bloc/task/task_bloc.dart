import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_bloc/core/api/api.dart';
import 'package:todo_bloc/data/models/todo_model.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(TaskInitial()) {
    on<CancelButtonEvent>(cancelButtonEvent);
    on<SumbitButtonEvent>(sumbitButtonEvent);
  }

  FutureOr<void> cancelButtonEvent(
    CancelButtonEvent event,
    Emitter<TaskState> emit,
  ) {
    print('pressed cancel ');
    emit(CancelButtonState());
  }

  FutureOr<void> sumbitButtonEvent(
    SumbitButtonEvent event,
    Emitter<TaskState> emit,
  ) async {
    bool success = await addEvent(event.todos);
    log(success.toString());
    emit(TaskSubmittedState());
    emit(SubmitButtonState());
  
  }
}
