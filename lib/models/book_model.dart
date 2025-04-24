class Book {
  final int id;
  final String name;
  final String author;
  String cover; // Make cover mutable
  final String description;
  final double price;
  final int sales;
  final String slug;

  Book({
    required this.id,
    required this.name,
    required this.author,
    required this.cover,
    required this.description,
    required this.price,
    required this.sales,
    required this.slug,
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
    );
  }
}