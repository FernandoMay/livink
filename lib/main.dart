import 'package:flutter/cupertino.dart';
import 'package:livink/theme.dart';
import 'package:livink/view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: const ProductSearchView(),
      theme: LivTheme.getThemeData(),
    );
  }
}
