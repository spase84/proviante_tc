import 'package:flutter/material.dart';
import 'package:notes/app/settings/colors.dart';

class DecoratedInputContainer extends StatelessWidget {
  const DecoratedInputContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      padding: const EdgeInsets.fromLTRB(12, 10, 14, 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.inputsActiveBackground,
      ),
      constraints: const BoxConstraints(
        maxWidth: double.infinity,
      ),
      child: child,
    );
  }
}
