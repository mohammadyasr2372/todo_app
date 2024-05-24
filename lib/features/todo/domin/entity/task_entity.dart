// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:convert';

// ignore: depend_on_referenced_packages
import 'package:equatable/equatable.dart';

class TaskEntity extends Equatable {
  final int? id;
  final int? userId;
  final String? todo;
  final bool? completed;

  const TaskEntity(this.id, this.userId, this.todo, this.completed);

  @override
  List<Object?> get props => [id, userId, todo, completed];

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'userId':userId,
      'todo': todo,
      'completed': completed,
    };
  }

  factory TaskEntity.fromJson(Map<String, dynamic> map) {
    return TaskEntity(
        map['id'] != null ? map['id'] as int : null,
        map['userId'] != null ? map['userId'] as int : null,
        map['todo'] != null ? map['todo'] as String : null,
        map['completed'] != null ? map['completed'] as bool : null);
  }
}
