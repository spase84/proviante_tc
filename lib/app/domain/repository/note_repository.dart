import 'package:notes/app/domain/entities/note.dart';

abstract class NoteRepository {
  Future<List<Note>> getNotes({required int page, required int pageSize});
  Future<Note?> getNote(int id);
  Future<void> saveNote(Note note);
  Future<void> deleteNote(int id);
}
