import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_bloc/core/api/api.dart';
import 'package:todo_bloc/data/models/todo_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeNavigateToTaskEvent>(homeNavigateToTaskEvent);
    on<HomeIntialFetchEvent>(homeIntialFetchEvent);
    on<HomeItemDeleteEvent>(homeItemDeleteEvent);
    on<HomeEditButtonEvent>(homeEditButtonEvent);
  }

  FutureOr<void> homeNavigateToTaskEvent(
    HomeNavigateToTaskEvent event,
    Emitter<HomeState> emit,
  ) {
    print('Task button Pressed');
    emit(HomeNavigateToTaskState());
  }

  FutureOr<void> homeIntialFetchEvent(
    HomeIntialFetchEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoadingState());
    await Future.delayed(Duration(seconds: 0));
    List<TodoModel> todoList = await intialFetch();
    print(todoList);
    print(todoList.length);
    emit(HomeLoadSucessState(todos: todoList));
  }

  FutureOr<void> homeItemDeleteEvent(
    HomeItemDeleteEvent event,
    Emitter<HomeState> emit,
  ) async {
    await deleteTodo(event.id);
    print('Delete Button Clicked');
  }

  FutureOr<void> homeEditButtonEvent(
    HomeEditButtonEvent event,
    Emitter<HomeState> emit,
  ) {
    print('Edit Button Clicked');
    emit(HomeEditNavigationState(todo: event.todo));
  }
}
