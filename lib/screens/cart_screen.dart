import 'package:book_store/shared_preferences/app_preferences_controller.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../fb_controller/firestore_controller.dart';
import '../model/products_model.dart';
import '../shared_preferences/user_preferences_controler.dart';
import '../utilities/helpers.dart';

class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> with Helpers {
  final FbFireStoreController _fireStoreController = FbFireStoreController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'Cart',
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
      body: FutureBuilder<List<Product>>(
        future: _fireStoreController.getProductsCart(userId: UserPreferenceController().id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            List<Product> cartItems = snapshot.data!;
            return ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                Product product = cartItems[index];
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
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () async {
                        bool deleted = await _fireStoreController.deleteCart(
                          product.id,
                          UserPreferenceController().id,
                        );
                        if (deleted) {
                          setState(() {});
                          showSnackBar(
                            context: context,
                            message: 'Item removed from cart',
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
              child: Text(
                'Your cart is empty',
                style: TextStyle(fontSize: 18),
              ),
            );
          }
        },
      ),
    );
  }
}
