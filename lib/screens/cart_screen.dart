import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:food/components/city_and_date.dart';
import 'package:food/logic/networking/cart.dart';
import 'package:food/components/cart_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  void _showAlertDialog(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => const CupertinoAlertDialog(
        title: Text('Спасибо!'),
        content: Text('Ваш заказ принят, скоро с Вами свяжется оператор.'),
      ),
    );
  }

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
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: context.watch<Cart>().cartItems.isEmpty
                  ? const Center(
                      child: Text('Вы еще ничего не добавили в корзину'),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(8),
                      itemCount: context.watch<Cart>().cartUniqueItems.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (index <
                            context.watch<Cart>().cartUniqueItems.length) {
                          return CartItem(
                            dish: context.watch<Cart>().cartUniqueItems[index],
                          );
                        } else {
                          return const Text('ЖДЕМ');
                        }
                      },
                    ),
            ),
            context.watch<Cart>().cartSum() != 0
                ? CupertinoButton.filled(
                    child:
                        Text('Оплатить ${context.watch<Cart>().cartSum()} ₽'),
                    onPressed: () {
                      context.read<Cart>().pay();
                      _showAlertDialog(context);
                    })
                : Container(),
          ],
        ),
      ),
    );
  }
}
