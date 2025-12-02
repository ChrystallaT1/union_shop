import 'package:flutter/material.dart';

//custom navigation bar widget for the UPSU Union Shop app
class UnionNavbar extends StatelessWidget implements PreferredSizeWidget {
  final bool highlightSale;
  final bool highlightAccount; // Add this parameter

  const UnionNavbar({
    super.key,
    this.highlightSale = false,
    this.highlightAccount = false, // Add default value
  });

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
            Navigator.pushNamed(context, '/sale');
          },
          child: Text(
            'Sale',
            style: TextStyle(
              color: highlightSale ? const Color(0xFF4d2963) : Colors.white,
            ),
          ),
        ),
        TextButton(
          //button for about us page
          onPressed: () {
            Navigator.pushNamed(context, '/about');
          },
          child: const Text('About Us'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/login');
          },
          child: Text(
            'Account',
            style: TextStyle(
              color: highlightAccount
                  ? const Color(0xFF4d2963)
                  : Colors.white, // conditional
            ),
          ),
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
