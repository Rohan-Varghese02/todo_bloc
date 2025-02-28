part of 'task_bloc.dart';

@immutable
sealed class TaskEvent {}

class CancelButtonEvent extends TaskEvent {}

class SumbitButtonEvent extends TaskEvent {
  final TodoModel todos;

  SumbitButtonEvent({required this.todos});
}



