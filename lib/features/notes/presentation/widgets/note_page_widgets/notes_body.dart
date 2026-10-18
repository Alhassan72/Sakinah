import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakinah/features/notes/presentation/widgets/note_page_widgets/filter_button.dart';
import 'package:sakinah/features/notes/presentation/widgets/note_page_widgets/note_page_header.dart';
import 'package:sakinah/features/notes/presentation/widgets/note_page_widgets/note_page_search.dart';
import 'package:sakinah/features/notes/presentation/widgets/note_page_widgets/notes_card_list.dart';

class NotesBody extends StatelessWidget {
  const NotesBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Bar
          const NotePageHeader(),
          SizedBox(height: 12.h),

          // Search Field
          const NotePageSearch(),
          SizedBox(height: 12.h),

          // Filter Chips
          const FilterButton(),
          SizedBox(height: 12.h),

          // Main Content Area
          const Expanded(child: NotesCardList()),
        ],
      ),
    );
  }
}
