import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gp_login_screen/Screens/FiltersScreen.dart';
import 'package:gp_login_screen/Screens/filterAppbar.dart';
import 'package:gp_login_screen/Screens/productCard.dart';
import 'package:provider/provider.dart';
import '../Providers/homeProvider.dart';
import '../Providers/filter_products.dart';

class ProductsSearch extends StatefulWidget {
  @override
  _ProductsSearchState createState() => _ProductsSearchState();
}

class _ProductsSearchState extends State<ProductsSearch> {
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(() => {
          if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent)
            {_getMoreData()}
        });
  }

  _getMoreData() {
    ProductsFilter productsFilter = Provider.of<ProductsFilter>(context);
    print(productsFilter.getNext().toString());
    if (productsFilter.getNext() == null) {
      print("dsfdfg");
    } else {
      productsFilter
          .fetchProducts(feats: [], brands: [], category: [], featname: "");
    }
  }

  @override
  Widget build(BuildContext context) {
    final homePageProvider = Provider.of<HomeProvider>(context);
    final filter = Provider.of<ProductsFilter>(context);

    final _searchController = TextEditingController();
    return Scaffold(
      appBar: MyAppBar(),
      drawer: Drawer(),
      body: Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            AnimatedOpacity(

                // If the widget is visible, animate to 0.0 (invisible).
                // If the widget is hidden, animate to 1.0 (fully visible).
                opacity: homePageProvider.getVisibility() ? 1.0 : 0.0,
                duration: Duration(milliseconds: 500),
                child: homePageProvider.getVisibility()
                    ? Row(
                        children: <Widget>[
                          Expanded(
                            flex: 7,
                            child: Container(
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(252, 252, 252, 1),
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 6.0,
                                      offset: Offset(0.0, 3))
                                ],
                              ),
                              height: 50,
                              child: TextFormField(
                                controller: _searchController,
                                style: TextStyle(
                                    fontFamily: 'Nunito',
                                    fontWeight: FontWeight.w700,
                                    color: Color.fromRGBO(112, 112, 112, 1),
                                    fontSize: 16),
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(20),
                                    border: InputBorder.none,
                                    hintText:
                                        'Search for product , category ..',
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        if (_searchController.text != null) {
                                          WidgetsBinding.instance
                                              .addPostFrameCallback((_) {
                                            Provider.of<ProductsFilter>(context)
                                                .setSerch(
                                                    _searchController.text);

                                            Provider.of<ProductsFilter>(context)
                                                .fetchProducts(
                                                    feats: [],
                                                    brands: [],
                                                    featname: "");
                                          });
                                        }
                                      },
                                      icon: Icon(Icons.search),
                                      color: Color.fromRGBO(112, 112, 112, 1),
                                    ),
                                    prefixIcon: IconButton(
                                        icon: SvgPicture.asset(
                                          'assets/scanner.svg',
                                          color:
                                              Color.fromRGBO(112, 112, 112, 1),
                                          height: 20,
                                        ),
                                        onPressed: () {})),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: IconButton(
                                icon: Icon(Icons.tune),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FilterScreen()),
                                  );
                                }),
                          )
                        ],
                      )
                    : SizedBox(
                        height: 0,
                      )),
            (filter.getLoading())
                ? Container(
                    height: 300,
                    child: Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.red,
                      ),
                    ),
                  )
                : (filter.getProducts().length >= 1)
                    ? Expanded(
                        child: GridView.builder(
                          controller: _scrollController,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 135 / 215,
                            crossAxisSpacing: 10,
                            crossAxisCount: 2,
                          ),
                          shrinkWrap: true,
                          itemBuilder: (conetext, index) {
                            return Cardviewhome(
                              product: filter.getProducts().elementAt(index),
                            );
                          },
                          itemCount: filter.getProducts().length,
                        ),
                      )
                    : Center(heightFactor: 20, child: Text("There is no items"))
          ],
        ),
      ),
    );
  }
}
