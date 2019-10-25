
import 'package:generalshop/product/product.dart';

class CartItem{
Product product;
double qty;
CartItem(this.product,this.qty);
CartItem.fromJson(Map<String,dynamic> jsonObject){
  this.product = Product.fromJson(jsonObject['product']);
  this.qty = jsonObject['qty'];
}
}


class Cart{
List<CartItem> cartItems;
int id;
double total;
Cart(this.cartItems,this.id,this.total);
Cart.fromJson(Map<String,dynamic> jsonObject){
cartItems = [];
var items = jsonObject['cart_item'];
for(var item in items){
cartItems.add(CartItem.fromJson(item));
}
this.id = jsonObject['id'];
this.total = jsonObject['total'];

}
}