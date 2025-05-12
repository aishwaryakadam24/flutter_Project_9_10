class Book {
  final String id;
  final String title;
  final String author;
  final String description;
  final String coverImage;
  final double price;
  final double rating;
  final String category;
  final bool isNew;
  final bool isBestSeller;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.description,
    required this.coverImage,
    required this.price,
    required this.rating,
    required this.category,
    this.isNew = false,
    this.isBestSeller = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'description': description,
      'coverImage': coverImage,
      'price': price,
      'rating': rating,
      'category': category,
      'isNew': isNew,
      'isBestSeller': isBestSeller,
    };
  }

  factory Book.fromJson(Map<String, dynamic> map) {
    return Book(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      author: map['author'] ?? '',
      description: map['description'] ?? '',
      coverImage: map['coverImage'] ?? '',
      price: (map['price'] ?? 0.0).toDouble(),
      rating: (map['rating'] ?? 0.0).toDouble(),
      category: map['category'] ?? '',
      isNew: map['isNew'] ?? false,
      isBestSeller: map['isBestSeller'] ?? false,
    );
  }
} 