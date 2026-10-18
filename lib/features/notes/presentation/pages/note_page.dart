import 'package:flutter/material.dart';
import 'package:sakinah/core/utils/app_color.dart';
import 'package:sakinah/features/notes/presentation/widgets/note_page_widgets/note_float_button.dart';
import 'package:sakinah/features/notes/presentation/widgets/note_page_widgets/notes_body.dart';

class NotePage extends StatelessWidget {
  const NotePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.background,
      body: const SafeArea(child: NotesBody()),
      floatingActionButton: const NoteFloatButton(),
    );
  }
}
