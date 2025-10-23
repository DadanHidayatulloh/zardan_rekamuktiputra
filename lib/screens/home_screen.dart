import 'package:flutter/material.dart';
import 'package:rekamukti_putra/utils/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeTab(),
    const Center(child: Text('Products Page\n(Anggota 2)')),
    const Center(child: Text('Cart Page\n(Anggota 3)')),
    const Center(child: Text('Profile Page')),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppConstants.primaryColor,
        unselectedItemColor: AppConstants.textSecondary,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Products',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar(
            expandedHeight: 120,
            floating: false,
            pinned: true,
            backgroundColor: AppConstants.primaryColor,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                AppConstants.appName,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                ),
              ),
              centerTitle: true,
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications_outlined),
                onPressed: () {},
              ),
            ],
          ),
          
          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.paddingMedium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Search Bar
                  _buildSearchBar(context),
                  const SizedBox(height: 24),
                  
                  // Banner/Promo
                  _buildPromoBanner(context),
                  const SizedBox(height: 24),
                  
                  // Categories
                  _buildSectionTitle(context, 'Kategori Kayu'),
                  const SizedBox(height: 12),
                  _buildCategories(),
                  const SizedBox(height: 24),
                  
                  // Featured Products
                  _buildSectionTitle(context, 'Produk Unggulan'),
                  const SizedBox(height: 12),
                  _buildFeaturedProducts(context),
                  const SizedBox(height: 24),
                  
                  // Info Section
                  _buildInfoSection(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Cari produk kayu...',
          prefixIcon: const Icon(Icons.search, color: AppConstants.textSecondary),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        onTap: () {
          // Navigate to search/products page (Anggota 2)
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Search feature - Anggota 2')),
          );
        },
      ),
    );
  }

  Widget _buildPromoBanner(BuildContext context) {
    return Container(
      height: 160,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppConstants.primaryColor, AppConstants.secondaryColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20,
            bottom: -20,
            child: Icon(
              Icons.carpenter,
              size: 150,
              color: Colors.white.withOpacity(0.1),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppConstants.paddingMedium),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Promo Spesial!',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Diskon hingga 20%\nuntuk pembelian Kayu Jati',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: AppConstants.primaryColor,
                  ),
                  child: const Text('Lihat Promo'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge,
    );
  }

  Widget _buildCategories() {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: AppConstants.categories.length,
        itemBuilder: (context, index) {
          final category = AppConstants.categories[index];
          return Container(
            width: 90,
            margin: const EdgeInsets.only(right: 12),
            child: Column(
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: AppConstants.accentColor.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
                  ),
                  child: const Icon(
                    Icons.category,
                    color: AppConstants.primaryColor,
                    size: 32,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  category,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppConstants.textSecondary,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildFeaturedProducts(BuildContext context) {
    // Dummy products - nanti diganti dengan data dari database (Anggota 4)
    final products = [
      {'name': 'Kayu Jati Premium', 'price': 'Rp 150.000/m³'},
      {'name': 'Kayu Mahoni', 'price': 'Rp 120.000/m³'},
      {'name': 'Kayu Meranti', 'price': 'Rp 90.000/m³'},
    ];

    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Container(
            width: 160,
            margin: const EdgeInsets.only(right: 12),
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 120,
                    decoration: BoxDecoration(
                      color: AppConstants.accentColor.withOpacity(0.2),
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(AppConstants.radiusMedium),
                      ),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.image,
                        size: 50,
                        color: AppConstants.textSecondary,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product['name']!,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          product['price']!,
                          style: const TextStyle(
                            color: AppConstants.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoSection(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.paddingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.info_outline, color: AppConstants.primaryColor),
                const SizedBox(width: 8),
                Text(
                  'Tentang Kami',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'Rekamukti Putra adalah toko kayu terpercaya yang menyediakan berbagai jenis kayu berkualitas tinggi untuk kebutuhan konstruksi dan furniture Anda.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.phone, size: 20, color: AppConstants.primaryColor),
                const SizedBox(width: 8),
                Text(
                  '0812-3456-7890',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.location_on, size: 20, color: AppConstants.primaryColor),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Jl. Kayu Raya No. 123, Bandung',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}