class Product{
    late String  name, image, description,price, id;

    Product({
      this.id = '0',
      this.image = '',
      this.name = '',
      this.price = '',
      this.description = '',
    });
    Product.fromJson(Map<dynamic, dynamic> map) {
    name = map['name'];
    image = map['image'];
    description = map['description_en'];

    price = map['price'];
    id = map['productId'];
  
  }
    toJson() {
    return {
      'name': name,
      'image': image,
      'description': description,

      'price': price,
      'productId': id,
    };
  }

}