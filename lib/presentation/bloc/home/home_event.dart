part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class HomeNavigateToTaskEvent extends HomeEvent {}

class HomeIntialFetchEvent extends HomeEvent {}

class HomeItemDeleteEvent extends HomeEvent {
  final String id;

  HomeItemDeleteEvent({required this.id});
}

class HomeEditButtonEvent extends HomeEvent {
  final TodoModel todo;

  HomeEditButtonEvent({required this.todo});
}
