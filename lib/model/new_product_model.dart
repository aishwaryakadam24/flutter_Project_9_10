class NewProduct{
  late String  name, image, description,price, productId;

  NewProduct({
    required this.image,
    required this.name,
    required this.description,
    required this.price,
    required this.productId,
  });
  NewProduct.fromJson(Map<dynamic, dynamic> map) {
    name = map['name'];
    image = map['image'];
    description = map['description'];

    price = map['price'];
    productId = map['productId'];

  }
  toJson() {
    return {
      'name': name,
      'image': image,
      'description': description,

      'price': price,
      'productId': productId,
    };
  }

}