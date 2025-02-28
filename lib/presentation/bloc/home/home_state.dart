part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

sealed class HomeActionState extends HomeState {}

final class HomeInitial extends HomeState {}

class HomeNavigateToTaskState extends HomeActionState {}

class HomeLoadSucessState extends HomeState {
  final List<TodoModel> todos;

  HomeLoadSucessState({required this.todos});
}

class HomeLoadingState extends HomeState {}

class HomeEditNavigationState extends HomeActionState {
  final TodoModel todo;

  HomeEditNavigationState({required this.todo});
}
