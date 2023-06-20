class Dish {
  Dish(
      {required this.id,
      required this.name,
      required this.price,
      required this.weight,
      required this.description,
      required this.imageUrl,
      required this.tags});
  final int id;
  final String name;
  final int price;
  final int weight;
  final String description;
  final String imageUrl;
  final List<String> tags;
}
