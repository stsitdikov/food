import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food/logic/networking/cart.dart';
import 'package:food/logic/networking/location.dart';
import 'package:food/screens/cart_screen.dart';
import 'package:food/screens/error_screen.dart';
import 'package:provider/provider.dart';

import 'package:food/components/bottom_navigation_items.dart';
import 'package:food/screens/main_screen.dart';
import 'package:food/logic/networking/dishes.dart';

class AppScaffold extends StatefulWidget {
  const AppScaffold({Key? key}) : super(key: key);

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  @override
  void initState() {
    context.read<Dishes>().getDishesInfo();
    context.read<Location>().getCityName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          backgroundColor: Colors.white,
          items:
              BottomNavBarItems().list(context.watch<Cart>().cartItems.length),
        ),
        tabBuilder: (BuildContext context, int index) {
          Map<int, Widget> mapOfTheApp = {
            0: const MainScreen(),
            2: const CartScreen(),
            9: const ErrorScreen(),
          };
          return CupertinoTabView(
            builder: (BuildContext context) {
              if (mapOfTheApp[index] != null) {
                return mapOfTheApp[index]!;
              } else {
                return mapOfTheApp[9]!;
              }
            },
          );
        });
  }
}
