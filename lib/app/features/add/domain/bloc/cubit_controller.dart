import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/app/domain/entities/note.dart';
import 'package:notes/app/features/add/domain/bloc/index.dart';

class AddScreenCubit extends Cubit<AddNoteScreenState> {
  AddScreenCubit() : super(const AddNoteScreenStateInitial(null));

  Note? note;

  void init(Note? note) {
    this.note = note;
    emit(AddNoteScreenStateInitial(note));
  }
}
