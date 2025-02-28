import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/core/constants/colors.dart';
import 'package:todo_bloc/presentation/bloc/home/home_bloc.dart';
import 'package:todo_bloc/presentation/pages/add_task_screen.dart';
import 'package:todo_bloc/presentation/pages/edit_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeBloc homeBloc = HomeBloc();
  @override
  void initState() {
    super.initState();
    homeBloc.add(HomeIntialFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      buildWhen: (previous, current) => current is! HomeActionState,
      listenWhen: (previous, current) => current is HomeActionState,
      listener: (context, state) {
        if (state is HomeNavigateToTaskState) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddTaskScreen()))
              .then((value) {
                homeBloc.add(HomeIntialFetchEvent());
              });
        } else if (state is HomeEditNavigationState) {
          final editState = state;
          Navigator.of(context)
              .push(
                MaterialPageRoute(
                  builder: (_) => EditPage(todo: editState.todo),
                ),
              )
              .then((value) {
                homeBloc.add(HomeIntialFetchEvent());
              });
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return Scaffold(
              backgroundColor: bgColor,
              appBar: AppBar(
                title: Text('Todo List', style: TextStyle(color: Colors.amber)),
                centerTitle: true,
                backgroundColor: appBarColor,
              ),
              body: Center(child: CircularProgressIndicator()),
            );
          case HomeLoadSucessState:
            final todoState = state as HomeLoadSucessState;
            return Scaffold(
              backgroundColor: bgColor,
              appBar: AppBar(
                title: Text('Todo List', style: TextStyle(color: Colors.amber)),
                centerTitle: true,
                backgroundColor: appBarColor,
              ),
              body: ListView.builder(
                itemCount: todoState.todos.length,
                itemBuilder: (context, index) {
                  bool isComplted = todoState.todos[index].isCompleted;
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.amber,
                      child: Center(
                        child:
                            isComplted
                                ? Icon(Icons.check, color: Colors.greenAccent)
                                : Icon(Icons.close, color: Colors.redAccent),
                      ),
                    ),
                    title:
                        isComplted
                            ? Text(
                              todoState.todos[index].title,
                              style: TextStyle(
                                color: Colors.yellow,
                                decoration: TextDecoration.lineThrough,
                                decorationColor: Colors.yellow,
                              ),
                            )
                            : Text(
                              todoState.todos[index].title,
                              style: TextStyle(color: Colors.yellow),
                            ),
                    subtitle: Text(todoState.todos[index].description),
                    trailing: PopupMenuButton(
                      itemBuilder: (context) {
                        return [
                          PopupMenuItem(
                            child: Text('Delete'),
                            onTap: () {
                              homeBloc.add(
                                HomeItemDeleteEvent(
                                  id: todoState.todos[index].id ?? '',
                                ),
                              );
                              homeBloc.add(HomeIntialFetchEvent());
                            },
                          ),
                          PopupMenuItem(
                            child: Text('Edit'),
                            onTap: () {
                              homeBloc.add(
                                HomeEditButtonEvent(
                                  todo: todoState.todos[index],
                                ),
                              );
                            },
                          ),
                        ];
                      },
                    ),
                  );
                },
              ),

              floatingActionButton: FloatingActionButton(
                backgroundColor: Colors.amber,
                onPressed: () {
                  homeBloc.add(HomeNavigateToTaskEvent());
                },
                child: Icon(Icons.add, color: Colors.black),
              ),
            );
          default:
            return SizedBox();
        }
      },
    );
  }
}
