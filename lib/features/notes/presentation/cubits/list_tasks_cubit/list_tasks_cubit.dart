import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sakinah/core/strings/succes_message.dart';
import 'package:sakinah/core/utils/map_failure_to_message.dart';
import 'package:sakinah/features/notes/domain/entities/list_tasks.dart';
import 'package:sakinah/features/notes/domain/use_cases/list_tasks_usecases/add_listtask_usecase.dart';
import 'package:sakinah/features/notes/domain/use_cases/list_tasks_usecases/delete_listtask_usecase.dart';
import 'package:sakinah/features/notes/domain/use_cases/list_tasks_usecases/get_all_listtasks_usecases.dart';
import 'package:sakinah/features/notes/domain/use_cases/list_tasks_usecases/update_listtask_usecase.dart';

part 'list_tasks_state.dart';

class ListTasksCubit extends Cubit<ListTasksState> {
  final GetAllListtasksUsecases getAllListtasksUsecases;
  final AddListtaskUsecase addListtaskUsecase;
  final UpdateListtaskUsecase updateListtaskUsecase;
  final DeleteListtaskUsecase deleteListtaskUsecase;

  ListTasksCubit({
    required this.getAllListtasksUsecases,
    required this.addListtaskUsecase,
    required this.updateListtaskUsecase,
    required this.deleteListtaskUsecase,
  }) : super(ListTasksInitial());

  // Get All Tasks
  Future<void> getAllListtasks() async {
    emit(ListTasksLoading());
    final result = await getAllListtasksUsecases.call();
    result.fold(
      (failure) => emit(ListTasksError(message: mapFailureToMessage(failure))),
      (tasks) {
        if (tasks.isEmpty) {
          emit(ListTasksEmpty());
        } else {
          emit(ListTasksLoaded(tasks: tasks));
        }
      },
    );
  }

  // Alias
  Future<void> getAllNotes() async => getAllListtasks();

  // Initialize a new or existing draft task list
  void initTaskList([List<ListTasks>? existingTasks]) {
    if (existingTasks != null && existingTasks.isNotEmpty) {
      emit(ListTasksLoaded(tasks: List.from(existingTasks)));
    } else {
      emit(
        ListTasksLoaded(
          tasks: [
            ListTasks(
              title: '',
              task: '',
              date: DateTime.now().toIso8601String(),
              isDone: false,
              order: 0,
            ),
          ],
        ),
      );
    }
  }

  // Add new item in the list
  void addNewTaskItem() {
    if (state is ListTasksLoaded) {
      final currentTasks = (state as ListTasksLoaded).tasks;
      final updatedList = List<ListTasks>.from(currentTasks);
      updatedList.add(
        ListTasks(
          title: '',
          task: '',
          date: DateTime.now().toIso8601String(),
          isDone: false,
          order: updatedList.length,
        ),
      );
      emit(ListTasksLoaded(tasks: updatedList));
    } else {
      initTaskList();
    }
  }

  // Update item text
  void updateTaskItemText(int index, String text) {
    if (state is ListTasksLoaded) {
      final currentTasks = (state as ListTasksLoaded).tasks;
      if (index >= 0 && index < currentTasks.length) {
        final task = currentTasks[index];
        final updatedList = List<ListTasks>.from(currentTasks);
        updatedList[index] = ListTasks(
          id: task.id,
          title: task.title,
          task: text,
          date: task.date,
          isDone: task.isDone,
          order: task.order,
        );
        emit(ListTasksLoaded(tasks: updatedList));
      }
    }
  }

  // Toggle item done status in memory
  void toggleTaskDone(int index, bool isDone) {
    if (state is ListTasksLoaded) {
      final currentTasks = (state as ListTasksLoaded).tasks;
      if (index >= 0 && index < currentTasks.length) {
        final task = currentTasks[index];
        final updatedList = List<ListTasks>.from(currentTasks);
        updatedList[index] = ListTasks(
          id: task.id,
          title: task.title,
          task: task.task,
          date: task.date,
          isDone: isDone,
          order: task.order,
        );
        emit(ListTasksLoaded(tasks: updatedList));
      }
    }
  }

