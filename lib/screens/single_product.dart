import 'package:flutter/material.dart';
import 'package:generalshop/product/product.dart';
import 'package:generalshop/screens/utilities/screen_utilities.dart';

class SingleProduct extends StatefulWidget {
  final Product product;
  SingleProduct(this.product);

  @override
  _SingleProductState createState() => _SingleProductState();
}

class _SingleProductState extends State<SingleProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.product_title),
      ),
      body: _drawScreen(context),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_shopping_cart),
        onPressed: () {},
      ),
    );
  }

  Widget _drawScreen(BuildContext context) {
    return Stack(
      children: <Widget>[
        SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: _drawImageGallery(context)),
              _drawTitle(context),
              _drawdeteilas(context),
            ],
          ),
        ),
        _drawLine(),
      ],
    );
  }

  Widget _drawImageGallery(BuildContext context) {
    return PageView.builder(
      itemCount: widget.product.images.length,
      itemBuilder: (context, position) {
        return Container(
          padding: EdgeInsets.all(8),
          child: Image(
            fit: BoxFit.cover,
            image: NetworkImage(widget.product.images[position]),
          ),
        );
      },
    );
  }

  Widget _drawTitle(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.product.product_title,
                  style: Theme.of(context).textTheme.headline,
                ),
                SizedBox(
                  height: 16.0,
                ),
            //    Text(widget.product.productCategory.category_name,
            //        style: Theme.of(context).textTheme.display1),

      
              ],
            ),
          ),
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text('\$ ${widget.product.product_price}',
                    style: Theme.of(context).textTheme.headline , ),
                SizedBox(
                  height: 16.0,
                ),
                (widget.product.product_discount > 0)
                    ? Text('\$ ${_calculatediscount()}',
                        style: Theme.of(context).textTheme.display1)
                    : Container(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _drawdeteilas(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Text(widget.product.product_description,
          style: Theme.of(context).textTheme.display2),
    );
  }

  String _calculatediscount() {
    double discount = widget.product.product_discount;
    double price = widget.product.product_price;
    return (price * discount).toString();
  }

  Widget _drawLine() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Transform.translate(
        offset: Offset(0, -40),
        child: Container(
          margin: EdgeInsets.only(right: 16.0,left: 20.0),
          height: 2.0,
          color: ScreenUtilties.lightGrey,
        ),
      ),
    );
  }
}
