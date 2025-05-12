import 'package:cloud_firestore/cloud_firestore.dart';
import 'fb_controller/fb_books_controller.dart';
import 'models/book.dart';

class FirebaseSeeder {
  static Future<void> seedData() async {
    final FbBooksController booksController = FbBooksController();

    final List<Book> initialBooks = [
      Book(
        id: '1',
        title: 'The Great Gatsby',
        author: 'F. Scott Fitzgerald',
        description: 'A story of the fabulously wealthy Jay Gatsby and his love for the beautiful Daisy Buchanan.',
        coverImage: 'https://example.com/gatsby.jpg',
        price: 12.99,
        rating: 4.5,
        category: 'Fiction',
        isBestSeller: true,
      ),
      Book(
        id: '2',
        title: 'To Kill a Mockingbird',
        author: 'Harper Lee',
        description: 'The story of racial injustice and the loss of innocence in the American South.',
        coverImage: 'https://example.com/mockingbird.jpg',
        price: 14.99,
        rating: 4.8,
        category: 'Fiction',
        isBestSeller: true,
      ),
      Book(
        id: '3',
        title: '1984',
        author: 'George Orwell',
        description: 'A dystopian social science fiction novel and cautionary tale.',
        coverImage: 'https://example.com/1984.jpg',
        price: 11.99,
        rating: 4.6,
        category: 'Science Fiction',
        isNew: true,
      ),
      Book(
        id: '4',
        title: 'The Hobbit',
        author: 'J.R.R. Tolkien',
        description: 'A fantasy novel and children\'s book by English author J. R. R. Tolkien.',
        coverImage: 'https://example.com/hobbit.jpg',
        price: 15.99,
        rating: 4.7,
        category: 'Fantasy',
        isBestSeller: true,
      ),
      Book(
        id: '5',
        title: 'Pride and Prejudice',
        author: 'Jane Austen',
        description: 'A romantic novel of manners written by Jane Austen.',
        coverImage: 'https://example.com/pride.jpg',
        price: 9.99,
        rating: 4.4,
        category: 'Romance',
        isNew: true,
      ),
    ];

    try {
      await booksController.addBooks(initialBooks);
      print('Books seeded successfully!');
    } catch (e) {
      print('Error seeding books: $e');
    }
  }
}

