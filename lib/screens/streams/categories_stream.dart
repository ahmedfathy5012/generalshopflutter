import 'dart:async';

import 'package:generalshop/contracts/contracts.dart';
import 'package:generalshop/product/product_category.dart';
import 'package:generalshop/api/helpers_api.dart';


class CategoriesStream implements Disposable{
  HelpersApi helpersApi = HelpersApi();

  List<ProductCategory> categories;
  StreamController<List<ProductCategory>> _categoriesStream = StreamController<List<ProductCategory>>.broadcast();
  Stream<List<ProductCategory>> get categoriesStream => _categoriesStream.stream; 
  StreamSink<List<ProductCategory>> get categoriesSink => _categoriesStream.sink;

  CategoriesStream(){
    
    categories = [];
    _categoriesStream.add(categories);
    
    _categoriesStream.stream.listen(_fetchCategories);
  }


  Future<void> _fetchCategories(List<ProductCategory> categories) async{
    print('before api call');
     this.categories = await helpersApi.fetchCategories();
     _categoriesStream.add(this.categories);
     //print(categories.length);
  }


  @override
  void dispose() {
    // TODO: implement dispose
    _categoriesStream.close();
  }

}