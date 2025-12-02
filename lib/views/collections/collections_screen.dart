import 'package:flutter/material.dart';
import 'package:union_shop/views/common/union_navbar.dart';
import 'package:union_shop/views/common/union_footer.dart';
import 'package:union_shop/views/common/mobile_drawer.dart';

// screen displaying product collections
class CollectionsScreen extends StatelessWidget {
  const CollectionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final isTablet = screenWidth >= 600 && screenWidth < 1024;

    return Scaffold(
      appBar: const UnionNavbar(),
      drawer: const MobileDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                vertical: isMobile ? 32 : 48,
                horizontal: isMobile ? 16 : 24,
              ),
              color: Colors.grey[100],
              child: Column(
                children: [
                  Text(
                    'Collections',
                    style: TextStyle(
                      fontSize: isMobile ? 28 : 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Browse our curated collections',
                    style: TextStyle(
                      fontSize: isMobile ? 14 : 16,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),

            // Collections grid
            Padding(
              padding:
                  EdgeInsets.all(isMobile ? 16.0 : (isTablet ? 32.0 : 40.0)),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: isMobile ? 1 : (isTablet ? 2 : 4),
                crossAxisSpacing: isMobile ? 16 : 24,
                mainAxisSpacing: isMobile ? 24 : 32,
                childAspectRatio: isMobile ? 1.2 : 1,
                children: const [
                  CollectionCard(
                    title: 'Clothing',
                    description: 'T-shirts, hoodies, and more',
                    imageUrl:
                        'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
                    itemCount: 24,
                  ),
                  CollectionCard(
                    title: 'Accessories',
                    description: 'Bags, hats, and keychains',
                    imageUrl:
                        'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                    itemCount: 18,
                  ),
                  CollectionCard(
                    title: 'Stationery',
                    description: 'Notebooks, pens, and supplies',
                    imageUrl:
                        'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
                    itemCount: 32,
                  ),
                  CollectionCard(
                    title: 'Drinkware',
                    description: 'Mugs, bottles, and tumblers',
                    imageUrl:
                        'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                    itemCount: 15,
                  ),
                ],
              ),
            ),

            // Footer
            const UnionFooter(),
          ],
        ),
      ),
    );
  }
}

//Widget for displaying individual collection cards
class CollectionCard extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;
  final int itemCount;

  const CollectionCard({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.itemCount,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/collection-detail',
          arguments: title,
        );
      },
      child: Card(
        elevation: 2,
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Collection image
            Expanded(
              flex: 3,
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[300],
                    child: const Center(
                      child: Icon(
                        Icons.image_not_supported,
                        color: Colors.grey,
                        size: 48,
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.black54,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '$itemCount items',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
