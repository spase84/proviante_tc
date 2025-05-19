import 'package:flutter/material.dart';
import 'package:notes/app/domain/entities/note.dart';

class ListItem extends StatelessWidget {
  const ListItem({required this.note, required this.onTap, super.key});

  final Note note;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: onTap,
        child: Card(
          child: Column(
            children: [
              Text(note.title, style: Theme.of(context).textTheme.titleLarge),
              Text(
                note.content,
                style: Theme.of(context).textTheme.bodyMedium,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      );
}
