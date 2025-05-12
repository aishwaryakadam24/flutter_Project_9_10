import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/book.dart';

class FbBooksController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'books';

  Future<List<Book>> getBooks() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection(_collection).get();
      return querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        return Book.fromJson(data);
      }).toList();
    } catch (e) {
      print('Error getting books: $e');
      return [];
    }
  }

  Future<List<Book>> getNewBooks() async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection(_collection)
          .where('isNew', isEqualTo: true)
          .limit(5)
          .get();
      return querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        return Book.fromJson(data);
      }).toList();
    } catch (e) {
      print('Error getting new books: $e');
      return [];
    }
  }

  Future<List<Book>> getBestSellers() async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection(_collection)
          .where('isBestSeller', isEqualTo: true)
          .limit(5)
          .get();
      return querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        return Book.fromJson(data);
      }).toList();
    } catch (e) {
      print('Error getting best sellers: $e');
      return [];
    }
  }

  Future<List<Book>> getBooksByCategory(String category) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection(_collection)
          .where('category', isEqualTo: category)
          .get();
      return querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        return Book.fromJson(data);
      }).toList();
    } catch (e) {
      print('Error getting books by category: $e');
      return [];
    }
  }

  Future<Book?> getBookById(String id) async {
    try {
      DocumentSnapshot doc = await _firestore.collection(_collection).doc(id).get();
      if (doc.exists) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        return Book.fromJson(data);
      }
      return null;
    } catch (e) {
      print('Error getting book by id: $e');
      return null;
    }
  }

  Future<bool> addBook(Book book) async {
    try {
      await _firestore.collection(_collection).add(book.toJson());
      return true;
    } catch (e) {
      print('Error adding book: $e');
      return false;
    }
  }

  Future<bool> updateBook(Book book) async {
    try {
      await _firestore.collection(_collection).doc(book.id).update(book.toJson());
      return true;
    } catch (e) {
      print('Error updating book: $e');
      return false;
    }
  }

  Future<bool> deleteBook(String id) async {
    try {
      await _firestore.collection(_collection).doc(id).delete();
      return true;
    } catch (e) {
      print('Error deleting book: $e');
      return false;
    }
  }

  Future<bool> migrateRatings() async {
    try {
      final QuerySnapshot books = await _firestore.collection(_collection).get();

      // Process in batches of 500 (Firestore limit)
      for (int i = 0; i < books.docs.length; i += 500) {
        final batch = _firestore.batch();
        final chunk = books.docs.sublist(
          i, 
          i + 500 > books.docs.length ? books.docs.length : i + 500
        );

        for (final doc in chunk) {
          final data = doc.data() as Map<String, dynamic>;
          if (data.containsKey('ratting')) {
            batch.update(doc.reference, {
              'rating': data['ratting'],  // Copy value to new field
              'ratting': FieldValue.delete(), // Remove old field
            });
          }
        }
        await batch.commit();
        print('Migrated ${chunk.length} books (batch ${i ~/ 500 + 1})');
      }
      print('✅ Success! Migrated all books to use "rating"');
      return true;
    } catch (e) {
      print('Error migrating ratings: $e');
      return false;
    }
  }

  Future<void> addBooks(List<Book> books) async {
    for (var book in books) {
      await addBook(book);
    }
  }
}