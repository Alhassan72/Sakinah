import 'package:sakinah/core/strings/db_constants.dart';
import 'package:sakinah/features/notes/domain/entities/note.dart';

class NoteModel extends Note {
  const NoteModel({
    super.id,
    required super.title,
    required super.content,
    required super.createdAt,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) => NoteModel(
    id: json[DbConstants.noteId],
    title: json[DbConstants.noteTitle] ?? '',
    content: json[DbConstants.noteDescription] ?? '',
    createdAt: json[DbConstants.noteDate] is DateTime
        ? json[DbConstants.noteDate]
        : DateTime.tryParse(json[DbConstants.noteDate]?.toString() ?? '') ??
            DateTime.now(),
  );

  Map<String, dynamic> toJson() => {
    DbConstants.noteId: id,
    DbConstants.noteTitle: title,
    DbConstants.noteDescription: content,
    DbConstants.noteDate: createdAt.toIso8601String(),
  };
}
