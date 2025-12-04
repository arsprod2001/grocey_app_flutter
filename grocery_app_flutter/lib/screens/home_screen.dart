import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/category_item.dart';
import '../widgets/product_card.dart';
import 'product_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userName = "Utilisateur";

  final List<Category> categories = [
    Category(name: "Fruits", icon: Icons.apple),
    Category(name: "Légumes", icon: Icons.grass),
    Category(name: "Viandes", icon: Icons.set_meal),
    Category(name: "Boissons", icon: Icons.local_drink),
    Category(name: "Laitiers", icon: Icons.icecream),
    Category(name: "Boulangerie", icon: Icons.bakery_dining),
  ];

  final List<Product> popularProducts = [
    Product(
      id: '1',
      name: 'Pommes Fraîches',
      description: 'Pommes rouges fraîches et croquantes, parfaites pour une collation saine.',
      price: 2.99,
      image: 'assets/images/apple.jpg',
      unit: 'kg',
    ),
    Product(
      id: '2',
      name: 'Bananes Bio',
      description: 'Bananes biologiques riches en potassium.',
      price: 1.99,
      image: 'assets/images/banana.jpg',
      unit: 'kg',
    ),
    Product(
      id: '3',
      name: 'Lait Entier',
      description: 'Lait entier frais, riche en calcium.',
      price: 1.50,
      image: 'assets/images/milk.jpg',
      unit: 'L',
    ),
    Product(
      id: '4',
      name: 'Pain Complet',
      description: 'Pain complet fait maison.',
      price: 3.50,
      image: 'assets/images/bread.jpg',
      unit: 'pièce',
    ),
  ];

  final List<Product> promotionProducts = [
    Product(
      id: '5',
      name: 'Avocados',
      description: 'Avocados mûrs et crémeux.',
      price: 4.99,
      image: 'assets/images/avocado.jpg',
      unit: 'kg',
      discountPercent: 20,
    ),
    Product(
      id: '6',
      name: 'Jus d\'Orange',
      description: 'Jus d\'orange 100% pur jus.',
      price: 3.99,
      image: 'assets/images/orange_juice.jpg',
      unit: 'L',
      discountPercent: 15,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader(),
              _buildBanner(),
              _buildCategoriesSection(),
              _buildPopularProducts(context),
              _buildPromotionsSection(context),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Bienvenue",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              Text(
                userName,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Spacer(),
          CircleAvatar(
            radius: 25,
            backgroundColor: Colors.grey[300],
            child: const Icon(Icons.person, size: 30, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildBanner() {
    return Container(
      margin: const EdgeInsets.all(16),
      height: 150,
      decoration: BoxDecoration(
        color: Colors.blue.shade100,
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          colors: [Colors.blue.shade200, Colors.blue.shade400],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: const Stack(
        children: [
          Positioned(
            left: 20,
            top: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Promotion Spéciale!",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Jusqu'à 50% de réduction",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                "Catégorie",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {},
                child: const Text("Voir plus"),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return CategoryItem(category: categories[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPopularProducts(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Row(
            children: [
              const Text(
                "Populaire",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {},
                child: const Text("Voir plus"),
              ),
            ],
          ),
          const SizedBox(height: 10),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.75,
            ),
            itemCount: popularProducts.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailScreen(product: popularProducts[index]),
                    ),
                  );
                },
                child: ProductCard(product: popularProducts[index]),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPromotionsSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Row(
            children: [
              const Text(
                "Promotion",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {},
                child: const Text("Voir plus"),
              ),
            ],
          ),
          const SizedBox(height: 10),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.75,
            ),
            itemCount: promotionProducts.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailScreen(product: promotionProducts[index]),
                    ),
                  );
                },
                child: ProductCard(product: promotionProducts[index]),
              );
            },
          ),
        ],
      ),
    );
  }
}


