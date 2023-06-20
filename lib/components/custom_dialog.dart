import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food/logic/dish.dart';
import 'package:provider/provider.dart';

import 'package:food/logic/networking/dishes.dart';
import 'package:food/components/custom_icon_button.dart';
import 'package:food/components/price_and_weight.dart';
import 'package:food/logic/networking/cart.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    var data = context.watch<Dishes>().listOfTagDishes[index];
    Dish dish = Dish(
        id: data.id,
        name: data.name,
        price: data.price,
        weight: data.weight,
        description: data.description,
        imageUrl: data.imageUrl,
        tags: data.tags);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 90.0),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 230.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: const Color(0xFFF8F7F5),
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(12, 10, 10, 0),
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
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CustomIconButton(
                            imageAssetPath: 'assets/icons/heart.png',
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          CustomIconButton(
                            imageAssetPath: 'assets/icons/clear.png',
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                dish.name,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              PriceAndWeight(dish: dish),
              Text(
                dish.description,
                style: TextStyle(
                    fontSize: 14.0, color: Colors.black.withOpacity(0.65)),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Center(
                child: CupertinoButton.filled(
                  child: const Text('Добавить в корзину'),
                  onPressed: () {
                    context.read<Cart>().addToCart(dish);
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
