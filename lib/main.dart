import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:generalshop/product/product.dart';
import 'api/authentication.dart';
import 'api/products_api.dart';
import 'api/helpers_api.dart';
import 'package:generalshop/product/product_category.dart';
import 'package:generalshop/product/product_tag.dart';
import 'package:generalshop/utility/country.dart';
import 'package:generalshop/utility/country_city.dart';
import 'package:generalshop/utility/country_state.dart';
import 'package:generalshop/exeptions/exeptions.dart';
import 'package:connectivity/connectivity.dart';
void main() {


   runApp(GeneralShop());
}

class GeneralShop extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'General Shop',
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }

}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

 Authentication authentication = Authentication();
 ProductApi productApi = ProductApi();
  HelpersApi helpersApi = HelpersApi();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('General Shop'),
      ),
      body: FutureBuilder(
              future: helpersApi.fetchCategory(2),
              builder: (BuildContext context ,AsyncSnapshot snapshot){
                print(snapshot.data);
                     switch(snapshot.connectionState){
                     case ConnectionState.none:
                         // TODO: Handle this case.
                        return _error('No Thing Happened !!!!');
                         break;
                       case ConnectionState.waiting:
                         // TODO: Handle this case.
                        return _loading();
                         break;
                       case ConnectionState.active:
                         // TODO: Handle this case.
                           return _loading();
                         break;
                       case ConnectionState.done:
                         // TODO: Handle this case.
                         if(snapshot.hasError){

//                           switch(snapshot.error){
//                             case LoginFailed:
//                               return _error('User Name Is Not Correct');
//                               break;
//                             case ResourceNotFound:
//                               return _error('Resource Not Found');
//                               break;
//                           }
                           if(snapshot.error is NoInternetConnection){
                             return _error('No internet');
                           }else{
                             return _error(snapshot.error.toString());
                           }
                          // return _error(snapshot.error.toString());
                         }else{
                           if(!snapshot.hasData){
                             return _error('No Data');
                           }else{

                             return ListView.builder(
                               itemBuilder: (BuildContext context , int pos){

                                 ProductCategory category = snapshot.data[pos];
                                 print(category.image_direction);
                                 if(category.image_direction == 'left'){
                                   return _drawLeftCard(category);
                                 }else{
                                   return _drawRightCard(category);
                                 }

                               },
                               itemCount: snapshot.data.length,
                             );
                           }
                         }
                         break;
                     }
                      return Container(); 
              }),
        
    );
  }


  _drawLeftCard(dynamic item){
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: <Widget>[
//            Flexible(
//              child: Image(
//                  fit: BoxFit.contain,
//                  image: NetworkImage(item.image_url)),
//            ),
            Text('kjhjkhjlhljkljk           '),
            Text(item.category_name),
          ],
        ),
      ),
    );
  }


  _drawRightCard(dynamic item){
     return Card(
         child: Padding(
           padding: EdgeInsets.all(16),
           child: Row(
             children: <Widget>[
               Text(item.category_name),
               Text('         kjhjkhjlhljkljk'),
//               Flexible(
//                 child: Image(
//                     fit: BoxFit.contain,
//                     image: NetworkImage(item.image_url)),
//               )

             ],
           ),
         ),
     );
  }


  _drawProduct(Product product){
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Text(product.product_title),
                (product.images.length>0)?
                Image(
                  image: NetworkImage(product.images[0]),
                ):Container(),
              ],
            ),
          ),
        );
  }

  _error(String error){
    return Container(
      child: Center(
        child: Text(error),
        ),
    );
  }

  _loading(){
    return Container(
      child:Center(
        child: CircularProgressIndicator(),
      ) ,
    );
  }
}