Future<void> seedFirestore() async {
  final firestore = FirebaseFirestore.instance;

  // --- BOOKS ---
  final bookRefs = await Future.wait([
    firestore.collection('books').add({
      'name_en': 'The Great Gatsby',
      'name_ar': '',
      'description_en': 'A classic novel set in the 1920s.',
      'description_ar': '',
      'price': '19.99',
      'image': 'https://covers.openlibrary.org/b/id/7222246-L.jpg',
      'rating': 4.5,
      'category': 'Fiction',
      'stock': 10,
      'createdAt': FieldValue.serverTimestamp(),
    }),
    firestore.collection('books').add({
      'name_en': '1984',
      'name_ar': '',
      'description_en': 'A famous science fiction novel by George Orwell.',
      'description_ar': '',
      'price': '15.50',
      'image': 'https://covers.openlibrary.org/b/id/153541-L.jpg',
      'rating': 4.7,
      'category': 'Science Fiction',
      'stock': 7,
      'createdAt': FieldValue.serverTimestamp(),
    }),
    firestore.collection('books').add({
      'name_en': 'To Kill a Mockingbird',
      'name_ar': '',
      'description_en': 'A novel about justice by Harper Lee.',
      'description_ar': '',
      'price': '18.00',
      'image': 'https://covers.openlibrary.org/b/id/8228691-L.jpg',
      'rating': 4.8,
      'category': 'Classic',
      'stock': 12,
      'createdAt': FieldValue.serverTimestamp(),
    }),
    firestore.collection('books').add({
      'name_en': 'Pride and Prejudice',
      'name_ar': '',
      'description_en': 'A romantic novel by Jane Austen.',
      'description_ar': '',
      'price': '17.00',
      'image': 'https://covers.openlibrary.org/b/id/8091016-L.jpg',
      'rating': 4.6,
      'category': 'Romance',
      'stock': 8,
      'createdAt': FieldValue.serverTimestamp(),
    }),
    firestore.collection('books').add({
      'name_en': 'Moby Dick',
      'name_ar': '',
      'description_en': 'A story about a big whale by Herman Melville.',
      'description_ar': '',
      'price': '20.00',
      'image': 'https://covers.openlibrary.org/b/id/7222276-L.jpg',
      'rating': 4.2,
      'category': 'Adventure',
      'stock': 6,
      'createdAt': FieldValue.serverTimestamp(),
    }),
    firestore.collection('books').add({
      'name_en': 'The Hobbit',
      'name_ar': '',
      'description_en': 'A fantasy adventure by J.R.R. Tolkien.',
      'description_ar': '',
      'price': '22.00',
      'image': 'https://covers.openlibrary.org/b/id/6979861-L.jpg',
      'rating': 4.9,
      'category': 'Fantasy',
      'stock': 9,
      'createdAt': FieldValue.serverTimestamp(),
    }),
    firestore.collection('books').add({
      'name_en': 'The Catcher in the Rye',
      'name_ar': '',
      'description_en': 'A story about a young man by J.D. Salinger.',
      'description_ar': '',
      'price': '16.00',
      'image': 'https://covers.openlibrary.org/b/id/8231856-L.jpg',
      'rating': 4.1,
      'category': 'Fiction',
      'stock': 11,
      'createdAt': FieldValue.serverTimestamp(),
    }),
    firestore.collection('books').add({
      'name_en': 'Brave New World',
      'name_ar': '',
      'description_en': 'A futuristic novel by Aldous Huxley.',
      'description_ar': '',
      'price': '21.00',
      'image': 'https://covers.openlibrary.org/b/id/8775116-L.jpg',
      'rating': 4.3,
      'category': 'Science Fiction',
      'stock': 5,
      'createdAt': FieldValue.serverTimestamp(),
    }),
    firestore.collection('books').add({
      'name_en': 'Jane Eyre',
      'name_ar': '',
      'description_en': 'A classic love story by Charlotte Brontë.',
      'description_ar': '',
      'price': '19.00',
      'image': 'https://covers.openlibrary.org/b/id/8225631-L.jpg',
      'rating': 4.4,
      'category': 'Classic',
      'stock': 7,
      'createdAt': FieldValue.serverTimestamp(),
    }),
    firestore.collection('books').add({
      'name_en': 'Animal Farm',
      'name_ar': '',
      'description_en': 'A story about animals by George Orwell.',
      'description_ar': '',
      'price': '14.00',
      'image': 'https://covers.openlibrary.org/b/id/153547-L.jpg',
      'rating': 4.0,
      'category': 'Satire',
      'stock': 10,
      'createdAt': FieldValue.serverTimestamp(),
    }),
    firestore.collection('books').add({
      'name_en': 'Wings of Fire',
      'name_ar': '',
      'description_en': 'Autobiography of Dr. A.P.J. Abdul Kalam.',
      'description_ar': '',
      'price': '12.00',
      'image': 'https://covers.openlibrary.org/b/id/10521213-L.jpg',
      'rating': 4.8,
      'category': 'Biography',
      'stock': 15,
      'createdAt': FieldValue.serverTimestamp(),
    }),
    firestore.collection('books').add({
      'name_en': 'The White Tiger',
      'name_ar': '',
      'description_en': 'A novel by Aravind Adiga.',
      'description_ar': '',
      'price': '10.00',
      'image': 'https://covers.openlibrary.org/b/id/10521214-L.jpg',
      'rating': 4.2,
      'category': 'Fiction',
      'stock': 10,
      'createdAt': FieldValue.serverTimestamp(),
    }),
    firestore.collection('books').add({
      'name_en': 'The Alchemist',
      'name_ar': '',
      'description_en': 'A novel by Paulo Coelho.',
      'description_ar': '',
      'price': '13.00',
      'image': 'https://covers.openlibrary.org/b/id/10521215-L.jpg',
      'rating': 4.6,
      'category': 'Adventure',
      'stock': 12,
      'createdAt': FieldValue.serverTimestamp(),
    }),
    firestore.collection('books').add({
      'name_en': 'Half Girlfriend',
      'name_ar': '',
      'description_en': 'A novel by Chetan Bhagat.',
      'description_ar': '',
      'price': '11.00',
      'image': 'https://covers.openlibrary.org/b/id/10521216-L.jpg',
      'rating': 4.0,
      'category': 'Romance',
      'stock': 8,
      'createdAt': FieldValue.serverTimestamp(),
    }),
    firestore.collection('books').add({
      'name_en': 'Five Point Someone',
      'name_ar': '',
      'description_en': 'A novel by Chetan Bhagat.',
      'description_ar': '',
      'price': '10.00',
      'image': 'https://covers.openlibrary.org/b/id/10521217-L.jpg',
      'rating': 4.1,
      'category': 'Fiction',
      'stock': 9,
      'createdAt': FieldValue.serverTimestamp(),
    }),
    firestore.collection('books').add({
      'name_en': 'The Guide',
      'name_ar': '',
      'description_en': 'A novel by R.K. Narayan.',
      'description_ar': '',
      'price': '12.00',
      'image': 'https://covers.openlibrary.org/b/id/10521218-L.jpg',
      'rating': 4.3,
      'category': 'Classic',
      'stock': 7,
      'createdAt': FieldValue.serverTimestamp(),
    }),
  ]);

  // --- NEW BOOKS ---
  await firestore.collection('new-books').add({
    'name_en': 'Flutter for Beginners',
    'name_ar': '',
    'description_en': 'A complete guide to learning Flutter.',
    'description_ar': '',
    'price': '25.00',
    'image': 'https://covers.openlibrary.org/b/id/10521213-L.jpg',
    'rating': 4.9,
    'category': 'Programming',
    'stock': 5,
    'createdAt': FieldValue.serverTimestamp(),
  });

  // --- USERS ---
  await Future.wait([
    firestore.collection('users').add({
      'id': 'user123',
      'name': 'Alice Smith',
      'email': 'alice@email.com',
    }),
    firestore.collection('users').add({
      'id': 'user456',
      'name': 'Bob Johnson',
      'email': 'bob@email.com',
    }),
  ]);

  // --- CARTS ---
  await firestore.collection('Carts').add({
    'productId': bookRefs[0].id,
    'userId': 'user123',
    'quantity': 1,
    'addedAt': FieldValue.serverTimestamp(),
  });
  await firestore.collection('Carts').add({
    'productId': bookRefs[1].id,
    'userId': 'user456',
    'quantity': 2,
    'addedAt': FieldValue.serverTimestamp(),
  });

  // --- ORDERS ---
  await firestore.collection('orders').add({
    'userId': 'user123',
    'items': [
      {
        'bookId': bookRefs[0].id,
        'quantity': 1,
        'price': '19.99',
      },
      {
        'bookId': bookRefs[2].id,
        'quantity': 1,
        'price': '18.00',
      }
    ],
    'totalAmount': 37.99,
    'status': 'pending',
    'createdAt': FieldValue.serverTimestamp(),
  });

  // --- CATEGORIES ---
  await Future.wait([
    firestore.collection('categories').add({'name': 'Fiction'}),
    firestore.collection('categories').add({'name': 'Science Fiction'}),
    firestore.collection('categories').add({'name': 'Classic'}),
    firestore.collection('categories').add({'name': 'Programming'}),
    firestore.collection('categories').add({'name': 'Romance'}),
    firestore.collection('categories').add({'name': 'Adventure'}),
    firestore.collection('categories').add({'name': 'Fantasy'}),
    firestore.collection('categories').add({'name': 'Satire'}),
    firestore.collection('categories').add({'name': 'Biography'}),
  ]);

  print('Firestore seeded with 15 famous books!');
}

