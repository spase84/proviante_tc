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
    return BlocProvider<ListScreenCubit>(
      create: (context) => ListScreenCubit()..init(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(LocaleKeys.listScreenTitle).tr(),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Builder(builder: (context) {
                return IconButton(
                  icon: const Icon(Icons.add, color: AppColors.secondary),
                  onPressed: () async {
                    await context.pushNamed(Routes.add);
                    if (!context.mounted) {
                      return;
                    }
                    context.read<ListScreenCubit>().refresh();
                  },
                );
              }),
            ),
          ],
        ),
        body: const _ListScreenBody(),
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
        if (state is ListScreenStateError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.failure.message)),
          );
        }
      },
      buildWhen: (_, state) => state is! ListScreenStateSuccess,
      builder: (context, state) => switch (state) {
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
                      noItemsFoundIndicatorBuilder: (context) =>
                          SizedBox.expand(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(LocaleKeys.emptyListText,
                                    style:
                                        Theme.of(context).textTheme.titleLarge)
                                .tr(),
                            const SizedBox(height: 16),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 32),
                              child: Text(
                                LocaleKeys.emptyListDescription,
                                style: Theme.of(context).textTheme.labelSmall,
                                textAlign: TextAlign.center,
                              ).tr(),
                            ),
                          ],
                        ),
                      ),
                      itemBuilder: (context, item, i) => ListItem(
                        note: item,
                        onTap: () async {
                          await context.pushNamed(Routes.add, extra: item.id);
                          if (!context.mounted) {
                            return;
                          }
                          context.read<ListScreenCubit>().refresh();
                        },
                        onDelete: () {
                          context.read<ListScreenCubit>().deleteNote(item.id!);
                        },
                      ),
                    ),
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                  ),
                ),
              ],
            ),
          ),
      },
    );
  }
}
