import 'package:sakinah/core/strings/db_constants.dart';
import 'package:sakinah/features/notes/domain/entities/list_tasks.dart';

class ListTasksModel extends ListTasks {
  const ListTasksModel({
    super.id,
    required super.title,
    required super.date,
    required super.task,
    required super.order,
    required super.isDone,
  });

  factory ListTasksModel.fromJson(Map<String, dynamic> json) {
    return ListTasksModel(
      id: json[DbConstants.listTasksId]?.toString(),
      title: json[DbConstants.listTasksTitle],
      task: json[DbConstants.listTasksDescription],
      isDone: json[DbConstants.listTasksIsDone] == 1,
      date: json[DbConstants.listTasksDate],
      order: json[DbConstants.taskOrder],
    );
  }

  Map<String, dynamic> toJson() => {
    DbConstants.listTasksTitle: title,
    DbConstants.listTasksDescription: task,
    DbConstants.listTasksDate: date,
    DbConstants.listTasksIsDone: isDone ? 1 : 0,
    DbConstants.taskOrder: order,
  };
}
