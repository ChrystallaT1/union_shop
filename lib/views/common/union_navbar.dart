import 'package:flutter/material.dart';

// Responsive: Full navbar on desktop, collapsible menu on mobile
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
    // Get screen width for responsive design
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return AppBar(
      backgroundColor: const Color(0xFF4d2963),
      elevation: 4,
      // ONLY on mobile
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
      automaticallyImplyLeading: isMobile, // Only  on mobile
      title: const Text(
        'UPSU Union Shop',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
      // Show different actions based on screen size
      actions: isMobile
          ? _buildMobileActions(context)
          : _buildDesktopActions(context),
    );
  }

  // Desktop: Full navigation menu
  List<Widget> _buildDesktopActions(BuildContext context) {
    return [
      TextButton(
        onPressed: () => Navigator.pushNamed(context, '/'),
        child: const Text('Home', style: TextStyle(color: Colors.white)),
      ),
      TextButton(
        onPressed: () => Navigator.pushNamed(context, '/collections'),
        child: const Text('Collections', style: TextStyle(color: Colors.white)),
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
      TextButton(
        onPressed: () => Navigator.pushNamed(context, '/login'),
        child: Text(
          'Account',
          style: TextStyle(
            color: highlightAccount ? Colors.amber : Colors.white,
            fontWeight: highlightAccount ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
      IconButton(
        icon: const Icon(Icons.shopping_bag_outlined, color: Colors.white),
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Cart coming soon!')),
          );
        },
        tooltip: 'Shopping Cart',
      ),
    ];
  }

  // Mobile: Only cart icon (menu is in leading/hamburger)
  List<Widget> _buildMobileActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.shopping_bag_outlined, color: Colors.white),
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Cart coming soon!')),
          );
        },
        tooltip: 'Shopping Cart',
      ),
    ];
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
