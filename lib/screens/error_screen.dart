import 'package:flutter/cupertino.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
        child: Center(
      child: Text('Раздел в разработке'),
    ));
  }
}
