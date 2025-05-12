import 'package:flutter/foundation.dart';
import '../models/book.dart';
import '../fb_controller/fb_books_controller.dart';

class BookProvider extends ChangeNotifier {
  final FbBooksController _booksController = FbBooksController();
  List<Book> _books = [];
  List<Book> _newBooks = [];
  List<Book> _bestSellers = [];
  bool _isLoading = false;
  String? _error;

  List<Book> get books => _books;
  List<Book> get newBooks => _newBooks;
  List<Book> get bestSellers => _bestSellers;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadBooks() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _books = await _booksController.getBooks();
      _newBooks = await _booksController.getNewBooks();
      _bestSellers = await _booksController.getBestSellers();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadBooksByCategory(String category) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _books = await _booksController.getBooksByCategory(category);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> addBook(Book book) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      bool success = await _booksController.addBook(book);
      if (success) {
        await loadBooks();
      }
      return success;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> updateBook(Book book) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      bool success = await _booksController.updateBook(book);
      if (success) {
        await loadBooks();
      }
      return success;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> deleteBook(String id) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      bool success = await _booksController.deleteBook(id);
      if (success) {
        await loadBooks();
      }
      return success;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
} 