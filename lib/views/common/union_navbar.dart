import 'package:flutter/material.dart';

//custom navigation bar widget for the UPSU Union Shop app
class UnionNavbar extends StatelessWidget implements PreferredSizeWidget {
  const UnionNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('UPSU Union Shop'), // Title of the app bar
      actions: [
        // Button to navigate to the Home screen
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/');
          },
          child: const Text('Home'),
        ),
        // Button for Collections
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/collections');
          },
          child: const Text('Collections'),
        ),
        // Button for Sale
        TextButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Sale page coming soon')),
            );
          },
          child: const Text('Sale'),
        ),
        TextButton(
          //button for about us page
          onPressed: () {
            Navigator.pushNamed(context, '/about');
          },
          child: const Text('About Us'),
        ),
        // Button for Account
        TextButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Account page coming soon')),
            );
          },
          child: const Text('Account'),
        ),
        // Icon button for the Cart
        IconButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Cart coming soon')),
            );
          },
          icon: const Icon(Icons.shopping_bag_outlined),
        ),
      ],
    );
  }

  // Specifies the preferred size of the app bar
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
