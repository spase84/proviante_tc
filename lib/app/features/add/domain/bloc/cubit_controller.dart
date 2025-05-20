import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/app/di/injector.dart';
import 'package:notes/app/domain/entities/note.dart';
import 'package:notes/app/domain/repository/note_repository.dart';
import 'package:notes/app/features/add/domain/bloc/index.dart';
import 'package:notes/generated/locale_keys.g.dart';

class AddScreenCubit extends Cubit<AddNoteScreenState> {
  AddScreenCubit() : super(const AddNoteScreenStateInitial(null));

  final NoteRepository _repository = Injector.resolve<NoteRepository>();

  Note? note;

  Future<void> init(int? noteId) async {
    if (noteId != null) {
      note = await _repository.getNote(noteId);
    }

    emit(AddNoteScreenStateInitial(note));
  }

  void onTitleChanged(String value) {
    if (note == null) {
      final now = DateTime.now();
      note = Note(
        id: null,
        title: value,
        content: '',
        createdAt: now,
        updatedAt: now,
      );
    } else {
      note = note!.copyWith(title: value);
    }
  }

  void onContentChanged(String value) {
    if (note == null) {
      final now = DateTime.now();
      note = Note(
        id: null,
        title: '',
        content: value,
        createdAt: now,
        updatedAt: now,
      );
    } else {
      note = note!.copyWith(content: value);
    }
  }

  void onSubmit() {
    if (note != null && note!.isValid()) {
      // if note have id, then we update existing note and should set updatedAt
      if (note!.id != null) {
        note = note!.copyWith(updatedAt: DateTime.now());
      }

      _repository.saveNote(note!);
      emit(const AddNoteScreenStateSuccess());
    } else {
      emit(AddNoteScreenStateError(LocaleKeys.titleCantBeEmpty.tr()));
    }
  }
}
