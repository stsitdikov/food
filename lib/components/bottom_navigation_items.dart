import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food/logic/constants.dart';

class BottomNavBarItems {
  List<BottomNavigationBarItem> list(int amount) {
    return [
      BottomNavigationBarItem(
        activeIcon: Image.asset(
          'assets/icons/main.png',
          color: kActiveColor,
          height: 24.0,
        ),
        icon: Image.asset(
          'assets/icons/main.png',
          height: 24.0,
        ),
        label: 'Главная',
      ),
      BottomNavigationBarItem(
        activeIcon: Image.asset(
          'assets/icons/search.png',
          color: kActiveColor,
          height: 24.0,
        ),
        icon: Image.asset(
          'assets/icons/search.png',
          height: 24.0,
        ),
        label: 'Поиск',
      ),
      BottomNavigationBarItem(
        activeIcon: amount != 0
            ? Badge(
                label: Text(amount.toString()),
                child: Image.asset(
                  'assets/icons/cart.png',
                  color: kActiveColor,
                  height: 24.0,
                ),
              )
            : Image.asset(
                'assets/icons/cart.png',
                color: kActiveColor,
                height: 24.0,
              ),
        icon: amount != 0
            ? Badge(
                label: Text(amount.toString()),
                child: Image.asset(
                  'assets/icons/cart.png',
                  height: 24.0,
                ),
              )
            : Image.asset(
                'assets/icons/cart.png',
                height: 24.0,
              ),
        label: 'Корзина',
      ),
      BottomNavigationBarItem(
        activeIcon: Image.asset(
          'assets/icons/account.png',
          color: kActiveColor,
          height: 24.0,
        ),
        icon: Image.asset(
          'assets/icons/account.png',
          height: 24.0,
        ),
        label: 'Аккаунт',
      ),
    ];
  }
}
