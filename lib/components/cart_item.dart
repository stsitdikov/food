import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:food/logic/dish.dart';
import 'package:food/logic/networking/cart.dart';
import 'package:food/components/price_and_weight.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
    required this.dish,
  });

  final Dish dish;

  void _showAlertDialog(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        content: const Text('Вы уверены, что хотите удалить товар из корзины?'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Нет'),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
              context.read<Cart>().removeFromCart(dish);
              Navigator.pop(context);
            },
            child: const Text('Да'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: SizedBox(
        height: 90.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 90.0,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8F7F5),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                    child: Image.network(
                      dish.imageUrl,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
                        return const CupertinoActivityIndicator();
                      },
                      fit: BoxFit.contain,
                      alignment: Alignment.center,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8.0,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.33,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(dish.name),
                      const SizedBox(
                        height: 4.0,
                      ),
                      PriceAndWeight(
                        dish: dish,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              height: 40.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: const Color(0xFFEFEEEC),
              ),
              child: Row(
                children: [
                  CupertinoButton(
                    padding: const EdgeInsets.all(10),
                    child: Image.asset(
                      'assets/icons/minus.png',
                    ),
                    onPressed: () {
                      if (context.read<Cart>().eachItemInCart[dish.name] == 1) {
                        _showAlertDialog(context);
                      } else {
                        context.read<Cart>().removeFromCart(dish);
                      }
                    },
                  ),
                  Text(
                    context.watch<Cart>().eachItemInCart[dish.name].toString(),
                    style: const TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.w400),
                  ),
                  CupertinoButton(
                    padding: const EdgeInsets.all(10),
                    child: Image.asset(
                      'assets/icons/plus.png',
                    ),
                    onPressed: () => context.read<Cart>().addToCart(dish),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
