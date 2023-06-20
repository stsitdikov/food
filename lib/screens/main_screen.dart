import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/city_and_date.dart';
import '../components/category_card.dart';
import 'package:food/logic/networking/dishes.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        border: const Border(bottom: BorderSide.none),
        backgroundColor: Colors.white,
        trailing: CircleAvatar(
          child: Image.asset('assets/images/user_photo.png'),
        ),
        middle: const CityAndDate(),
      ),
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: context.watch<Dishes>().categories.length,
        itemBuilder: (BuildContext context, int index) {
          if (index < context.watch<Dishes>().categories.length) {
            return CategoryCard(
                categoryName: context.watch<Dishes>().categories[index].name,
                categoryImageUrl:
                    context.watch<Dishes>().categories[index].imageUrl);
          } else {
            return const Text('ЖДЕМ');
          }
        },
      ),
    );
  }
}
