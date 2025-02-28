part of 'task_bloc.dart';

@immutable
sealed class TaskState {}

sealed class TaskActionState extends TaskState{

}
final class TaskInitial extends TaskState {}


class CancelButtonState extends TaskActionState{

}

class DropDownMenuState extends TaskState{

}
class TaskSubmittedState extends TaskState {
  
}
class SubmitButtonState extends TaskActionState{}