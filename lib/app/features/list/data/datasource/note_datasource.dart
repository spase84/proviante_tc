import 'package:notes/app/domain/entities/note.dart';

abstract class NoteDataSource {
  Future<List<Note>> getNotes({required int page, required int pageSize});
  Future<void> saveNote(Note note);
}
