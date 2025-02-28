part of 'edit_bloc.dart';

@immutable
sealed class EditState {}

final class EditInitial extends EditState {}

sealed class EditActionState extends EditState {}

class EditCancelButtonAction extends EditState {}

class SumbitButtonAction extends EditState {}

class TaskCompletedState extends EditActionState {
  final bool isCompleted;

  TaskCompletedState({required this.isCompleted});
}
