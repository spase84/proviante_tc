import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:notes/app/features/add/domain/bloc/index.dart';
import 'package:notes/app/features/add/widgets/note_title_input.dart';
import 'package:notes/app/features/widgets/unfocuser.dart';
import 'package:notes/app/settings/colors.dart';
import 'package:notes/generated/locale_keys.g.dart';

class AddScreen extends StatelessWidget {
  const AddScreen({this.noteId, super.key});

  final int? noteId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddScreenCubit>(
      create: (context) => AddScreenCubit()..init(noteId),
      child: Scaffold(
        appBar: AppBar(
          title: Text(noteId != null
                  ? LocaleKeys.editNoteTitle
                  : LocaleKeys.addNoteTitle)
              .tr(),
          actions: [
            Builder(builder: (context) {
              return Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: IconButton(
                  icon: const Icon(Icons.done, color: AppColors.secondary),
                  onPressed: context.read<AddScreenCubit>().onSubmit,
                ),
              );
            }),
          ],
        ),
        body: const _AddScreenBody(),
      ),
    );
  }
}

class _AddScreenBody extends StatelessWidget {
  const _AddScreenBody();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddScreenCubit, AddNoteScreenState>(
      listener: (context, state) {
        if (state is AddNoteScreenStateSuccess) {
          context.pop();
        }
        if (state is AddNoteScreenStateError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
      },
      buildWhen: (_, state) => state is AddNoteScreenStateInitial,
      builder: (context, state) => switch (state) {
        AddNoteScreenStateInitial(note: final note) => Unfocuser(
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16)
                    .copyWith(top: 32),
                child: Column(
                  children: [
                    NoteInput(
                      title: LocaleKeys.noteNameTitle.tr(),
                      initialValue: note?.title,
                      onChanged: context.read<AddScreenCubit>().onTitleChanged,
                    ),
                    const SizedBox(height: 24),
                    NoteInput(
                      title: LocaleKeys.noteContextTitle.tr(),
                      initialValue: note?.content,
                      onChanged:
                          context.read<AddScreenCubit>().onContentChanged,
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: FilledButton(
                        onPressed: context.read<AddScreenCubit>().onSubmit,
                        child: Text(
                          note != null ? LocaleKeys.update : LocaleKeys.save,
                        ).tr(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        AddNoteScreenStateError(error: final _) => const SizedBox.shrink(),
        AddNoteScreenStateSuccess() => const SizedBox.shrink(),
      },
    );
  }
}
