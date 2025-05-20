import 'package:isar/isar.dart';
import 'package:notes/app/domain/entities/note.dart';
import 'package:notes/app/data/datasource/note_datasource.dart';
import 'package:path_provider/path_provider.dart';

class IsarDatasource implements NoteDataSource {
  IsarDatasource() {
    db = _openDb();
  }

  late Future<Isar> db;

  @override
  Future<List<Note>> getNotes(
      {required int page, required int pageSize}) async {
    final isar = await db;
    return isar.notes
        .where()
        .sortByUpdatedAtDesc()
        .offset((page - 1) * pageSize)
        .limit(pageSize)
        .findAllSync();
  }

  @override
  Future<Note?> getNote(int id) async {
    final isar = await db;
    return isar.notes.getSync(id);
  }

  @override
  Future<void> saveNote(Note note) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.notes.putSync(note));
  }

  Future<Isar> _openDb() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      return await Isar.open(
        [NoteSchema],
        directory: dir.path,
        inspector: true,
      );
    }

    return Future.value(Isar.getInstance());
  }

  @override
  Future<bool> deleteNote(int id) async {
    final isar = await db;
    return isar.writeTxn(() => isar.notes.delete(id));
  }
}
