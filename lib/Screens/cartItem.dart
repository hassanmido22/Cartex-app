import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gp_login_screen/Models/cart.dart';
import 'package:gp_login_screen/Providers/UserProvider.dart';
import 'package:provider/provider.dart';
import '../Providers/cartProvider.dart';

class SingleCartItem extends StatefulWidget {
  final Item item;
  final int index;

  const SingleCartItem({Key key, this.item, this.index}) : super(key: key);

  @override
  SingleCartItemState createState() => SingleCartItemState();
}

class SingleCartItemState extends State<SingleCartItem> {
  @override
  Widget build(BuildContext context) {
    Item usingItem = widget.item;
    String price = usingItem.productObj.price.toString();
    String totalPrice = usingItem.price.toStringAsFixed(2);
    MediaQueryData m = MediaQuery.of(context);

    return Container(
      margin: EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 261,
            child: Card(
              elevation: 1,
              color: Colors.white, //Color.fromRGBO(248, 248, 255, 1),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    flex: 87,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(9)),
                      margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                      child: CachedNetworkImage(
                        imageUrl: 'http://127.0.0.1:8000' +
                            usingItem.productObj.image,
                        imageBuilder: (context, imageProvider) => Container(
                          width: (55 * m.size.width) / 360,
                          height: (55 * m.size.width) / 360,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(9),
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.contain),
                          ),
                        ),
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 173,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(10, 20, 15, 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Text(
                              usingItem.product,
                              style: TextStyle(
                                fontSize: 16,
                                color: Color.fromRGBO(72, 67, 92, 1),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                            child: Text(
                              '\$$price LE',
                              style: TextStyle(
                                fontSize: 13,
                                color: Color.fromRGBO(194, 194, 194, 1),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: PlusMinusList(
                                  usingItem: usingItem, index: widget.index))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 59,
            child: Container(
              padding: EdgeInsets.only(top: 15, bottom: 5),
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Consumer<CartProvider>(
                        builder: (context, model, widgett) {
                      var total = model
                          .cartList()
                          .items
                          .elementAt(widget.index)
                          .price
                          .toStringAsFixed(2);
                      return Text(
                        '$total LE',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color.fromRGBO(72, 67, 92, 1),
                          fontWeight: FontWeight.w600,
                        ),
                      );
                    }),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(238, 76, 125, 1),
                        borderRadius: BorderRadius.circular(10)),
                    child: Align(
                      child: Align(
                          widthFactor: 0.7,
                          child: Container(
                              child: IconButton(
                            onPressed: () {
                              _showDialog(usingItem.product);
                            },
                            icon: Icon(
                              Icons.delete_forever,
                              color: Colors.white,
                            ),
                          ))),
                      alignment: Alignment.center,
                      widthFactor: 2,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _showDialog(String itemName) {
    // flutter defined function
    showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
              title: Text("Delete $itemName"),
              content: new Text('Are you sure to delete " $itemName ? " '),
              actions: <Widget>[
                // usually buttons at the bottom of the dialog
                new FlatButton(
                  child: new Text(
                    "Close",
                    style: TextStyle(
                      color: Color.fromRGBO(110, 167, 216, 1),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                Consumer<CartProvider>(
                    builder: (context, model, widgett) => new FlatButton(
                          child: new Text(
                            "Delete",
                            style: TextStyle(color: Colors.red),
                          ),
                          onPressed: () {
                            model.deleteItem(widget.index);
                            if (model.cartList().items.length == 0) {
                              model.setList(null);
                              model.setIsEmpty(true);
                            }
                            Navigator.of(context).pop();
                            deleteFromCart(widget.item.id);
                          },
                        ))
              ]);
        });
  }
}

class PlusMinusList extends StatefulWidget {
  final Item usingItem;
  final int index;
  PlusMinusList({this.usingItem, this.index});

  @override
  _PlusMinusListState createState() => _PlusMinusListState();
}

class _PlusMinusListState extends State<PlusMinusList> {
  int qty;
  @override
  void initState() {
    super.initState();
    qty = widget.usingItem.quantity;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, model, widgett) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            height: 30,
            width: 50,
            padding: EdgeInsets.all(0),
            decoration: BoxDecoration(
                color: Color.fromRGBO(110, 167, 216, 1),
                borderRadius: BorderRadius.circular(15)),
            child: IconButton(
              icon: Icon(Icons.remove),
              iconSize: 18,
              alignment: Alignment.center,
              onPressed: () {
                if (model.getQuantity(widget.index) > 1) {
                  model.minusQuantity(widget.index);
                  updateCart(
                      widget.usingItem.id, model.getQuantity(widget.index));
                }
              },
              color: Color.fromRGBO(247, 245, 221, 1),
            ),
          ),
          Text(
            model.getQuantity(widget.index).toString(),
            style: TextStyle(
              fontSize: 18,
              color: Color.fromRGBO(72, 67, 92, 1),
              fontWeight: FontWeight.w700,
            ),
          ),
          Container(
            height: 30,
            width: 50,
            padding: EdgeInsets.all(0),
            decoration: BoxDecoration(
                color: Color.fromRGBO(110, 167, 216, 1),
                borderRadius: BorderRadius.circular(15)),
            child: IconButton(
              icon: Icon(Icons.add),
              iconSize: 17,
              alignment: Alignment.center,
              onPressed: () {
                model.addQuantity(widget.index);
                updateCart(
                    widget.usingItem.id, model.getQuantity(widget.index));
              },
              color: Color.fromRGBO(247, 245, 221, 1),
            ),
          ),
        ],
      ),
    );
  }
}
