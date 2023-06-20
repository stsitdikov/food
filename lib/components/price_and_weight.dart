import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:food/logic/dish.dart';

class PriceAndWeight extends StatelessWidget {
  const PriceAndWeight({
    super.key,
    required this.dish,
  });

  final Dish dish;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '${dish.price} ₽ ',
          style: const TextStyle(fontSize: 14.0),
        ),
        Text(
          '· ${dish.weight}г',
          style:
              TextStyle(fontSize: 14.0, color: Colors.black.withOpacity(0.4)),
        ),
      ],
    );
  }
}
