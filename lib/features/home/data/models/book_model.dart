class Book {
  final int id;
  final String name;
  final String author;
  String cover; // Make cover mutable
  final String description;
  final double price;
  final int sales;
  final String slug;
  final int categoryId; // Add this field


  Book({
    required this.id,
    required this.name,
    required this.author,
    required this.cover,
    required this.description,
    required this.price,
    required this.sales,
    required this.slug,
    required this.categoryId, // Add this parameter

  });

  // JSON'dan User nesnesine dönüşüm
  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      name: json['name'],
      author: json['author'],
      cover: json['cover'],
      description: json['description'],
      price: json['price'].toDouble(),
      sales: json['sales'],
      slug: json['slug'],
      categoryId: (json['category_id'] ?? 0) as int, // Ensure non-null
    );
  }
}