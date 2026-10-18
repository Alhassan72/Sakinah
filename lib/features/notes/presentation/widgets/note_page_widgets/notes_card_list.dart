import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakinah/core/utils/app_color.dart';
import 'package:sakinah/features/notes/presentation/cubits/list_tasks_cubit/list_tasks_cubit.dart';
import 'package:sakinah/features/notes/presentation/cubits/note_cubit/notes_cubit.dart';
import 'package:sakinah/features/notes/presentation/cubits/notes_filter_cubit/notes_filter_cubit.dart';
import 'package:sakinah/features/notes/presentation/widgets/note_page_widgets/note_card.dart';
import 'package:sakinah/features/notes/presentation/widgets/note_page_widgets/note_section_title.dart';
import 'package:sakinah/features/notes/presentation/widgets/note_page_widgets/task_card.dart';

class NotesCardList extends StatelessWidget {
  const NotesCardList({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final filterCubit = context.watch<NotesFilterCubit>();
    final filterState = filterCubit.state;
    final notesState = context.watch<NotesCubit>().state;
    final tasksState = context.watch<ListTasksCubit>().state;

    final data = filterCubit.processData(
      notesState: notesState,
      tasksState: tasksState,
    );

    if (data.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.note_alt_outlined,
              size: 50.sp,
              color: colors.textSecondary.withValues(alpha: 0.3),
            ),
            SizedBox(height: 10.h),
            Text(
              filterState.query.isNotEmpty
                  ? "Does not match any notes or tasks"
                  : "No notes or tasks",
              style: TextStyle(
                fontSize: 14.sp,
                color: colors.textSecondary.withValues(alpha: 0.6),
                fontFamily: "Amiri",
              ),
            ),
          ],
        ),
      );
    }

    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        // Notes Section
        if (data.showNotes && data.notes.isNotEmpty) ...[
          if (filterState.filterIndex == 0)
            NoteSectionTitle(title: "Notes", count: data.notes.length),
          ...data.notes.map((note) => NoteCard(note: note)),
          SizedBox(height: 10.h),
        ],

        // Tasks Section
        if (data.showTasks && data.groupedTasks.isNotEmpty) ...[
          if (filterState.filterIndex == 0)
            NoteSectionTitle(title: "Tasks", count: data.groupedTasks.length),
          ...data.groupedTasks.entries.map(
            (entry) => TaskCard(title: entry.key, tasks: entry.value),
          ),
        ],
        SizedBox(height: 60.h),
      ],
    );
  }
}
