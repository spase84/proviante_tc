import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:notes/app/di/injector.dart';
import 'package:notes/app/domain/entities/note.dart';
import 'package:notes/app/features/list/domain/bloc/index.dart';
import 'package:notes/app/domain/repository/note_repository.dart';
import 'package:notes/app/settings/constants.dart';

class ListScreenCubit extends Cubit<ListScreenState> {
  ListScreenCubit() : super(const ListScreenStateInitial());

  final NoteRepository _repository = Injector.resolve<NoteRepository>();

  final PagingController<int, Note> pagingController = PagingController(
    firstPageKey: 1,
  );

  void init() {
    pagingController.addPageRequestListener(_fetchPage);
    emit(ListScreenStateSuccess(pagingController));
  }

  Future<void> _fetchPage(int page) async {
    final items = await _repository.getNotes(
      page: page,
      pageSize: AppConstants.pageSize,
    );

    if (items.length < AppConstants.pageSize) {
      pagingController.appendLastPage(items);
    } else {
      pagingController.appendPage(items, page + 1);
    }
  }

  void refresh() {
    pagingController.refresh();
  }

  void deleteNote(int noteId) async {
    await _repository.deleteNote(noteId);
    pagingController.refresh();
  }
}
