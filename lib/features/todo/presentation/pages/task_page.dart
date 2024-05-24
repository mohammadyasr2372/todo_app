import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/constants.dart';
import '../../../../injection_container.dart';
import '../../data/models/task_model.dart';
import '../bloc/task/bloc/task_bloc.dart';
import '../bloc/task/bloc/task_event.dart';
import '../bloc/task/bloc/task_state.dart';
import '../widget/shimmer_loading.dart';
import 'limit_page.dart';

TextEditingController todo = TextEditingController();

class TaskPage extends StatelessWidget {
  const TaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LimitAndskipPage()))
                  },
              child: const Text('limit page'))
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<TaskBloc>().add(GetAllTodosByUserId(userId!));
        },
        child: BlocConsumer<TaskBloc, TaskState>(
          listener: (context, state) {
            if (state is LocalTasksDone) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: Colors.black,
                  content: Text('yourn\'t connect the internet'),
                ),
              );
              if (state is TasksErrorState) {
                if (state.exception!.response!.statusCode == 403) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Scaffold()));
                }
              }
            }
          },
          builder: (context, state) {
            if (state is GetAllTodosByUserIdDoneState) {
              return ListWheelScrollView.useDelegate(
                // scrollDirection: Axis.horizontal,
                itemExtent: 75,
                childDelegate: ListWheelChildBuilderDelegate(
                    childCount: state.tasks!.length,
                    builder: (context, index) {
                      bool value = state.tasks![index].completed!;
                      return CheckboxListTile(
                        value: value,
                        title: Text('Task ${index + 1}'),
                        subtitle: Text(state.tasks![index].todo!),
                        onChanged: (bool? value) {
                          context.read<TaskBloc>().add(PutTask(
                              taskEntity: TaskModel(completed: value!),
                              id: state.tasks![index].id!));
                          value = !value;
                        },
                      );
                    }),
              );
            } else if (state is LocalTasksDone) {
              return ListWheelScrollView.useDelegate(
                // scrollDirection: Axis.horizontal,
                itemExtent: 75,
                childDelegate: ListWheelChildBuilderDelegate(
                    childCount: state.tasks!.length,
                    builder: (context, index) {
                      bool value = state.tasks![index].completed!;
                      return CheckboxListTile(
                        value: value,
                        title: Text('Task ${index + 1}'),
                        subtitle: Text(state.tasks![index].todo!),
                        onChanged: (bool? value) {
                          context.read<TaskBloc>().add(PutTask(
                              taskEntity: TaskModel(completed: value!),
                              id: state.tasks![index].id!));
                          value = !value;
                        },
                      );
                    }),
              );
            } else if (state is TasksErrorState) {
              return Center(
                child: InkWell(
                    onTap: () {
                      context
                          .read<TaskBloc>()
                          .add(GetAllTodosByUserId(userId!));
                    },
                    child: const Icon(Icons.refresh_outlined)),
              );
            } else if (state is TasksLoadingState) {
              return const Center(
                child: ShimmerLoading(),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return AlertDialog(
                //  backgroundColor: Color.fromARGB(121, 102, 123, 117),
                elevation: 10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                title: const Text(
                  'Add Task ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                content: SizedBox(
                  height: 170,
                  child: Column(children: [
                    TextField(
                        controller: todo,
                        decoration:
                            const InputDecoration(hintText: 'todo name')),
                  ]),
                ),
                actions: [
                  BlocProvider(
                    create: (context) => sl<TaskBloc>(),
                    child: BlocBuilder<TaskBloc, TaskState>(
                      builder: (context, state) {
                        return TextButton(
                          onPressed: () {
                            context.read<TaskBloc>().add(PostTask(
                                taskEntity: TaskModel(
                                    userId: userId,
                                    todo: todo.text,
                                    completed: false)));

                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'Yes',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                        );
                      },
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'No',
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.red,
        ),
      ),
    );
  }
}
