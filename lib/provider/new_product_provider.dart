import 'package:flutter/cupertino.dart';

import '../model/new_product_model.dart';
import '../model/products_model.dart';


class NewProductProvider extends ChangeNotifier{
  late NewProduct _newProduct;

  NewProduct get nProduct => _newProduct;

  void changeProduct({required NewProduct newProduct}){
    _newProduct = nProduct;
    notifyListeners();
  }
}