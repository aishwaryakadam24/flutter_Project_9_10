import 'package:flutter/cupertino.dart';

import '../model/products_model.dart';


class ProductProvider extends ChangeNotifier{
  late Product _product;

  Product get product => _product;

  void changeProduct({required Product product}){
    _product = product;
    notifyListeners();
  }
}