import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:union_shop/services/auth_service.dart';
import 'package:union_shop/services/cart_service.dart';

class UnionNavbar extends StatelessWidget implements PreferredSizeWidget {
  final bool highlightSale;
  final bool highlightAccount;

  const UnionNavbar({
    super.key,
    this.highlightSale = false,
    this.highlightAccount = false,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return AppBar(
      backgroundColor: const Color(0xFF4d2963),
      elevation: 4,
      leading: isMobile
          ? Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.menu, color: Colors.white),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
            )
          : null,
      automaticallyImplyLeading: isMobile,
      title: Row(
        children: [
          // Logo text on far left
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/'),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.store, color: Colors.white, size: 24),
                const SizedBox(width: 8),
                const Text(
                  'UPSU',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          if (!isMobile) ...[
            const SizedBox(width: 24),
            // Search bar in the middle
            Expanded(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 500),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search products...',
                    hintStyle: const TextStyle(fontSize: 14),
                    prefixIcon: const Icon(Icons.search, size: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.9),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    isDense: true,
                  ),
                  style: const TextStyle(fontSize: 14),
                  onSubmitted: (query) {
                    if (query.isNotEmpty) {
                      Navigator.pushNamed(
                        context,
                        '/search',
                        arguments: query,
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ],
      ),
      actions: isMobile
          ? _buildMobileActions(context)
          : _buildDesktopActions(context),
    );
  }

  List<Widget> _buildDesktopActions(BuildContext context) {
    return [
      // Navigation links
      TextButton(
        onPressed: () => Navigator.pushNamed(context, '/'),
        child: const Text('Home', style: TextStyle(color: Colors.white)),
      ),
      TextButton(
        onPressed: () => Navigator.pushNamed(context, '/collections'),
        child: const Text('Collections', style: TextStyle(color: Colors.white)),
      ),
      TextButton(
        onPressed: () => Navigator.pushNamed(context, '/print-shack'),
        child: const Text('Print Shack', style: TextStyle(color: Colors.white)),
      ),
      TextButton(
        onPressed: () => Navigator.pushNamed(context, '/sale'),
        child: Text(
          'Sale',
          style: TextStyle(
            color: highlightSale ? Colors.amber : Colors.white,
            fontWeight: highlightSale ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
      TextButton(
        onPressed: () => Navigator.pushNamed(context, '/about'),
        child: const Text('About Us', style: TextStyle(color: Colors.white)),
      ),

      // Account button
      StreamBuilder<User?>(
        stream: AuthService().authStateChanges,
        builder: (context, snapshot) {
          final isLoggedIn = snapshot.data != null;
          return TextButton.icon(
            onPressed: () => Navigator.pushNamed(
              context,
              isLoggedIn ? '/account' : '/login',
            ),
            icon: Icon(
              isLoggedIn ? Icons.account_circle : Icons.login,
              color: Colors.white,
              size: 20,
            ),
            label: Text(
              isLoggedIn ? 'Account' : 'Login',
              style: TextStyle(
                color: highlightAccount ? Colors.amber : Colors.white,
                fontWeight:
                    highlightAccount ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          );
        },
      ),

      // Cart button with badge
      Stack(
        children: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined, color: Colors.white),
            onPressed: () => Navigator.pushNamed(context, '/cart'),
            tooltip: 'Cart',
          ),
          // Cart badge
          Positioned(
            right: 8,
            top: 8,
            child: ValueListenableBuilder<int>(
              valueListenable: CartService().cartCountNotifier,
              builder: (context, count, child) {
                if (count == 0) return const SizedBox.shrink();

                return Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 18,
                    minHeight: 18,
                  ),
                  child: Text(
                    count > 99 ? '99+' : '$count',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              },
            ),
          ),
        ],
      ),
      const SizedBox(width: 8),
    ];
  }

  List<Widget> _buildMobileActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.shopping_cart_outlined, color: Colors.white),
        onPressed: () => Navigator.pushNamed(context, '/cart'),
        tooltip: 'Shopping Cart',
      ),
    ];
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  Future<void> _handleLogout(BuildContext context) async {
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

    if (confirm == true) {
      // ✅ Clear cart before logout
      await CartService().clearCartOnLogout();

      await AuthService().signOut();

      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Logged out successfully'),
            backgroundColor: Colors.green,
          ),
        );
      }
    }
  }
}