Future<void> seedBooks() async {
  final FbBooksController booksController = FbBooksController();
  
  final List<Book> initialBooks = [
    Book(
      id: '1',
      title: 'The Great Gatsby',
      author: 'F. Scott Fitzgerald',
      description: 'A story of the fabulously wealthy Jay Gatsby and his love for the beautiful Daisy Buchanan.',
      coverImage: 'images/books/great_gatsby.jpg',
      price: 12.99,
      category: 'Fiction',
      rating: 4.5,
      isBestSeller: true,
    ),
    Book(
      id: '2',
      title: 'To Kill a Mockingbird',
      author: 'Harper Lee',
      description: 'The story of racial injustice and the loss of innocence in the American South.',
      coverImage: 'images/books/mockingbird.jpg',
      price: 14.99,
      category: 'Fiction',
      rating: 4.8,
      isBestSeller: true,
    ),
    Book(
      id: '3',
      title: '1984',
      author: 'George Orwell',
      description: 'A dystopian novel set in a totalitarian society where critical thought is suppressed.',
      coverImage: 'images/books/1984.jpg',
      price: 11.99,
      category: 'Science Fiction',
      rating: 4.6,
      isBestSeller: true,
    ),
    Book(
      id: '4',
      title: 'The Hobbit',
      author: 'J.R.R. Tolkien',
      description: 'A fantasy novel about the adventures of Bilbo Baggins, a hobbit who embarks on an epic quest.',
      coverImage: 'images/books/hobbit.jpg',
      price: 15.99,
      category: 'Fantasy',
      rating: 4.7,
      isBestSeller: true,
    ),
    Book(
      id: '5',
      title: 'Pride and Prejudice',
      author: 'Jane Austen',
      description: 'A romantic novel of manners that follows the character development of Elizabeth Bennet.',
      coverImage: 'images/books/pride_prejudice.jpg',
      price: 9.99,
      category: 'Romance',
      rating: 4.4,
      isBestSeller: true,
    ),
  ];

  for (var book in initialBooks) {
    await booksController.addBook(book);
  }
} 