import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:food/logic/networking/dishes.dart';

class TagButton extends StatelessWidget {
  const TagButton({
    super.key,
    required this.name,
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    final bool isActive = context.read<Dishes>().checkIfActive(name);

    return isActive
        ? CupertinoButton.filled(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            onPressed: () {},
            child: Text(
              name,
              style: const TextStyle(fontSize: 14.0),
            ),
          )
        : CupertinoButton(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            color: const Color(0xFFF8F7F5),
            child: Text(
              name,
              style: const TextStyle(fontSize: 14.0, color: Colors.black),
            ),
            onPressed: () => context.read<Dishes>().updateTagsActivity(name),
          );
  }
}
