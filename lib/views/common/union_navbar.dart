import 'package:flutter/material.dart';

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
      title: GestureDetector(
        onTap: () => Navigator.pushNamed(context, '/'),
        child: const Text(
          'UPSU Union Shop',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      actions: isMobile
          ? _buildMobileActions(context)
          : _buildDesktopActions(context),
    );
  }

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
        icon: const Icon(Icons.shopping_cart_outlined, color: Colors.white),
        onPressed: () => Navigator.pushNamed(context, '/cart'),
        tooltip: 'Shopping Cart',
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
}
