import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/core/constants/colors.dart';
import 'package:todo_bloc/data/models/todo_model.dart';
import 'package:todo_bloc/presentation/bloc/edit/edit_bloc.dart';
import 'package:todo_bloc/presentation/widgets/custom_tf_widget.dart';

class EditPage extends StatelessWidget {
  final TodoModel todo;
  const EditPage({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    EditBloc editbloc = EditBloc();
    TextEditingController taskNameController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    return BlocConsumer<EditBloc, EditState>(
      bloc: editbloc,
      listenWhen: (previous, current) => current is! EditActionState,
      buildWhen: (previous, current) => current is EditActionState,
      listener: (context, state) {
        if (state is EditCancelButtonAction) {
          Navigator.of(context).pop();
        }
        if (state is SumbitButtonAction) {
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        taskNameController.text = todo.title;
        descriptionController.text = todo.description;
        bool isCompleted = todo.isCompleted;
        if (state is TaskCompletedState) {
          isCompleted = state.isCompleted;
        }
        return Scaffold(
          appBar: AppBar(
            leading: SizedBox(),
            title: Text('Edit Task', style: TextStyle(color: Colors.amber)),
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
                          Row(
                            children: [
                              Checkbox(
                                value: isCompleted,
                                onChanged: (bool? newValue) {
                                  newValue = !isCompleted;
                                  editbloc.add(
                                    TaskCompleteButtonClicked(
                                      isCompleted: newValue,
                                    ),
                                  );
                                },
                              ),
                              Text(
                                'Completion',
                                style: TextStyle(color: Colors.amber),
                              ),
                            ],
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
                              editbloc.add(EditCancelButtonClicked());
                            },
                            color: Colors.yellow,
                          ),
                          btn(
                            text: 'Update',
                            onpressed: () {
                              final editedTodo = TodoModel(
                                id: todo.id,
                                title: taskNameController.text,
                                description: descriptionController.text,
                                isCompleted: isCompleted,
                              );
                              print(todo.id);
                              print(isCompleted);
                              editbloc.add(EditSubmitButton(todo: editedTodo));
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
