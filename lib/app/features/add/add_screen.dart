import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/app/domain/entities/note.dart';
import 'package:notes/app/features/add/domain/bloc/cubit_controller.dart';
import 'package:notes/app/features/add/widgets/note_title_input.dart';
import 'package:notes/app/features/add/widgets/unfocuser.dart';
import 'package:notes/app/settings/colors.dart';
import 'package:notes/generated/locale_keys.g.dart';

class AddScreen extends StatelessWidget {
  const AddScreen({this.note, super.key});

  final Note? note;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(note != null
                ? LocaleKeys.editNoteTitle
                : LocaleKeys.addNoteTitle)
            .tr(),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              icon: const Icon(Icons.done, color: AppColors.secondary),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: BlocProvider<AddScreenCubit>(
        create: (context) => AddScreenCubit()..init(note),
        child: const _AddScreenBody(),
      ),
    );
  }
}

class _AddScreenBody extends StatelessWidget {
  const _AddScreenBody();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(top: 32),
          child: Column(
            children: [
              NoteTitleInput(
                onChanged: (String value) {},
              ),
            ],
          ),
        ));
  }
}
