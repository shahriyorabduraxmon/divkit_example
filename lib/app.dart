import 'package:divkit_project/pages/home_page.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "DivKit Example App",
      debugShowCheckedModeBanner: false,
      builder: (context, page) => Directionality(
        textDirection: TextDirection.ltr,
        child: page ?? const SizedBox.shrink(),
      ),
      home: const HomePage(),
    );
  }
}
