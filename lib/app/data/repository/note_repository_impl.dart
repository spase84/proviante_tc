import 'package:notes/app/domain/entities/note.dart';
import 'package:notes/app/data/datasource/note_datasource.dart';
import 'package:notes/app/domain/repository/note_repository.dart';

final class NoteRepositoryImpl implements NoteRepository {
  NoteRepositoryImpl({required this.dataSource});

  final NoteDataSource dataSource;

  @override
  Future<List<Note>> getNotes(
      {required int page, required int pageSize}) async {
    return dataSource.getNotes(page: page, pageSize: pageSize);
  }

  @override
  Future<Note?> getNote(int id) async {
    return dataSource.getNote(id);
  }

  @override
  Future<void> saveNote(Note note) async {
    return dataSource.saveNote(note);
  }

  @override
  Future<bool> deleteNote(int id) async {
    return dataSource.deleteNote(id);
  }
}