  // Toggle item done status in SQLite
  Future<void> toggleSavedTask(ListTasks task) async {
    final updatedTask = ListTasks(
      id: task.id,
      title: task.title,
      task: task.task,
      date: task.date,
      isDone: !task.isDone,
      order: task.order,
    );
    await updateListtaskUsecase.call(updatedTask);
    await getAllListtasks();
  }

  // Remove item in memory
  void removeTaskItem(int index) {
    if (state is ListTasksLoaded) {
      final currentTasks = (state as ListTasksLoaded).tasks;
      final updatedList = List<ListTasks>.from(currentTasks)..removeAt(index);
      emit(ListTasksLoaded(tasks: updatedList));
    }
  }

  // Reorder items
  void reorderTasksLocally(int oldIndex, int newIndex) {
    if (state is ListTasksLoaded) {
      final currentState = state as ListTasksLoaded;
      final List<ListTasks> updatedTasks = List.from(currentState.tasks);

      if (oldIndex < newIndex) {
        newIndex -= 1;
      }

      final item = updatedTasks.removeAt(oldIndex);
      updatedTasks.insert(newIndex, item);

      for (int i = 0; i < updatedTasks.length; i++) {
        final task = updatedTasks[i];
        updatedTasks[i] = ListTasks(
          id: task.id,
          title: task.title,
          task: task.task,
          date: task.date,
          isDone: task.isDone,
          order: i,
        );
      }

      emit(ListTasksLoaded(tasks: updatedTasks));
    }
  }

  // Save all tasks under the shared title
  Future<void> saveTasksGroup(String title) async {
    if (state is ListTasksLoaded) {
      final currentTasks = (state as ListTasksLoaded).tasks;
      final validTasks = currentTasks.where((t) => t.task.trim().isNotEmpty).toList();

      if (validTasks.isEmpty) return;

      emit(ListTasksLoading());
      for (int i = 0; i < validTasks.length; i++) {
        final t = validTasks[i];
        final taskToSave = ListTasks(
          id: t.id,
          title: title,
          task: t.task.trim(),
          date: t.date.isEmpty ? DateTime.now().toIso8601String() : t.date,
          isDone: t.isDone,
          order: i,
        );

        if (t.id != null) {
          await updateListtaskUsecase.call(taskToSave);
        } else {
          await addListtaskUsecase.call(taskToSave);
        }
      }

      emit(const SuccessMessage(message: listTaskAddedSuccessfully));
      await getAllListtasks();
    }
  }

  // Delete all tasks under a specific group title
  Future<void> deleteTasksGroup(String title) async {
    final result = await getAllListtasksUsecases.call();
    await result.fold(
      (failure) async => null,
      (allTasks) async {
        final groupTasks = allTasks.where((t) => t.title == title).toList();
        for (final t in groupTasks) {
          if (t.id != null) {
            await deleteListtaskUsecase.call(t.id!);
          }
        }
        await getAllListtasks();
      },
    );
  }

  // Add Single Task
  Future<void> addTask(ListTasks task) async {
    emit(ListTasksLoading());
    final result = await addListtaskUsecase.call(task);
    result.fold(
      (failure) => emit(ListTasksError(message: mapFailureToMessage(failure))),
      (_) async {
        emit(const SuccessMessage(message: listTaskAddedSuccessfully));
        await getAllListtasks();
      },
    );
  }

  Future<void> addNote(ListTasks task) async => addTask(task);

  // Update Single Task
  Future<void> updateTask(ListTasks task) async {
    emit(ListTasksLoading());
    final result = await updateListtaskUsecase.call(task);
    result.fold(
      (failure) => emit(ListTasksError(message: mapFailureToMessage(failure))),
      (_) async {
        emit(const SuccessMessage(message: listTaskUpdatedSuccessfully));
        await getAllListtasks();
      },
    );
  }

  Future<void> updateNote(ListTasks task) async => updateTask(task);

  // Delete Task
  Future<void> deleteTask(String id) async {
    emit(ListTasksLoading());
    final result = await deleteListtaskUsecase.call(id);
    result.fold(
      (failure) => emit(ListTasksError(message: mapFailureToMessage(failure))),
      (_) async {
        emit(const SuccessMessage(message: listTaskDeletedSuccessfully));
        await getAllListtasks();
      },
    );
  }

  Future<void> deleteNote(String id) async => deleteTask(id);
}
