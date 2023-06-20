import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food/logic/networking/dishes.dart';
import 'package:provider/provider.dart';

import 'package:food/components/tag_tabs.dart';
import 'package:food/components/dish_card.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({
    super.key,
    required this.categoryName,
  });

  final String categoryName;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        border: const Border(bottom: BorderSide.none),
        backgroundColor: Colors.white,
        trailing: CircleAvatar(
          child: Image.asset('assets/images/user_photo.png'),
        ),
        middle: Text(categoryName),
      ),
      child: Column(
        children: [
          TagTabs(),
          Expanded(
            child: GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 15,
                  childAspectRatio: 0.85,
                ),
                itemCount: context.watch<Dishes>().listOfTagDishes.length,
                itemBuilder: (BuildContext context, index) {
                  return DishCard(index: index);
                }),
          ),
        ],
      ),
    );
  }
}
