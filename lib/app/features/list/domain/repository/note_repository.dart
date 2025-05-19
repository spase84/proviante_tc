import 'package:notes/app/domain/entities/note.dart';

abstract class NoteRepository {
  Future<List<Note>> getNotes({required int page, required int pageSize});
}
