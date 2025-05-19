import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart'
    show PagingController;
import 'package:notes/app/domain/entities/note.dart' show Note;
import 'package:notes/app/errors/failure.dart' show Failure;

sealed class ListScreenState {
  const ListScreenState();
}

final class ListScreenStateInitial extends ListScreenState {
  const ListScreenStateInitial();
}

final class ListScreenStateError extends ListScreenState {
  const ListScreenStateError(this.failure);

  final Failure failure;
}

final class ListScreenStateSuccess extends ListScreenState {
  const ListScreenStateSuccess(this.pagingController);

  final PagingController<int, Note> pagingController;
}
