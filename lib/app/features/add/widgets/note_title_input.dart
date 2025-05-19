import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:notes/app/features/widgets/decorated_input_container.dart';
import 'package:notes/app/settings/colors.dart';
import 'package:notes/generated/locale_keys.g.dart';

class NoteTitleInput extends StatelessWidget {
  const NoteTitleInput({
    required this.onChanged,
    super.key,
  });

  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          const Text(LocaleKeys.noteNameTitle).tr(),
          const SizedBox(height: 16),
          Flexible(
            child: DecoratedInputContainer(
              child: TextFormField(
                onChanged: onChanged,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: AppColors.textGray),
                  errorStyle: TextStyle(
                    color: Colors.red,
                  ),
                  contentPadding: EdgeInsets.fromLTRB(0, 14, 0, 4),
                ),
                textAlignVertical: TextAlignVertical.center,
                maxLines: 1,
                keyboardType: TextInputType.phone,
                keyboardAppearance: Brightness.dark,
                autofocus: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
