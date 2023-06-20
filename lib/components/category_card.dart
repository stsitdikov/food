import 'package:flutter/cupertino.dart';

import 'package:food/screens/category_screen.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard(
      {Key? key, required this.categoryName, required this.categoryImageUrl})
      : super(key: key);

  final String categoryName;
  final String categoryImageUrl;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          CupertinoPageRoute<void>(
            builder: (BuildContext context) {
              return CategoryScreen(categoryName: categoryName);
            },
          ),
        );
      },
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Stack(
            children: [
              Container(
                height: 150.0,
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Image.network(
                  categoryImageUrl,
                  frameBuilder: (BuildContext context, Widget child, int? frame,
                      bool wasSynchronouslyLoaded) {
                    if (wasSynchronouslyLoaded) {
                      return child;
                    }
                    return AnimatedOpacity(
                      opacity: frame == null ? 0 : 1,
                      duration: const Duration(seconds: 1),
                      curve: Curves.easeOut,
                      child: child,
                    );
                  },
                ),
                // Image.network(
                //   categoryImageUrl,
                //   loadingBuilder: (BuildContext context, Widget child,
                //       ImageChunkEvent? loadingProgress) {
                //     if (loadingProgress == null) {
                //       return child;
                //     }
                //     return const CupertinoActivityIndicator();
                //   },
                // ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 40.0),
                        child: Text(
                          categoryName,
                          style: const TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.w500),
                        )),
                  ),
                  Expanded(child: Container())
                ],
              ),
            ],
          )),
    );
  }
}
