import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:union_shop/views/home/home_screen.dart';
import 'package:union_shop/views/collections/collections_screen.dart';
import 'package:union_shop/views/collection/collection_detail_screen.dart';
import 'package:union_shop/views/product/product_page.dart';
import 'package:union_shop/views/sale/sale_screen.dart';
import 'package:union_shop/views/about/about_screen.dart';
import 'package:union_shop/views/auth/login_screen.dart';
import 'package:union_shop/views/auth/signup_screen.dart';
import 'package:union_shop/views/cart/cart_screen.dart';
import 'package:union_shop/views/personalization/print_shack_screen.dart';
import 'package:union_shop/views/personalization/print_shack_about_screen.dart';
import 'package:union_shop/views/account/account_dashboard.dart';
import 'package:union_shop/views/account/edit_profile_screen.dart';
import 'package:union_shop/services/cart_service.dart'; // ✅ Add this

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // ✅ Initialize cart
  await CartService().initializeCart();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UPSU Union Shop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4d2963)),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/collections': (context) => const CollectionsScreen(),
        '/collection-detail': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as String;
          return CollectionDetailScreen(collectionName: args);
        },
        '/product': (context) {
          final args = ModalRoute.of(context)!.settings.arguments
              as Map<String, dynamic>;
          return ProductPage(
            productId: args['id'],
            productName: args['name'],
            productPrice: args['price'],
            productImage: args['image'],
          );
        },
        '/sale': (context) => const SaleScreen(),
        '/about': (context) => const AboutScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/cart': (context) => const CartScreen(),
        '/print-shack': (context) => const PrintShackScreen(),
        '/print-shack-about': (context) => const PrintShackAboutScreen(),
        '/edit-profile': (context) => const EditProfileScreen(),
        '/account': (context) => const AccountDashboard(),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(title: const Text('Page Not Found')),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 100, color: Colors.red),
                  const SizedBox(height: 24),
                  const Text(
                    '404 - Page Not Found',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () =>
                        Navigator.pushReplacementNamed(context, '/'),
                    child: const Text('Go Home'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
