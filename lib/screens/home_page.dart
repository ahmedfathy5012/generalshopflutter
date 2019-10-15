import 'package:flutter/material.dart';
import 'package:generalshop/product/product_category.dart';
import 'utilities/screen_utilities.dart';
import 'utilities/screen_config.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:generalshop/api/helpers_api.dart';
import 'utilities/helpers_widgets.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>with TickerProviderStateMixin{
  TabController tabController;
  
  ScreenConfig screenConfig;
  WidgetSize widgetSize;
  HelpersApi helpersApi = HelpersApi();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
                
  }

  @override
  void dispose() {
    // TODO: implement dispose
    tabController.dispose();
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
        ),
      ),


      body: Container(
         
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
