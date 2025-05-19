import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:notes/app/domain/entities/note.dart' show Note;
import 'package:notes/app/features/list/domain/bloc/index.dart';
import 'package:notes/app/features/list/widgets/list_item.dart';
import 'package:notes/app/settings/colors.dart';
import 'package:notes/app/settings/routes.dart';
import 'package:notes/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(LocaleKeys.listScreenTitle).tr(),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              icon: const Icon(Icons.add, color: AppColors.secondary),
              onPressed: () => context.pushNamed(Routes.add),
            ),
          ),
        ],
      ),
      body: BlocProvider<ListScreenCubit>(
        create: (context) => ListScreenCubit()..init(),
        child: const _ListScreenBody(),
      ),
    );
  }
}

class _ListScreenBody extends StatelessWidget {
  const _ListScreenBody();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ListScreenCubit, ListScreenState>(
      listener: (context, state) {
        // TODO: if error we should show snackbar
      },
      buildWhen: (_, state) => state is! ListScreenStateSuccess,
      builder: (context, state) {
        return switch (state) {
          ListScreenStateInitial() =>
            const Center(child: CircularProgressIndicator()),
          ListScreenStateError(failure: final failure) =>
            Center(child: Text(failure.message)),
          ListScreenStateSuccess(pagingController: final pagingController) =>
            RefreshIndicator(
              onRefresh: () async => pagingController.refresh(),
              child: CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    sliver: PagedSliverList.separated(
                      pagingController: pagingController,
                      builderDelegate: PagedChildBuilderDelegate<Note>(
                        firstPageProgressIndicatorBuilder: (_) => const Center(
                          child: CircularProgressIndicator(
                            strokeCap: StrokeCap.round,
                          ),
                        ),
                        noItemsFoundIndicatorBuilder: (context) => Column(
                          children: [
                            Container(
                              color: Colors.amber,
                              height: 100,
                            ),
                          ],
                        ),
                        itemBuilder: (context, item, i) => ListItem(
                          note: item,
                          onTap: () =>
                              context.pushNamed(Routes.add, extra: item),
                        ),
                      ),
                      separatorBuilder: (_, __) => const SizedBox(height: 8),
                    ),
                  ),
                ],
              ),
            ),
        };
      },
    );
  }
}
