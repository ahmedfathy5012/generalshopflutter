import 'package:flutter/material.dart';
import 'package:generalshop/api/cart_api.dart';
import 'package:generalshop/cart/cart.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  CartApi cartApi = CartApi();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        centerTitle: true,
      ),

      body: FutureBuilder(
        future: cartApi.fetchcart(),
        builder: (BuildContext context , AsyncSnapshot<Cart> snapshot){
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
            case ConnectionState.active:
              return Center(child: CircularProgressIndicator(),);
            break;
            case ConnectionState.done:
              if(snapshot.hasError){
                return Text('Error');
              }else{
                if(snapshot.hasData){
                  return ListView.builder(
                    itemCount: snapshot.data.cartItems.length,
                   itemBuilder: (BuildContext context , int position){
                     return ListTile(
                       title: Text(snapshot.data.cartItems[position].product.product_title),
                       trailing: Text(snapshot.data.cartItems[position].qty.toString()),
                     );
                   },
                  );
                }else{
                  return Text('No Data');
                }
              }
            break;  
            default:
              return Container();
            break;  
          }
          return Container();
        },
      ),
    );
  }
}