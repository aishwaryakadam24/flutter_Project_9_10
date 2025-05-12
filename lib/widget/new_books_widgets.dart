import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import '../fb_controller/firestore_controller.dart';
import '../model/new_product_model.dart';
import '../model/products_model.dart';
import '../provider/new_product_provider.dart';
import '../provider/product_provider.dart';
import '../shared_preferences/app_preferences_controller.dart';

class NewBooksWidget extends StatelessWidget {
  const NewBooksWidget({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: StreamBuilder<QuerySnapshot>(
          stream: FbFireStoreController().getNewProducts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState ==
                ConnectionState.waiting) {
              return  Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                    color: Colors.black,
                    size: 25,
                  ),);
            } else if (snapshot.hasData &&
                snapshot.data!.docs.isNotEmpty) {
              List<QueryDocumentSnapshot> allNewProducts =
                  snapshot.data!.docs;
              return ListView.builder(
                padding: const EdgeInsetsDirectional.only(top: 10),
                itemCount: allNewProducts.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return
                      GestureDetector(
                        onTap: () {
                          Provider.of<ProductProvider>(context,
                              listen: false)
                              .changeProduct(
                            product: Product(
                              id: allNewProducts[index].id,
                              image: allNewProducts[index].get('image'),
                              price: allNewProducts[index].get('price'),
                              name: allNewProducts[index].get('name_en'),
                              description: allNewProducts[index].get('description_en'),
                            ),
                          );
                          Navigator.pushNamed(context, '/details_screen');
                        },
                    child: Container(
                      width: 100.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network('${allNewProducts[index].get('image')}', height: 140.0),
                          const SizedBox(height: 7.0),
                          Text('${allNewProducts[index].get('name_en')}',
                              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.0), overflow: TextOverflow.ellipsis),

                          RatingBar.builder(
                            initialRating: allNewProducts[index].get('rating') ?? 0.0,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 10,
                            ignoreGestures: true,
                            itemPadding: EdgeInsets.symmetric(horizontal: 0.5),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {

                            },
                          )
                          // Text("★️ 3.5", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12.0, color: Colors.orangeAccent)),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    // Icon(Icons.warning, size: 40),
                    Text(
                      'NOT EXIST ANY BOOKS',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            }
          }),
    );
  }
}
