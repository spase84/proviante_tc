import 'package:go_router/go_router.dart';
import 'package:notes/app/features/add/add_screen.dart';
import 'package:notes/app/features/list/list_screen.dart';
import 'package:notes/app/settings/routes.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      name: Routes.list,
      path: '/',
      builder: (context, state) => const ListScreen(),
    ),
    GoRoute(
      name: Routes.add,
      path: '/add',
      builder: (context, state) => AddScreen(
        noteId: state.extra as int?,
      ),
    ),
  ],
);
