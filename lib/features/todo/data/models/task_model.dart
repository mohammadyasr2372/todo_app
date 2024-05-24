import 'package:floor/floor.dart';

import '../../domin/entity/task_entity.dart';

@Entity(tableName: 'Task', primaryKeys: ['id'])
class TaskModel extends TaskEntity {
  const TaskModel({
    int? id,
    int? userId,
    String? todo,
    bool? completed,
  }) : super(
          id,
          userId,
          todo,
          completed,
        );

  factory TaskModel.fromJson(Map<String, dynamic> map) {
    return TaskModel(
        id: map['id'] != null ? map['id'] as int : null,
        userId: map['userId'] != null ? map['userId'] as int : null,
        todo: map['todo'] != null ? map['todo'] as String : null,
        completed: map['completed'] != null ? map['completed'] as bool : null);
  }
  factory TaskModel.fromEntity(TaskEntity entity) {
    return TaskModel(
      id: entity.id,
      userId: entity.userId,
      todo: entity.todo,
      completed: entity.completed,
    );
  }
}
