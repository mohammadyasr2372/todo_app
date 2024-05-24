import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/todo/domin/entity/task_entity.dart';
import 'package:todo_app/features/todo/presentation/bloc/user/bloc/user_bloc.dart';
import 'package:todo_app/features/todo/presentation/bloc/user/bloc/user_event.dart';
import '../../../../core/constants/constants.dart';
import '../../../../injection_container.dart';
import '../../data/models/task_model.dart';
import '../bloc/task/bloc/task_bloc.dart';
import '../bloc/task/bloc/task_event.dart';
import '../bloc/task/bloc/task_state.dart';
import '../widget/shimmer_loading.dart';
import 'task_page.dart';

class LimitAndskipPage extends StatefulWidget {
  const LimitAndskipPage({super.key});

  @override
  State<LimitAndskipPage> createState() => _LimitAndskipPageState();
}

class _LimitAndskipPageState extends State<LimitAndskipPage> {
  final controller = ScrollController();
  List<TaskEntity> tasksLocal = [];
  List<TaskEntity> tasksLimit = [];
  bool hasMore = true;
  bool isLoading = false;
  int skip = 0;
  int limit = 10;
  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        fetch();
      }
    });
  }

  Future fetch() async {
    if (isLoading) return;
    isLoading = true;
    context.read<TaskBloc>().add(LimitAndSkipTodos(skip, limit));
    if (context.watch<TaskBloc>().state is LimitAndSkipTodosDoneState) {
      tasksLimit = context.watch<TaskBloc>().state.tasks!;
    }

    setState(() {
      skip + 10;
      isLoading = false;

      if (tasksLocal.length < limit) {
        hasMore = false;
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: BlocConsumer<TaskBloc, TaskState>(
        listener: (context, state) {
          if (state is LimitAndSkipTodosDoneState) {
            tasksLocal.addAll(state.tasks!);
          }
          if (state is TasksErrorState) {
            if (state.exception!.response!.statusCode == 403) {
              context.read<UserBloc>().add(RefreshSession());
            }
          }
        },
        builder: (context, state) {
          if (state is LimitAndSkipTodosDoneState) {
            return ListView.builder(
                controller: controller,
                // scrollDirection: Axis.horizontal,
                itemCount: tasksLocal.length + 1,
                itemBuilder: (context, index) {
                  bool value = tasksLocal[index].completed!;
                  if (index < tasksLocal.length) {
                    return CheckboxListTile(
                      value: value,
                      title: Text('Task ${index + 1}'),
                      subtitle: Text(tasksLocal[index].todo!),
                      onChanged: (bool? value) {
                        context.read<TaskBloc>().add(PutTask(
                            taskEntity: TaskModel(completed: value!),
                            id: tasksLocal[index].id!));
                        value = !value;
                      },
                    );
                  } else {
                    return Center(
                        child: hasMore
                            ? const CircularProgressIndicator()
                            : const Text('No more data to load'));
                  }
                });
          } else if (state is TasksErrorState) {
            return Center(
              child: InkWell(
                  onTap: () {
                    context
                        .read<TaskBloc>()
                        .add(LimitAndSkipTodos(skip, limit));
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return AlertDialog(
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
