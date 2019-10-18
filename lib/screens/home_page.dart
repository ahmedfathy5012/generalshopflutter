import 'package:flutter/material.dart';
import 'package:generalshop/product/product.dart';
import 'package:generalshop/product/product_category.dart';
import 'package:generalshop/screens/streams/categories_stream.dart';
import 'utilities/screen_utilities.dart';
import 'utilities/screen_config.dart';
import 'package:generalshop/api/helpers_api.dart';
import 'utilities/helpers_widgets.dart';
import 'package:generalshop/product/home_product.dart';
import 'utilities/helpers_widgets.dart';
import 'dart:math';
import 'single_product.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>with TickerProviderStateMixin{
  TabController tabController;
  PageController _pageController;

  int currentIndex = 0;
  
  ValueNotifier<int> dotsIndex = ValueNotifier(1);

  List<ProductCategory> productsCategories;

  ScreenConfig screenConfig;
  WidgetSize widgetSize;
  HelpersApi helpersApi = HelpersApi();
  CategoriesStream categoriesStream =CategoriesStream();
  HomeProductBlock homeProductBlock = HomeProductBlock();
  
  //DotsStream dotsStream = DotsStream();



  @override
  void initState() {
    // TODO: implement initState
    
    super.initState();
    _pageController = PageController(
      initialPage: 1,
      viewportFraction:0.75,
    );
    
  }

  @override
  void dispose() {
    // TODO: implement dispose
    tabController.dispose();
    _pageController.dispose();
    homeProductBlock.dispose();
    categoriesStream.dispose();
    //dotsStream.dispose();
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
               return _screen(snapshot.data , context);
             }
           }
           break;         
         default:
       }
       return Container();
     },
    );

  }

  Widget _screen(List<ProductCategory> categories , BuildContext context){
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
          indicatorWeight: 3,
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
                     return _drawProducts(snapshot.data , context);
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


  List<Product> _randomTopProducts(List<Product> products){
     List<int> indexes = [];
     Random random = Random();     
     int counter = 5;
     List<Product> newProducts = [];
       do {
         int rnd =random.nextInt(products.length);
         if(!indexes.contains(rnd)){
         indexes.add(rnd);
         counter--;
         }
       } while (counter != 0);
   for(int index in indexes){
     newProducts.add(products[index]);
   }
    return newProducts;
  }


  Widget _drawProducts(List<Product> products , BuildContext context)  {
    List<Product> topProducts = _randomTopProducts(products);
     return  Container(
       padding: EdgeInsets.only(top: 24),
       child: Column(
         children: <Widget>[           
               
                 SizedBox(
                  height: MediaQuery.of(context).size.height*.25,
                   child: PageView.builder(
                   controller: _pageController,
                   scrollDirection: Axis.horizontal,
                   onPageChanged: (int index){
                     //dotsStream.dotsSink.add(index);
                     dotsIndex.value = index ;
                   },
                   itemCount: topProducts.length,
                   itemBuilder: (context , position){
                     return InkWell(
                           onTap: (){
                          _goToSingleProduct(context, topProducts[position]);
                          print(topProducts[position].product_title);
                          },
                          child: Card(                       
                          margin: EdgeInsets.only(right: 4.0 , left: 4.0),
                          shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10)),
                          clipBehavior: Clip.hardEdge,
                         child: Container(
                           child: Image(                        
                           fit: BoxFit.cover,
                           image: NetworkImage(topProducts[position].featuredImage()),), 
                    //  child: Image(image: NetworkImage('https://lorempixel.com/1000/600/?46119')), 
                   //  child: Text(products[position].product_title),
                         ),
                       ),
                     );
                   },
             ),
                ),
               
                      

                   ValueListenableBuilder(
                      valueListenable: dotsIndex,
                      builder: (context , value , _){
                          return Container(
                            padding: EdgeInsets.only(top: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: _drawDots(topProducts.length, value),
                            ),
                          );                         
                      },
                   ),

                
              Flexible(
               child: Padding(
                 padding: EdgeInsets.only(right: 4.0 , left: 4.0 , top: 24),
                 child: GridView.builder(
                   itemCount: products.length,
                 gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                   crossAxisCount: 2,
                   mainAxisSpacing: 8,
                   crossAxisSpacing: 8,
                   childAspectRatio: .5,
                 ),
                 itemBuilder: (BuildContext context , int position){
                   return InkWell(
                        onTap: (){
                          _goToSingleProduct(context, products[position]);
                          print(products[position].product_title);
                        },
                        child: Column(
                        children: <Widget>[
                          SizedBox(
                              height: 150,
                              child: Image(
                              image: NetworkImage(
                                products[position].featuredImage(),
                              ),
                              
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: Text(products[position].product_title,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headline,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: Text(
                              '\$ ${products[position].product_price.toString()}',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.subhead,
                            ),
                          ),
                        ],
                     ),
                   );
                 },
                ),
               ),
              ), 
         ],
       ),
     );
  }
  



 List<Widget> _drawDots(int qty, int index){
    List<Widget> widgets = [] ;
       for (var i = 0; i < qty; i++) {
         widgets.add(
         Container(
                  decoration: BoxDecoration(
                 color: (i == index)? ScreenUtilties.mainBlue : ScreenUtilties.lightGrey , 
                 borderRadius: BorderRadius.circular(5)
                ),
                width: 10,
                height: 10,       
                margin: (i==(qty-1))? EdgeInsets.only(right: 0) : EdgeInsets.only(right: 10)
              ),
      );
    }
    return widgets;
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


  _goToSingleProduct(BuildContext context,Product product){
       Navigator.push(context, MaterialPageRoute(
         builder: (context){
           return SingleProduct(product);
         }
       ));
  }
}
