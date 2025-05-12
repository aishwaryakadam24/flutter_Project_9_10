import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import '../fb_controller/firestore_controller.dart';
import '../model/products_model.dart';
import '../provider/product_provider.dart';
import '../shared_preferences/app_preferences_controller.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  late double width;
  late double height;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: Builder(
          builder: (context) {
            return IconButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/app_screen');
              },
              icon: Icon(
                Iconsax.back_square,
                color: Colors.black45,
              ),
            );
          },
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 23.0),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Iconsax.heart, color: Colors.black45),
                  onPressed: () {},
                ),
                // const SizedBox(width: 10.0),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Icon(Iconsax.notification, color: Colors.black45),)
              ],
            ),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: width / 39.27,
          vertical: height / 32.145,
        ),
        child:StreamBuilder<QuerySnapshot>(
            stream: FbFireStoreController().getProducts(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                    color: Colors.black,
                    size: 30,
                  ),
                );
              } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                List<QueryDocumentSnapshot> allProducts = snapshot.data!.docs;
                return ListView.builder(
                  padding: const EdgeInsetsDirectional.only(top: 10),
                  itemCount:allProducts.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Provider.of<ProductProvider>(context, listen: false).changeProduct(
                          product: Product(
                              id: allProducts[index].id,
                              image: allProducts[index].get('image'),
                              price : allProducts[index].get('price'),
                              name: allProducts[index].get('name_en'),
                              description: allProducts[index].get('description_en'),
                          ),
                        );
                        Navigator.pushNamed(context, '/details_screen');
                      },
                      child:Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black12,width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [

                              Image.network(

                                allProducts[index].get('image'),
                                // width: width / 5.61,
                                height: height / 5.48,
                                fit: BoxFit.cover,

                              ),


                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    Container(
                                      margin: EdgeInsets.all(10),
                                      height: 100,
                                      width: 250,
                                      // color: Colors.black,
                                      child:  Text(
                                        allProducts[index].get('description_en'),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,

                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),


                                  Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child:Padding(
                                            padding: const EdgeInsets.only(left: 10,bottom: 3),
                                            child: RatingBar.builder(
                                              initialRating: allProducts[index].get('rating') ?? 0.0,
                                              minRating: 1,
                                              direction: Axis.horizontal,
                                              allowHalfRating: true,
                                              itemCount: 5,
                                              itemSize: 16,
                                              ignoreGestures: true,
                                              itemPadding: EdgeInsets.symmetric(horizontal: 0.5),
                                              itemBuilder: (context, _) => Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                              ),
                                              onRatingUpdate: (rating) {},
                                            ),
                                          ),
                                        ),
                                      ),
                                      // Spacer(),
                                      SizedBox(width: 120,),
                                      Align(
                                        alignment: AlignmentDirectional.topEnd,
                                        child:Text(
                                          '${allProducts[index].get('price')} \$',
                                          style: const TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),






                                ],

                              ),


                            ],
                          ),
clipBehavior: Clip.antiAlias,
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
                      Icon(Icons.warning, size: 80),
                      Text(
                        'NOT EXIST ANY QUESTION',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                );
              }
            }
            ),
      ),
    );
  }
}


/*
Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: width / 56, vertical: height / 114.8),
                        margin: EdgeInsetsDirectional.only(
                          bottom: height / 53.57,
                          start: width / 78.54,
                          end: width / 78.54,
                        ),
                        height: height / 9.56,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: kElevationToShadow[4],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.network(
                              allProducts[index].get('image'),
                              width: width / 5.61,
                              height: height / 11.48,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(width: width / 32.72),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  allProducts[index].get('description'),
                                  maxLines: 1,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '${allProducts[index].get('price').toString()} KWD',
                                  style: const TextStyle(
                                    color: Color(0xffC99200),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
 */
