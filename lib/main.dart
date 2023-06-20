import 'package:flutter/cupertino.dart';
import 'package:food/logic/networking/cart.dart';
import 'package:food/logic/networking/dishes.dart';
import 'package:food/logic/networking/location.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import 'components/app_scaffold.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => Dishes()),
    ChangeNotifierProvider(create: (_) => Location()),
    ChangeNotifierProvider(create: (_) => Cart()),
  ], child: const FoodApp()));
}

class FoodApp extends StatelessWidget {
  const FoodApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      home: AppScaffold(),
    );
  }
}
