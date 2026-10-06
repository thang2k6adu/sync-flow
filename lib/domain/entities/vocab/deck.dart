class Deck {
  final String id;
  final String? userId;
  final String name;
  final String? description;
  final String? category;
  final String? iconUrl;
  final String? cefrLevel;
  final DateTime? createdAt;

  const Deck({
    required this.id,
    this.userId,
    required this.name,
    this.description,
    this.category,
    this.iconUrl,
    this.cefrLevel,
    this.createdAt,
  });
}
