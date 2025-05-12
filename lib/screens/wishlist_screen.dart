import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../fb_controller/firestore_controller.dart';
import '../model/products_model.dart';
import '../shared_preferences/user_preferences_controler.dart';
import '../utilities/helpers.dart';

class WishlistScreen extends StatefulWidget {
  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> with Helpers {
  final FbFireStoreController _fireStoreController = FbFireStoreController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Iconsax.arrow_left_2, color: Theme.of(context).colorScheme.onBackground),
        ),
        centerTitle: true,
        title: Text(
          'Wishlist',
          style: TextStyle(
            fontFamily: 'Cairo',
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
      ),
      body: FutureBuilder<List<Product>>(
        future: _fireStoreController.getWishlistItems(userId: UserPreferenceController().id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            List<Product> wishlistItems = snapshot.data!;
            return ListView.builder(
              itemCount: wishlistItems.length,
              itemBuilder: (context, index) {
                Product product = wishlistItems[index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Image.network(
                      product.image,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(product.name),
                    subtitle: Text('\$${product.price}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.shopping_cart, color: Colors.blue),
                          onPressed: () async {
                            bool added = await _fireStoreController.addProductToCart(
                              productId: product.id,
                              userId: UserPreferenceController().id,
                            );
                            if (added) {
                              showSnackBar(
                                context: context,
                                message: 'Added to cart',
                              );
                            }
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () async {
                            bool removed = await _fireStoreController.removeFromWishlist(
                              productId: product.id,
                              userId: UserPreferenceController().id,
                            );
                            if (removed) {
                              setState(() {});
                              showSnackBar(
                                context: context,
                                message: 'Removed from wishlist',
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Text(
                'Your wishlist is empty',
                style: TextStyle(fontSize: 18),
              ),
            );
          }
        },
      ),
    );
  }
} 