import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../model/products_model.dart';
import '../model/user_model.dart';
import '../shared_preferences/user_preferences_controler.dart';

class FbFireStoreController {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  // Books Collection Methods
  Stream<QuerySnapshot> getProducts() async* {
    yield* _firebaseFirestore.collection('books').snapshots();
  }

  Stream<QuerySnapshot> getNewProducts() async* {
    yield* _firebaseFirestore.collection('new-books').snapshots();
  }

  Future<bool> addBook({
    required String title,
    required String author,
    required String description,
    required String price,
    required String image,
    required String category,
    required int stock,
  }) async {
    try {
      await _firebaseFirestore.collection('books').add({
        'title': title,
        'author': author,
        'description': description,
        'price': price,
        'image': image,
        'category': category,
        'stock': stock,
        'createdAt': FieldValue.serverTimestamp(),
      });
      return true;
    } catch (e) {
      debugPrint('Error adding book: $e');
      return false;
    }
  }

  Future<bool> updateBook({
    required String bookId,
    required Map<String, dynamic> data,
  }) async {
    try {
      await _firebaseFirestore.collection('books').doc(bookId).update(data);
      return true;
    } catch (e) {
      debugPrint('Error updating book: $e');
      return false;
    }
  }

  Future<bool> deleteBook(String bookId) async {
    try {
      await _firebaseFirestore.collection('books').doc(bookId).delete();
      return true;
    } catch (e) {
      debugPrint('Error deleting book: $e');
      return false;
    }
  }

  // User Collection Methods
  Future<Users> readUser({required String id}) async {
    return await _firebaseFirestore
        .collection('users')
        .where('id', isEqualTo: id)
        .get()
        .then((value) {
      Users user = Users();
      user.id = value.docs.first.get('id');
      user.name = value.docs.first.get('name');
      user.email = value.docs.first.get('email');
      return user;
    }, onError: (e) {
      return Users();
    });
  }

  Future<bool> updateUser({required BuildContext context, required Users user}) async {
    bool secondUpdate = await _firebaseFirestore
        .collection('users')
        .doc(user.id)
        .update(user.toMap())
        .then((value) => true)
        .catchError((error) => false);

    bool result = secondUpdate;
    Users users = Users();
    if (result) {
      UserPreferenceController().saveUsers(
        users: users,
        email: user.email,
        name: users.name,
      );
    }

    return result;
  }

  // Cart Collection Methods
  Future<bool> addProductToCart({required String productId, required String userId}) async {
    Map<String, dynamic> cart = <String, dynamic>{};
    cart['productId'] = productId;
    cart['userId'] = userId;
    cart['quantity'] = 1;
    cart['addedAt'] = FieldValue.serverTimestamp();
    
    return await _firebaseFirestore
        .collection('Carts')
        .add(cart)
        .then((value) => true)
        .catchError((error) => false);
  }

  Future<List<Product>> getProductsCart({required String? userId}) async {
    List<Product> products = [];
    return await _firebaseFirestore
        .collection('Carts')
        .where('userId', isEqualTo: userId)
        .get()
        .then((value) async {
      for (var element in value.docs) {
        products.add(await getProduct(element.get('productId')));
      }
      return products;
    }, onError: (e) {
      return products;
    });
  }

  Future<Product> getProduct(String productId) async {
    Product product = Product(id: '', image: '', name: '', price: '');
    return await _firebaseFirestore.collection('books').doc(productId).get().then(
        (value) {
      product = Product(
        id: productId,
        image: value.get('image'),
        name: value.get('title'),
        price: value.get('price'),
      );
      return product;
    }, onError: (e) {
      return product;
    });
  }

  Future<bool> deleteCart(String productId, String userId) async {
    return await _firebaseFirestore.collection('Carts').get().then((value) {
      for (DocumentSnapshot doc in value.docs) {
        if (doc.get('productId') == productId && doc.get('userId') == userId) {
          doc.reference.delete();
        }
      }
      return true;
    }, onError: (exception) {
      return false;
    });
  }

  // Order Collection Methods
  Future<bool> createOrder({
    required String userId,
    required List<Map<String, dynamic>> items,
    required double totalAmount,
    required String status,
  }) async {
    try {
      await _firebaseFirestore.collection('orders').add({
        'userId': userId,
        'items': items,
        'totalAmount': totalAmount,
        'status': status,
        'createdAt': FieldValue.serverTimestamp(),
      });
      return true;
    } catch (e) {
      debugPrint('Error creating order: $e');
      return false;
    }
  }

  Stream<QuerySnapshot> getUserOrders(String userId) {
    return _firebaseFirestore
        .collection('orders')
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  // Category Collection Methods
  Future<List<String>> getCategories() async {
    try {
      QuerySnapshot snapshot = await _firebaseFirestore.collection('categories').get();
      return snapshot.docs.map((doc) => doc.get('name') as String).toList();
    } catch (e) {
      debugPrint('Error getting categories: $e');
      return [];
    }
  }

  // Wishlist Collection Methods
  Future<bool> addToWishlist({required String productId, required String userId}) async {
    Map<String, dynamic> wishlist = <String, dynamic>{};
    wishlist['productId'] = productId;
    wishlist['userId'] = userId;
    wishlist['addedAt'] = FieldValue.serverTimestamp();
    
    return await _firebaseFirestore
        .collection('Wishlist')
        .add(wishlist)
        .then((value) => true)
        .catchError((error) => false);
  }

  Future<List<Product>> getWishlistItems({required String? userId}) async {
    List<Product> products = [];
    return await _firebaseFirestore
        .collection('Wishlist')
        .where('userId', isEqualTo: userId)
        .get()
        .then((value) async {
      for (var element in value.docs) {
        products.add(await getProduct(element.get('productId')));
      }
      return products;
    }, onError: (e) {
      return products;
    });
  }

  Future<bool> removeFromWishlist({required String productId, required String userId}) async {
    return await _firebaseFirestore.collection('Wishlist').get().then((value) {
      for (DocumentSnapshot doc in value.docs) {
        if (doc.get('productId') == productId && doc.get('userId') == userId) {
          doc.reference.delete();
        }
      }
      return true;
    }, onError: (exception) {
      return false;
    });
  }

  // Search Method
  Future<List<Product>> searchProducts(String query) async {
    List<Product> products = [];
    try {
      QuerySnapshot snapshot = await _firebaseFirestore
          .collection('books')
          .where('name_en', isGreaterThanOrEqualTo: query)
          .where('name_en', isLessThanOrEqualTo: query + '\uf8ff')
          .get();

      for (var doc in snapshot.docs) {
        products.add(Product(
          id: doc.id,
          name: doc.get('name_en'),
          image: doc.get('image'),
          price: doc.get('price'),
          description: doc.get('description_en'),
        ));
      }
    } catch (e) {
      debugPrint('Error searching products: $e');
    }
    return products;
  }

  // Category Filter Method
  Stream<QuerySnapshot> getProductsByCategory(String category) {
    return _firebaseFirestore
        .collection('books')
        .where('category', isEqualTo: category)
        .snapshots();
  }
}