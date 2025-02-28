part of 'edit_bloc.dart';

@immutable
sealed class EditEvent {}

class EditCancelButtonClicked extends EditEvent {}

class TaskCompleteButtonClicked extends EditEvent {
  final bool isCompleted;

  TaskCompleteButtonClicked({required this.isCompleted});
}

class EditSubmitButton extends EditEvent {
  final TodoModel todo;

  EditSubmitButton({required this.todo});
}
