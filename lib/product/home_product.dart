import 'dart:async';

import 'package:generalshop/product/product.dart';

import 'package:generalshop/contracts/contracts.dart';

import 'package:generalshop/api/products_api.dart';


class HomeProductBlock implements Disposable{

ProductApi productApi;

List<Product> products;

final StreamController<List<Product>> _productController = StreamController<List<Product>>.broadcast();    // enter point
final StreamController<int> _categoryController = StreamController<int>.broadcast();                      // first enter point category_id


Stream<List<Product>> get productsStrem => _productController.stream;    // output list of products belong to category_id
  
StreamSink<int> get fetchProducts => _categoryController.sink;      // input category id   // نقطة الادخال 
Stream<int> get category => _categoryController.stream;


int categoryID;

HomeProductBlock(){
  this.products = [];
  productApi = ProductApi();
  _productController.add(this.products);
  _categoryController.add(this.categoryID);
  _categoryController.stream.listen(_fetchCategoryFromApi);
}



Future<void> _fetchCategoryFromApi(int category)async{
  //Api
  this.products = await productApi.fetchProductsByCategory(category,1);
  //Update Products List
  _productController.add(this.products);
}

  @override
  void dispose() {
    // TODO: implement dispose
    _productController.close();
    _categoryController.close();
  }

}