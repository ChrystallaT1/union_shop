import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:union_shop/views/product/product_page.dart';
import 'package:union_shop/views/home/home_screen.dart';
import 'package:union_shop/views/about/about_screen.dart';
import 'package:union_shop/views/collections/collections_screen.dart';
import 'package:union_shop/views/collection/collection_detail_screen.dart';
import 'package:union_shop/views/sale/sale_screen.dart';
import 'package:union_shop/views/auth/login_screen.dart';
import 'package:union_shop/views/auth/signup_screen.dart';
import 'package:union_shop/views/cart/cart_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
      home: const HomeScreen(),
      initialRoute: '/',
      routes: {
        '/product': (context) {
          final args = ModalRoute.of(context)!.settings.arguments
              as Map<String, String>?;
          return ProductPage(
            productId: args?['id'],
            productName: args?['name'],
            productPrice: args?['price'],
            productImage: args?['image'],
          );
        },
        '/about': (context) => const AboutScreen(),
        '/collections': (context) => const CollectionsScreen(),
        '/collection-detail': (context) => CollectionDetailScreen(
              collectionName:
                  ModalRoute.of(context)!.settings.arguments as String,
            ),
        '/sale': (context) => const SaleScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/cart': (context) => const CartScreen(),
      },
    );
  }
}
