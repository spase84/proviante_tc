import 'package:notes/app/domain/entities/note.dart';
import 'package:notes/app/features/list/data/datasource/note_datasource.dart';
import 'package:notes/app/features/list/domain/repository/note_repository.dart';

final class NoteRepositoryImpl implements NoteRepository {
  NoteRepositoryImpl({required this.dataSource});

  final NoteDataSource dataSource;

  @override
  Future<List<Note>> getNotes(
      {required int page, required int pageSize}) async {
    return dataSource.getNotes(page: page, pageSize: pageSize);
  }
}
