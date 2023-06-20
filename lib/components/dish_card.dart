import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food/components/custom_dialog.dart';
import 'package:provider/provider.dart';

import 'package:food/logic/networking/dishes.dart';

class DishCard extends StatelessWidget {
  const DishCard({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showCupertinoModalPopup<void>(
          barrierColor: Colors.black.withOpacity(0.4),
          context: context,
          builder: (BuildContext context) => CustomDialog(index: index),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 109,
            width: 109,
            decoration: BoxDecoration(
                color: Color(0xFFF8F7F5),
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 10, 0, 0),
              child: Image.network(
                context.watch<Dishes>().listOfTagDishes[index].imageUrl,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return CupertinoActivityIndicator();
                },
                fit: BoxFit.contain,
                alignment: Alignment.center,
              ),
            ),
          ),
          Text(
            context.watch<Dishes>().listOfTagDishes[index].name,
            style: TextStyle(fontSize: 14.0),
          ),
        ],
      ),
    );
  }
}
