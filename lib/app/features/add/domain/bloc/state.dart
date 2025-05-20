import 'package:notes/app/domain/entities/note.dart';

sealed class AddNoteScreenState {
  const AddNoteScreenState();
}

final class AddNoteScreenStateInitial extends AddNoteScreenState {
  const AddNoteScreenStateInitial(this.note);

  final Note? note;
}

final class AddNoteScreenStateError extends AddNoteScreenState {
  const AddNoteScreenStateError(this.error);

  final String error;
}

final class AddNoteScreenStateSuccess extends AddNoteScreenState {
  const AddNoteScreenStateSuccess();
}
