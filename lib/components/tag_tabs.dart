import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food/logic/networking/dishes.dart';
import 'package:provider/provider.dart';
import 'package:food/components/tag_button.dart';

class TagTabs extends StatelessWidget {
  const TagTabs({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<String> listOfTags = context.watch<Dishes>().listOfTags;

    return SizedBox(
      height: 50.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(8),
        itemCount: listOfTags.length,
        itemBuilder: (BuildContext context, int index) {
          if (index < listOfTags.length) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: TagButton(
                name: listOfTags[index],
              ),
            );
          } else {
            return const Text('ЖДЕМ');
          }
        },
      ),
    );
  }
}
