import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakinah/features/notes/presentation/pages/note_page.dart';
import 'package:sakinah/core/utils/app_color.dart';
import 'package:sakinah/core/database/database_helper.dart';
import 'package:sakinah/features/notes/data/data_sources/notes_local_data_source.dart';
import 'package:sakinah/features/notes/data/repository/notes_repository_impl.dart';
import 'package:sakinah/features/notes/domain/use_cases/notes_usecases/get_all_notes_usecases.dart';
import 'package:sakinah/features/notes/domain/use_cases/notes_usecases/add_note_usecase.dart';
import 'package:sakinah/features/notes/domain/use_cases/notes_usecases/update_note_usecase.dart';
import 'package:sakinah/features/notes/domain/use_cases/notes_usecases/delete_note_usecase.dart';
import 'package:sakinah/features/notes/presentation/cubits/note_cubit/notes_cubit.dart';
import 'package:sakinah/features/notes/presentation/cubits/list_tasks_cubit/list_tasks_cubit.dart';
import 'package:sakinah/features/notes/domain/use_cases/list_tasks_usecases/add_listtask_usecase.dart';
import 'package:sakinah/features/notes/domain/use_cases/list_tasks_usecases/delete_listtask_usecase.dart';
import 'package:sakinah/features/notes/domain/use_cases/list_tasks_usecases/get_all_listtasks_usecases.dart';
import 'package:sakinah/features/notes/domain/use_cases/list_tasks_usecases/update_listtask_usecase.dart';
import 'package:sakinah/features/notes/presentation/cubits/notes_filter_cubit/notes_filter_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NotesFilterCubit()),
        BlocProvider(
          create: (context) {
            final databaseHelper = DatabaseHelper();
            final localDataSource = NotesLocalDataSourceImpl(
              databaseHelper: databaseHelper,
            );
            final repository = NotesRepositoryImpl(localDataSource);
            return NotesCubit(
              getAllNotesUsecase: GetAllNotes(repository),
              addNoteUsecase: AddNoteUsecase(repository),
              updateNoteUsecase: UpdateNoteUsecase(repository),
              deleteNoteUsecase: DeleteNoteUsecase(repository),
            )..getAllNotes();
          },
        ),
        BlocProvider(
          create: (context) {
            final databaseHelper = DatabaseHelper();
            final localDataSource = NotesLocalDataSourceImpl(
              databaseHelper: databaseHelper,
            );
            final repository = NotesRepositoryImpl(localDataSource);
            return ListTasksCubit(
              getAllListtasksUsecases: GetAllListtasksUsecases(repository),
              addListtaskUsecase: AddListtaskUsecase(repository),
              updateListtaskUsecase: UpdateListtaskUsecase(repository),
              deleteListtaskUsecase: DeleteListtaskUsecase(repository),
            )..getAllListtasks();
          },
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            title: 'Sakinah',
            theme: ThemeData(extensions: const [AppColors.light]),
            darkTheme: ThemeData(extensions: const [AppColors.dark]),
            themeMode: ThemeMode.system,
            home: const NotePage(),
          );
        },
      ),
    );
  }
}
