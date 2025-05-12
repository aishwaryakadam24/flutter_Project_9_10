import 'package:book_store/shared_preferences/app_preferences_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import '../fb_controller/firestore_controller.dart';
import '../provider/product_provider.dart';

import '../shared_preferences/user_preferences_controler.dart';
import '../utilities/helpers.dart';

// Detail screen.
class DetailScreen extends StatefulWidget {
  @override
  _DetailScreenState createState() => _DetailScreenState();
}
class _DetailScreenState extends State<DetailScreen> with Helpers{
  final Color _accentColor = Color(0xFF272727);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  Provider.of<ProductProvider>(context).product.image,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.7),
                ],
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              performAddToWishlist(
                                Provider.of<ProductProvider>(context, listen: false).product.id,
                              );
                            },
                            icon: Icon(Icons.favorite_border, color: Colors.white),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.share, color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  padding: EdgeInsets.only(top: 20.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        Provider.of<ProductProvider>(context).product.name,
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RatingBar.builder(
                            initialRating: 4.5,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 15,
                            ignoreGestures: true,
                            itemPadding: EdgeInsets.symmetric(horizontal: 0.5),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {},
                          ),
                          const SizedBox(width: 10.0),
                          Text('4.5',
                              style: TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w700,
                                color: Colors.grey,
                              ))
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 30.0),
                        child: Text(
                          Provider.of<ProductProvider>(context).product.description,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[600],
                            height: 1.5,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20.0),
                        width: double.infinity,
                        height: 50.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          color: _accentColor,
                        ),
                        child: Center(
                          child: InkWell(
                            onTap: () {
                              performAddToCart(
                                Provider.of<ProductProvider>(context, listen: false).product.id,
                              );
                            },
                            child: Text(
                              'ADD TO CART',
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future performAddToCart(String productId) async {
    showDialog(
      context: context,
      builder: (context) => Center(
        child: LoadingAnimationWidget.staggeredDotsWave(
          color: Colors.black,
          size: 30,
        ),
      ),
    );
    bool status = await FbFireStoreController().addProductToCart(
      productId: productId,
      userId: UserPreferenceController().id,
    );

    Navigator.pop(context);
    if (status) {
      showSnackBar(context: context, message: 'Added to cart successfully');
    } else {
      showSnackBar(context: context, message: 'Failed to add to cart');
    }
  }

  Future performAddToWishlist(String productId) async {
    showDialog(
      context: context,
      builder: (context) => Center(
        child: LoadingAnimationWidget.staggeredDotsWave(
          color: Colors.black,
          size: 30,
        ),
      ),
    );
    bool status = await FbFireStoreController().addToWishlist(
      productId: productId,
      userId: UserPreferenceController().id,
    );

    Navigator.pop(context);
    if (status) {
      showSnackBar(context: context, message: 'Added to wishlist');
    } else {
      showSnackBar(context: context, message: 'Failed to add to wishlist');
    }
  }
}
