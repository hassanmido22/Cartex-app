import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:gp_login_screen/Models/product_item.dart';
import 'package:gp_login_screen/Models/recommentationModel.dart';
import 'package:gp_login_screen/Providers/UserProvider.dart';
import 'package:gp_login_screen/Providers/wishlistProvider.dart';
import 'package:gp_login_screen/Screens/singleShowProduct..dart';
import 'package:provider/provider.dart';

class Cardviewhome extends StatefulWidget {
  final Product product;

  const Cardviewhome({Key key, this.product}) : super(key: key);

  @override
  _CardviewhomeState createState() => _CardviewhomeState();
}

class _CardviewhomeState extends State<Cardviewhome> {
  bool isFav;

  @override
  void initState() {
    super.initState();
    setState(() {
      isFav = widget.product.isFavourit;
    });
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData m = MediaQuery.of(context);
    return Container(
      height: 300,
      child: GestureDetector(
        onTap: () async {
          List<Recommendationlist> rec = await getReccommendedProducts(widget.product.name);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      SingleProductItem(item: widget.product,recommendations:rec)));
        },
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          color: const Color(0xFFF1F1F1),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 5),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 90,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(4, 20, 0, 0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: const Color(0xFFF1F1F1),
                              borderRadius: BorderRadius.circular(9)),
                          margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: Hero(
                            tag: '${widget.product.id}',
                            child: CachedNetworkImage(
                              imageUrl: widget.product.image,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                width: (55 * m.size.width) / 360,
                                height: (85 * m.size.width) / 400,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.contain),
                                ),
                              ),
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          widget.product.name,
                          overflow: TextOverflow.clip,
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w500,
                            color: const Color(
                              0xFF707070,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(9.0),
                        child: IconButton(
                          onPressed: () {
                            WishlistProvider wishlistProvider =
                                Provider.of<WishlistProvider>(context);
                            wishlistProvider.addToWishlist(
                                item: widget.product.id);
                            setState(() {
                              isFav = !isFav;
                            });
                          },
                          iconSize: 40,
                          icon: Icon(
                            isFav ? Icons.favorite : Icons.favorite_border,
                            color: Color(0xffEE4C7D),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                (widget.product.discountPrice > 1)
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '${widget.product.price.toStringAsFixed(2)} LE',
                                  maxLines: 2,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Nunito',
                                    fontWeight: FontWeight.w500,
                                    decoration: TextDecoration.lineThrough,
                                    color: const Color(
                                      0xFF6ED8A2,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Row(
                              //crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    child: Text(
                                      '${widget.product.discountPrice.toStringAsFixed(2)} LE',
                                      maxLines: 2,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.bold,
                                        color: const Color(
                                          0xFF4B6E8C,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: Container(
                                    child: Text(
                                      '${((widget.product.discountPrice / widget.product.price) * 100).toStringAsFixed(0)} %',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.w700,
                                        color: const Color(
                                          0xFFEE4C7D,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ])
                    : Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '${widget.product.price} LE',
                            maxLines: 2,
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.bold,
                              color: const Color(
                                0xFF4B6E8C,
                              ),
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
