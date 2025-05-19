import 'package:notes/app/domain/entities/note.dart';

sealed class AddNoteScreenState {
  const AddNoteScreenState();
}

class AddNoteScreenStateInitial extends AddNoteScreenState {
  const AddNoteScreenStateInitial(this.note);

  final Note? note;
}
