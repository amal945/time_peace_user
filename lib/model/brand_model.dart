class Brand {
  final String id;
  final String brandLogo;
  final String brandName;

  Brand({required this.id, required this.brandLogo, required this.brandName});
  factory Brand.fromMap(Map<String, dynamic> map, String id) {
    return Brand(
      id: id,
      brandLogo: map["brandLogo"],
      brandName: map["brandName"],
    );
  }
  Map<String, dynamic> toMap() {
    return {brandLogo: "brandLogo", brandName: "brandName"};
  }
}