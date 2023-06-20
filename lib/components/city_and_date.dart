import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:food/logic/networking/location.dart';

class CityAndDate extends StatelessWidget {
  const CityAndDate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<int, String> months = {
      1: 'Января',
      2: 'Февраля',
      3: 'Марта',
      4: 'Апреля',
      5: 'Мая',
      6: 'Июня',
      7: 'Июля',
      8: 'Августа',
      9: 'Сентября',
      10: 'Октября',
      11: 'Ноября',
      12: 'Декабря',
    };

    final int currentDay = DateTime.now().day;
    final String currentMonth = months[DateTime.now().month].toString();
    final int currentYear = DateTime.now().year;
    final city = context.watch<Location>().city;

    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(2.0, 0.0, 3.0, 0.0),
          child: Image.asset(
            'assets/icons/location.png',
            height: 24.0,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 4.0,
            ),
            Text(city),
            Text(
              '$currentDay $currentMonth, $currentYear',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: Colors.black.withOpacity(0.5),
              ),
            )
          ],
        )
      ],
    );
  }
}
