import 'package:book_store/fb_controller/fb_notifications.dart';
import 'package:book_store/fb_controller/firestore_controller.dart';
import 'package:book_store/shared_preferences/user_preferences_controler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import '../provider/change_language_notifire.dart';
import '../provider/book_provider.dart';
import '../widget/book_card.dart';
import '../widget/drawer.dart';
import '../widget/new_books_widgets.dart';
import '../firebase_seeder.dart';
import 'package:book_store/constants/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widget/image_slider_widget.dart';

/// Home Screen
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with FbNotifications {
  double width = 0;
  double height = 0;
  String? selectedCategory;
  final TextEditingController _searchController = TextEditingController();
  final FbFireStoreController _fireStoreController = FbFireStoreController();

  @override
  void initState() {
    super.initState();
    initializeForegroundNotificationForAndroid();
    manageNotificationAction();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Widget _makeCategoryEl(String title) {
    bool isSelected = selectedCategory == title;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = isSelected ? null : title;
        });
      },
      child: Container(
      height: 40.0,
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
          color: isSelected ? MyColor.orange : Theme.of(context).colorScheme.surface,
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
              color: isSelected ? Colors.white : Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      drawer: MyDrawer(),
      drawerEnableOpenDragGesture: false,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            await FirebaseSeeder.seedData();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Books seeded successfully!'),
                backgroundColor: Colors.green,
              ),
            );
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error seeding books: $e'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: Icon(Icons.add),
        backgroundColor: MyColor.orange,
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: Builder(
          builder: (context) {
            return IconButton(
              onPressed: () {
Scaffold.of(context).openDrawer();
              },
              icon: Icon(Iconsax.menu, color: Theme.of(context).colorScheme.onBackground),
    );
    },
    ),
        centerTitle: true,
        title: Text(
          'Book Store',
          style: TextStyle(
            fontFamily: 'Cairo',
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 23.0),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Iconsax.heart, color: Colors.black45),
                  onPressed: () {
                    Navigator.pushNamed(context, '/wishlist_screen');
                  },
                ),
                const SizedBox(width: 10.0),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Icon(Iconsax.notification, color: Colors.black45),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 23.0),
            child: Column(
              children: [
                SearchWidget(
                  controller: _searchController,
                  onSearch: (query) async {
                    if (query.isNotEmpty) {
                      List<dynamic> results = await _fireStoreController.searchProducts(query);
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Search Results'),
                          content: Container(
                            width: double.maxFinite,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: results.length,
                              itemBuilder: (context, index) {
                                var product = results[index];
                                return ListTile(
                                  leading: Image.network(product.image, width: 50, height: 50),
                                  title: Text(product.name),
                                  subtitle: Text('\$${product.price}'),
                                  onTap: () {
                                    Navigator.pop(context);
                                    // Navigate to product details
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    }
                  },
                ),
                const SizedBox(height: 25.0),
                ImageSliderWidget(),
                const SizedBox(height: 25.0),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _makeCategoryEl('Business'),
                      const SizedBox(width: 7.0),
                      _makeCategoryEl('Programming'),
                      const SizedBox(width: 7.0),
                      _makeCategoryEl('Physics'),
                      const SizedBox(width: 7.0),
                      _makeCategoryEl('History'),
                    ],
                  ),
                ),
                const SizedBox(height: 35.0),
                if (selectedCategory != null)
                  StreamBuilder<QuerySnapshot>(
                    stream: _fireStoreController.getProductsByCategory(selectedCategory!),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            var doc = snapshot.data!.docs[index];
                            return Card(
                              margin: EdgeInsets.all(8.0),
                              child: ListTile(
                                leading: Image.network(
                                  doc.get('image'),
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                ),
                                title: Text(doc.get('name_en')),
                                subtitle: Text('\$${doc.get('price')}'),
                                trailing: IconButton(
                                  icon: Icon(Icons.shopping_cart),
                                  onPressed: () async {
                                    bool added = await _fireStoreController.addProductToCart(
                                      productId: doc.id,
                                      userId: UserPreferenceController().id,
                                    );
                                    if (added) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Added to cart')),
                                      );
                                    }
                                  },
                    ),
                              ),
                            );
                          },
                        );
                      } else {
                        return Center(
                          child: Text('No books found in this category'),
                        );
                      }
                    },
                  )
                else
                  Column(
                    children: [
                Container(
                  width: double.infinity,
                  height: 150.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    gradient: LinearGradient(
                      begin: FractionalOffset.topLeft,
                      end: FractionalOffset.bottomRight,
                      colors: [
                        MyColor.orange,
                        MyColor.lightBlue,
                      ],
                    ),
                  ),
                  child: Center(
                    child: Text(
                            'Best Sellers',
                      style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                      StreamBuilder<QuerySnapshot>(
                        stream: _fireStoreController.getProducts(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          }
                          
                          if (snapshot.hasError) {
                            return Center(
                              child: Text('Error: ${snapshot.error}'),
                            );
                          }

                          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                            return Center(
                              child: Text('No books available'),
                            );
                          }

                          return GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.7,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              var doc = snapshot.data!.docs[index];
                              return GestureDetector(
                                onTap: () {
                                  // Navigate to book details
                                  Navigator.pushNamed(
                                    context,
                                    '/details_screen',
                                    arguments: doc.id,
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 10,
                                        offset: Offset(0, 5),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(15),
                                        ),
                                        child: Image.network(
                                          doc.get('image') ?? '',
                                          height: 150,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) {
                                            return Container(
                                              height: 150,
                                              color: Colors.grey[300],
                                              child: Icon(Icons.book, size: 50),
                                            );
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              doc.get('name_en') ?? 'Unknown Book',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            SizedBox(height: 4),
                                            Text(
                                              '\$${doc.get('price')?.toString() ?? '0.00'}',
                                              style: TextStyle(
                                                color: MyColor.orange,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                              ),
                                            ),
                                            SizedBox(height: 8),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                  size: 16,
                                                ),
                                                Text(
                                                  '${doc.get('rating')?.toString() ?? '0.0'}',
                                                  style: TextStyle(
                                                    color: Colors.grey[600],
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                IconButton(
                                                  icon: Icon(
                                                    Icons.shopping_cart_outlined,
                                                    size: 20,
                                                    color: MyColor.orange,
                                                  ),
                                                  onPressed: () async {
                                                    bool added = await _fireStoreController.addProductToCart(
                                                      productId: doc.id,
                                                      userId: UserPreferenceController().id,
                                                    );
                                                    if (added) {
                                                      ScaffoldMessenger.of(context).showSnackBar(
                                                        SnackBar(
                                                          content: Text('Added to cart'),
                                                          backgroundColor: Colors.green,
                                                        ),
                                                      );
                                                    }
                                                  },
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SearchWidget extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSearch;

  SearchWidget({
    required this.controller,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.grey[200],
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search, color: Colors.grey),
          suffixIcon: IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              controller.clear();
            },
          ),
          border: InputBorder.none,
          hintStyle: TextStyle(color: Colors.grey),
          hintText: 'Search books...',
        ),
        onSubmitted: onSearch,
      ),
    );
  }
}
