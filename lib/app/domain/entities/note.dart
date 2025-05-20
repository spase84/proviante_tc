import 'package:isar/isar.dart';

part 'note.g.dart';

@Collection()
class Note {
  Id? id = Isar.autoIncrement;
  late String title;
  late String content;
  late DateTime createdAt;
  late DateTime updatedAt;

  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });

  bool get isShouldShowUpdatedAt => updatedAt != createdAt;

  Note copyWith({
    int? id,
    String? title,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() {
    return 'Note{id: $id, title: $title, content: $content, createdAt: $createdAt, updatedAt: $updatedAt}';
  }

  bool isValid() {
    return title.isNotEmpty;
  }
}
