import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    required this.imageAssetPath,
  });

  final String imageAssetPath;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: imageAssetPath == 'assets/icons/clear.png'
          ? () {
              Navigator.pop(context);
            }
          : () {},
      child: Container(
        width: 40.0,
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Image.asset(
          imageAssetPath,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
