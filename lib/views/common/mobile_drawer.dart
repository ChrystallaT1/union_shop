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
          // Drawer Header
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color(0xFF4d2963),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Icon(
                  Icons.shopping_bag,
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
              ],
            ),
          ),
          // Menu Items
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context); // Close drawer
              Navigator.pushNamed(context, '/');
            },
          ),
          ListTile(
            leading: const Icon(Icons.grid_view),
            title: const Text('Collections'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/collections');
            },
          ),
          ListTile(
            leading: Icon(
              Icons.local_offer,
              color:
                  highlightSale ? Colors.amber : Colors.red, // ✅ Use highlight
            ),
            title: Text(
              'Sale',
              style: TextStyle(
                color: highlightSale
                    ? Colors.amber
                    : Colors.red, // ✅ Use highlight
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/sale');
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About Us'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/about');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.shopping_cart),
            title: const Text('Cart'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/cart');
            },
          ),
          ListTile(
            leading: Icon(
              Icons.person,
              color: highlightAccount ? Colors.amber : null, // ✅ Use highlight
            ),
            title: Text(
              'Account',
              style: TextStyle(
                color:
                    highlightAccount ? Colors.amber : null, // ✅ Use highlight
                fontWeight:
                    highlightAccount ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/login');
            },
          ),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Print Shack'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/print-shack');
            },
          ),
        ],
      ),
    );
  }
}
