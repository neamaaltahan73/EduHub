class CartItemModel {
  final int id;
  final String image;
  final String title;
  final String instructor;
  final double price;

  const CartItemModel({
    this.id = -1,
    required this.image,
    required this.title,
    required this.instructor,
    required this.price,
  });
}
