import 'package:flutter/material.dart';

// Mobile drawer menu for navigation
class MobileDrawer extends StatelessWidget {
  final bool highlightSale;
  final bool highlightAccount;

  const MobileDrawer({
    super.key,
    this.highlightSale = false,
    this.highlightAccount = false,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Drawer header
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color(0xFF4d2963),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Icon(
                  Icons.store,
                  color: Colors.white,
                  size: 48,
                ),
                const SizedBox(height: 16),
                const Text(
                  'UPSU Union Shop',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Navigate to your favorite sections',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          // Home
          ListTile(
            leading: const Icon(Icons.home_outlined, color: Color(0xFF4d2963)),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context); // Close drawer
              Navigator.pushNamed(context, '/');
            },
          ),

          // Collections
          ListTile(
            leading:
                const Icon(Icons.grid_view_outlined, color: Color(0xFF4d2963)),
            title: const Text('Collections'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/collections');
            },
          ),

          // Sale
          ListTile(
            leading: Icon(
              Icons.local_offer_outlined,
              color: highlightSale ? Colors.red : const Color(0xFF4d2963),
            ),
            title: Text(
              'Sale',
              style: TextStyle(
                color: highlightSale ? Colors.red : Colors.black87,
                fontWeight: highlightSale ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            trailing: highlightSale
                ? Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'HOT',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : null,
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/sale');
            },
          ),

          // About Us
          ListTile(
            leading: const Icon(Icons.info_outlined, color: Color(0xFF4d2963)),
            title: const Text('About Us'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/about');
            },
          ),

          const Divider(),

          // Account
          ListTile(
            leading: const Icon(
              Icons.person_outline,
              color: Color(0xFF4d2963),
            ),
            title: const Text(
              'Account',
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/login');
            },
          ),

          // Cart
          ListTile(
            leading: const Icon(Icons.shopping_bag_outlined,
                color: Color(0xFF4d2963)),
            title: const Text('Shopping Cart'),
            trailing: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                '0',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Cart coming soon!')),
              );
            },
          ),

          const Divider(),

          // Footer info
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Version 1.0.0\n© 2025 UPSU Union Shop',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
