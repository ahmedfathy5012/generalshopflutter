import 'package:flutter/material.dart';
import 'package:generalshop/product/product.dart';
import 'package:generalshop/product/product_category.dart';
import 'utilities/screen_utilities.dart';
import 'utilities/screen_config.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:generalshop/api/helpers_api.dart';
import 'utilities/helpers_widgets.dart';
import 'package:generalshop/product/home_product.dart';
import 'utilities/helpers_widgets.dart';



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>with TickerProviderStateMixin{
  TabController tabController;
  int currentIndex = 0;

  
  List<ProductCategory> productsCategories;


  ScreenConfig screenConfig;
  WidgetSize widgetSize;
  HelpersApi helpersApi = HelpersApi();
  HomeProductBlock homeProductBlock = HomeProductBlock();

  @override
  void initState() {
    // TODO: implement initState
    
    super.initState();

                
  }

  @override
  void dispose() {
    // TODO: implement dispose
    tabController.dispose();
    homeProductBlock.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenConfig = ScreenConfig(context);
    widgetSize   = WidgetSize(screenConfig);

    return FutureBuilder(
     future: helpersApi.fetchCategories(),
     builder: (BuildContext context,AsyncSnapshot<List<ProductCategory>> snapshot){
       switch (snapshot.connectionState) {
         case ConnectionState.none:
            return HelperWidgets().error('No Connection Madde');
           break;
        case ConnectionState.waiting:
        case ConnectionState.active:
           return HelperWidgets().loading();
           break;
        case ConnectionState.done:
           if(snapshot.hasError){
             return HelperWidgets().error(snapshot.error);
           }else{
             if(!snapshot.hasData){
               return HelperWidgets().error('No Data');
             }else{
              this.productsCategories = snapshot.data;
              homeProductBlock.fetchProducts.add(productsCategories[0].category_id);
               return _screen(snapshot.data);
             }
           }
           break;         
         default:
       }
       return Container();
     },
    );

  }

  Widget _screen(List<ProductCategory> categories){
       tabController=TabController(
                 initialIndex: 0,
                 length:categories.length,
                 vsync: this
                );
    return Scaffold(
      appBar: AppBar(
         centerTitle: true,       
        title: Text('Home',
        ),

        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(icon:Icon(Icons.search),
            onPressed: (){},
            ),
          ),
        ],

        bottom: TabBar(
          indicatorColor: ScreenUtilties.mainBlue,
          controller: tabController,
          isScrollable: true,
          tabs: _tabs(categories),
          onTap: (int index){
            homeProductBlock.fetchProducts.add(this.productsCategories[index].category_id);
          },
        ),
      ),


      body: Container(
        child: StreamBuilder(
           stream: homeProductBlock.productsStrem,
           builder: (BuildContext context , AsyncSnapshot<List<Product>> snapshot){
             switch(snapshot.connectionState){
               
               case ConnectionState.none:
                 // TODO: Handle this case.
                return HelperWidgets().error('No Thing Is Working');
                 break;
               case ConnectionState.waiting:               
                 // TODO: Handle this case.
                return HelperWidgets().loading();
                 break;                                
               case ConnectionState.done:
               case ConnectionState.active:
                 // TODO: Handle this case.
                 if(snapshot.hasError){
                   return HelperWidgets().error(snapshot.error.toString());
                 }else{
                   if(!snapshot.hasData){
                     return HelperWidgets().error('No Data');
                   }else{
                     return _drawProducts(snapshot.data);
                   }
                 }
                 break;
             }
             return Container();
           },
        ),
      ),
    );
  }



  Widget _drawProducts(List<Product> products)  {
     return  Container(
       child: Column(
         children: <Widget>[
           
               Flexible(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                 itemCount: products.length,
                 itemBuilder: (context , position){
                   return Card(
                     child: Container(
                     child: Image(image: NetworkImage(products[position].featuredImage()),), 
                  //  child: Image(image: NetworkImage('https://lorempixel.com/1000/600/?46119')), 
                 //  child: Text(products[position].product_title),
                     ),
                   );
                 },
             ),
               ),
           
         ],
       ),
     );
  }

  List<Tab> _tabs(List<ProductCategory> categories){
     List<Tab> tabs = [];
     for (var category in categories) {
       tabs.add(
         Tab(
           text: category.category_name,
         )
       );
     }
     return tabs;
  }
}
