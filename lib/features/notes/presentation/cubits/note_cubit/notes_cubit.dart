import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sakinah/core/strings/succes_message.dart';
import 'package:sakinah/core/utils/map_failure_to_message.dart';
import 'package:sakinah/features/notes/domain/entities/note.dart';
import 'package:sakinah/features/notes/domain/use_cases/notes_usecases/add_note_usecase.dart';
import 'package:sakinah/features/notes/domain/use_cases/notes_usecases/delete_note_usecase.dart';
import 'package:sakinah/features/notes/domain/use_cases/notes_usecases/get_all_notes_usecases.dart';
import 'package:sakinah/features/notes/domain/use_cases/notes_usecases/update_note_usecase.dart';

part 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  final GetAllNotes getAllNotesUsecase;
  final AddNoteUsecase addNoteUsecase;
  final UpdateNoteUsecase updateNoteUsecase;
  final DeleteNoteUsecase deleteNoteUsecase;

  NotesCubit({
    required this.getAllNotesUsecase,
    required this.addNoteUsecase,
    required this.updateNoteUsecase,
    required this.deleteNoteUsecase,
  }) : super(NotesInitial());

  // Get All Notes
  Future<void> getAllNotes() async {
    emit(NotesLoading());
    final result = await getAllNotesUsecase.call();
    result.fold(
      (failure) => emit(NotesError(message: mapFailureToMessage(failure))),
      (notes) {
        if (notes.isEmpty) {
          emit(NotesEmpty());
        } else {
          emit(NotesLoaded(notes: notes));
        }
      },
    );
  }

  // Add Note
  Future<void> addNote(Note note) async {
    emit(NotesLoading());
    final result = await addNoteUsecase.call(note);
    result.fold(
      (failure) => emit(NotesError(message: mapFailureToMessage(failure))),
      (_) async {
        emit(const SuccessMessage(message: noteAddedSuccessfully));
        await getAllNotes();
      },
    );
  }

  // Update Note
  Future<void> updateNote(Note note) async {
    emit(NotesLoading());
    final result = await updateNoteUsecase.call(note);
    result.fold(
      (failure) => emit(NotesError(message: mapFailureToMessage(failure))),
      (_) async {
        emit(const SuccessMessage(message: noteUpdatedSuccessfully));
        await getAllNotes();
      },
    );
  }

  // Delete Note
  Future<void> deleteNote(int id) async {
    emit(NotesLoading());
    final result = await deleteNoteUsecase.call(id);
    result.fold(
      (failure) => emit(NotesError(message: mapFailureToMessage(failure))),
      (_) async {
        emit(const SuccessMessage(message: noteDeletedSuccessfully));
        await getAllNotes();
      },
    );
  }

  // Save (Add or Update) Note
  Future<void> saveNote({
    int? id,
    required String title,
    required String content,
    DateTime? createdAt,
  }) async {
    final noteTitle = title.trim().isEmpty ? "Untitled" : title.trim();

    if (id != null) {
      final updatedNote = Note(
        id: id,
        title: noteTitle,
        content: content,
        createdAt: createdAt ?? DateTime.now(),
      );
      await updateNote(updatedNote);
    } else {
      final newNote = Note(
        title: noteTitle,
        content: content,
        createdAt: DateTime.now(),
      );
      await addNote(newNote);
    }
  }
}
