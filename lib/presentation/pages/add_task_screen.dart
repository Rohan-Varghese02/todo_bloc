import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/core/constants/colors.dart';
import 'package:todo_bloc/data/models/todo_model.dart';
import 'package:todo_bloc/presentation/bloc/home/home_bloc.dart';
import 'package:todo_bloc/presentation/bloc/task/task_bloc.dart';
import 'package:todo_bloc/presentation/widgets/custom_tf_widget.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  HomeBloc homeBloc = HomeBloc();
  bool selectedValue = false;
  TaskBloc taskBloc = TaskBloc();
  @override
  Widget build(BuildContext context) {
    TextEditingController taskNameController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    return BlocConsumer<TaskBloc, TaskState>(
      bloc: taskBloc,
      listener: (context, state) {
        if (state is CancelButtonState) {
          Navigator.of(context).pop();
        }
        if (state is SubmitButtonState) {
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: SizedBox(),
            title: Text('Add Task', style: TextStyle(color: Colors.amber)),
            backgroundColor: appBarColor,
            centerTitle: true,
          ),
          backgroundColor: bgColor,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      child: Column(
                        children: [
                          SizedBox(height: 20),
                          CustomTfWidget(
                            hintText: 'Task',
                            controller: taskNameController,
                          ),
                          SizedBox(height: 20),
                          CustomTfWidget(
                            hintText: 'Description',
                            controller: descriptionController,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          btn(
                            text: 'Cancel',
                            onpressed: () {
                              taskBloc.add(CancelButtonEvent());
                            },
                            color: Colors.yellow,
                          ),
                          btn(
                            text: 'Sumbit',
                            onpressed: () {
                              print(selectedValue);
                              TodoModel todos = TodoModel(
                                title: taskNameController.text,
                                description: descriptionController.text,
                                isCompleted: false,
                              );
                              taskBloc.add(SumbitButtonEvent(todos: todos));
                              homeBloc.add(HomeIntialFetchEvent());
                            },
                            color: Colors.amber,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget btn({
    required String text,
    required VoidCallback onpressed,
    required Color color,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: color),
      onPressed: onpressed,
      child: Text(text, style: TextStyle(color: Colors.black)),
    );
  }
}
