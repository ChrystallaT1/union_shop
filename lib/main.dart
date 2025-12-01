import 'package:flutter/material.dart';
import 'package:union_shop/views/product/product_page.dart';
import 'package:union_shop/views/home/home_screen.dart';
import 'package:union_shop/views/about/about_screen.dart';

void main() {
  runApp(const UnionShopApp());
}

class UnionShopApp extends StatelessWidget {
  const UnionShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Union Shop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4d2963)),
      ),
      home: const HomeScreen(), // HomeScreen is wrapped by MaterialApp
      initialRoute: '/',
      routes: {
        '/product': (context) => const ProductPage(),
        '/about': (context) => const AboutScreen(),
      },
    );
  }
}
