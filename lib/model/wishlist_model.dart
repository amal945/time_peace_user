class Wishlist {
  final String id;
  final String productId;
  final String email;

  Wishlist({
    required this.id,
    required this.productId,
    required this.email,
  });

  factory Wishlist.fromMap(Map<String, dynamic> map, String id) {
    return Wishlist(id: id, productId: map["id"], email: map["email"]);
  }
}


