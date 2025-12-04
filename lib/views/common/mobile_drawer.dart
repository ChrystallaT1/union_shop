import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:union_shop/services/auth_service.dart';
import 'package:union_shop/services/cart_service.dart';

class MobileDrawer extends StatelessWidget {
  const MobileDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final String? currentRoute = ModalRoute.of(context)?.settings.name;
    final bool highlightSale = currentRoute == '/sale';

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Drawer Header with Auth State
          StreamBuilder<User?>(
            stream: AuthService().authStateChanges,
            builder: (context, snapshot) {
              final user = snapshot.data;
              final isLoggedIn = user != null;

              return UserAccountsDrawerHeader(
                decoration: const BoxDecoration(
                  color: Color(0xFF4d2963),
                ),
                accountName: Text(
                  isLoggedIn ? (user.displayName ?? 'User') : 'Guest',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                accountEmail: Text(
                  isLoggedIn ? (user.email ?? '') : 'Not logged in',
                ),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: isLoggedIn && user.photoURL != null
                      ? NetworkImage(user.photoURL!)
                      : null,
                  child: isLoggedIn && user.photoURL == null
                      ? Text(
                          (user.displayName ?? 'U')[0].toUpperCase(),
                          style: const TextStyle(
                            fontSize: 24,
                            color: Color(0xFF4d2963),
                          ),
                        )
                      : const Icon(
                          Icons.person,
                          size: 32,
                          color: Color(0xFF4d2963),
                        ),
                ),
              );
            },
          ),

          // Home
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/');
            },
          ),

          // Collections
          ListTile(
            leading: const Icon(Icons.grid_view),
            title: const Text('Collections'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/collections');
            },
          ),

          // Print Shack
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Print Shack'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/print-shack');
            },
          ),

          // Sale
          ListTile(
            leading: Icon(
              Icons.local_offer,
              color: highlightSale ? Colors.amber : Colors.red,
            ),
            title: Text(
              'Sale',
              style: TextStyle(
                color: highlightSale ? Colors.amber : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/sale');
            },
          ),

          // About Us
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About Us'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/about');
            },
          ),

          const Divider(),

          // Cart
          ValueListenableBuilder<int>(
            valueListenable: CartService().cartCountNotifier,
            builder: (context, count, child) {
              return ListTile(
                leading: Stack(
                  children: [
                    const Icon(Icons.shopping_cart_outlined),
                    if (count > 0)
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 16,
                            minHeight: 16,
                          ),
                          child: Text(
                            count > 99 ? '99+' : '$count',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                  ],
                ),
                title: Text('Cart ${count > 0 ? '($count)' : ''}'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/cart');
                },
              );
            },
          ),

          // Account / Login (dynamic)
          StreamBuilder<User?>(
            stream: AuthService().authStateChanges,
            builder: (context, snapshot) {
              final isLoggedIn = snapshot.data != null;
              return ListTile(
                leading: Icon(isLoggedIn ? Icons.account_circle : Icons.login),
                title: Text(isLoggedIn ? 'Account' : 'Login'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(
                    context,
                    isLoggedIn ? '/account' : '/login',
                  );
                },
              );
            },
          ),

          // Logout (only shows if logged in)
          StreamBuilder<User?>(
            stream: AuthService().authStateChanges,
            builder: (context, snapshot) {
              if (snapshot.data == null) return const SizedBox.shrink();
              return ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title:
                    const Text('Logout', style: TextStyle(color: Colors.red)),
                onTap: () async {
                  Navigator.pop(context); // Close drawer first

                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Logout'),
                      content: const Text('Are you sure you want to logout?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context, true),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          child: const Text('Logout'),
                        ),
                      ],
                    ),
                  );

                  if (confirm == true && context.mounted) {
                    // ✅ Clear cart before logout
                    await CartService().clearCartOnLogout();

                    await AuthService().signOut();

                    if (context.mounted) {
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/', (route) => false);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Logged out successfully'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    }
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
