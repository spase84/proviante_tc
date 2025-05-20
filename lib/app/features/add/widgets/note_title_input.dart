import 'package:flutter/material.dart';
import 'package:notes/app/features/widgets/decorated_input_container.dart';
import 'package:notes/app/settings/colors.dart';

class NoteInput extends StatelessWidget {
  NoteInput({
    required this.title,
    required this.onChanged,
    this.initialValue,
    super.key,
  });

  final ValueChanged<String> onChanged;
  final String title;
  final String? initialValue;

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _controller.text = initialValue ?? '';
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
          const SizedBox(height: 16),
          DecoratedInputContainer(
            child: TextFormField(
              controller: _controller,
              onChanged: onChanged,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintStyle: TextStyle(color: AppColors.textGray),
                errorStyle: TextStyle(
                  color: Colors.red,
                ),
                isDense: true,
              ),
              minLines: 1,
              maxLines: 15,
              textAlignVertical: TextAlignVertical.center,
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.sentences,
              keyboardAppearance: Brightness.dark,
              autofocus: true,
            ),
          ),
        ],
      ),
    );
  }
}
