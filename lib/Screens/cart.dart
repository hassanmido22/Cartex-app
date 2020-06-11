import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CartList extends StatefulWidget {
  @override
  _CartListState createState() => _CartListState();
}

class _CartListState extends State<CartList> {
  Widget cartItem() {
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
                            imageUrl:
                                'https://cf5.s3.souqcdn.com/item/2019/12/09/23/74/46/44/item_XXL_23744644_0e118a89359c0.jpg',
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
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
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
                                    "DR.Pepper",
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
                                    "10.00 LE",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Color.fromRGBO(194, 194, 194, 1),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        height: 30,
                                        width: 50,
                                        padding: EdgeInsets.all(0),
                                        decoration: BoxDecoration(
                                            color:
                                                Color.fromRGBO(238, 76, 125, 1),
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: IconButton(
                                          icon: Icon(Icons.remove),
                                          iconSize: 18,
                                          alignment: Alignment.center,
                                          onPressed: () {},
                                          color:
                                              Color.fromRGBO(247, 245, 221, 1),
                                        ),
                                      ),
                                      Text(
                                        "1",
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
                                            color:
                                                Color.fromRGBO(238, 76, 125, 1),
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: IconButton(
                                          icon: Icon(Icons.add),
                                          iconSize: 17,
                                          alignment: Alignment.center,
                                          onPressed: () {},
                                          color:
                                              Color.fromRGBO(247, 245, 221, 1),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ))
                    ],
                  ))),
          Expanded(
            flex: 59,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                "10.00 LE",
                style: TextStyle(
                  fontSize: 16,
                  color: Color.fromRGBO(72, 67, 92, 1),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, //Color.fromRGBO(238, 238, 255, 1),
      appBar: AppBar(
        title: Text("My Cart"),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.home,
              size: 30,
              color: Color.fromRGBO(91, 87, 148, 1),
            ),
            onPressed: () {
              // do something
            },
          )
        ],
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {},
        ),
      ),
      body: Container(
          child: new GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1, childAspectRatio: 320 / 120),
              controller: new ScrollController(keepScrollOffset: false),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: <Widget>[
            cartItem(),
            cartItem(),
            cartItem(),
            cartItem(),
            cartItem(),
            cartItem(),
          ])),
      bottomNavigationBar: BottomAppBar(
        elevation: 1,
        child: Container(
          margin: EdgeInsets.all(0),
          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          color: Colors.transparent,
          height: 90,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(
                    Icons.error,
                    color: Color.fromRGBO(91, 87, 148, 1),
                    size: 35,
                  ),
                  Text(
                    "Total : 40.00 LE",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color.fromRGBO(72, 67, 92, 1),
                      fontWeight: FontWeight.w700,
                    ),
                  )
                ],
              ),
              Container(
                height: 40,
                width: 130,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(206, 211, 255, 1),
                    borderRadius: BorderRadius.circular(15)),
                child: FlatButton(
                    child: Text(
                      "Checkout",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {}),
              )
            ],
          ),
        ),
      ),
    );
  }
}
