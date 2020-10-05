import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gp_login_screen/Models/profileModel.dart';
import 'package:gp_login_screen/Providers/UserInfoProvider.dart';
import 'package:gp_login_screen/Providers/UserProvider.dart';
import 'package:gp_login_screen/Providers/categoriesProvider.dart';
import 'package:gp_login_screen/Providers/wishlistProvider.dart';
import 'package:gp_login_screen/Screens/Login_page.dart';
import 'package:gp_login_screen/Screens/ProfilePage.dart';
import 'package:gp_login_screen/Screens/productCard.dart';
import 'package:gp_login_screen/Screens/search_products.dart';
import 'package:gp_login_screen/Widgets/entryItemWidget.dart';
import 'package:gp_login_screen/widgets/appBar.dart';
import 'package:gp_login_screen/widgets/carousell.dart';
import 'package:provider/provider.dart';
import '../Providers/homeProvider.dart';
import '../Providers/filter_products.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchController = TextEditingController();
  final List<Entry> data = <Entry>[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      CategoryProvider c = Provider.of<CategoryProvider>(context);
      c.categoriesList().forEach((c) => {
            setState(() {
              data.add(Entry(c.name));
            })
          });
      Provider.of<ProductsFilter>(context).setSerch('');
      Provider.of<ProductsFilter>(context)
          .fetchProducts(home:"home",feats: [], brands: [], category: [], featname: "");
    });
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
              title: Text("Logout"),
              content: new Text('Are you sure you want to logout ?'),
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
                FlatButton(
                  child: new Text(
                    "Logout",
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: () {
                    logout();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                )
              ]);
        });
  }

  @override
  Widget build(BuildContext context) {
    ProductsFilter filter = Provider.of<ProductsFilter>(context);
    UserProfileModel user = Provider.of<UserProvider>(context).getUser();
    MediaQueryData m = MediaQuery.of(context);
    final homePageProvider = Provider.of<HomeProvider>(context);
    final Entry entry = Entry('Categories', data);

    return Scaffold(
      appBar: MyAppBar(),
      drawer: Container(
        width: (236 * m.size.width) / 360,
        child: Drawer(
          elevation: 1,
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              Container(
                height: (160 * m.size.height) / 600,
                child: DrawerHeader(
                    child: Stack(fit: StackFit.expand, children: <Widget>[
                  Positioned(
                      width: 0,
                      height: 0,
                      top: 0,
                      right: 35,
                      child: IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            print("f");
                          })),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: CachedNetworkImage(
                            imageUrl: user.avatar,
                            imageBuilder: (context, imageProvider) => Container(
                              width: (50 * m.size.width) / 236,
                              height: (50 * m.size.width) / 236,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover),
                              ),
                            ),
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(user.username,
                            style: TextStyle(
                              fontSize: 18,
                              color: Color.fromRGBO(72, 67, 92, 1),
                              fontWeight: FontWeight.w900,
                            )),
                        SizedBox(height: 5),
                        Text(
                          user.email,
                          style: TextStyle(
                            fontSize: 13,
                            color: Color.fromRGBO(177, 177, 177, 1),
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),
                ])),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text(
                  'Home',
                  style: TextStyle(color: Color.fromRGBO(132, 132, 132, 1)),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              EntryItem(entry),
              ListTile(
                leading: Icon(Icons.person_outline),
                title: Text(
                  'Profile',
                  style: TextStyle(color: Color.fromRGBO(132, 132, 132, 1)),
                ),
                onTap: () {
                  Provider.of<WishlistProvider>(context).fetchWhitelist();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text(
                  'Logout',
                  style: TextStyle(color: Color.fromRGBO(132, 132, 132, 1)),
                ),
                onTap: () {
                  _showDialog();
                },
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15),
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
                      ? Container(
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
                                color: Color.fromRGBO(56, 52, 71, 1),
                                fontSize: 16),
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(20),
                                border: InputBorder.none,
                                hintText: 'Search for product , category ..',
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    if (_searchController.text != null) {
                                      WidgetsBinding.instance
                                          .addPostFrameCallback((_) {
                                        Provider.of<ProductsFilter>(context)
                                            .setSerch(_searchController.text);

                                        Provider.of<ProductsFilter>(context)
                                            .fetchProducts(
                                                feats: [],
                                                brands: [],
                                                category: [],
                                                featname: "");
                                      });
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ProductsSearch()),
                                      );
                                    } else {
                                      WidgetsBinding.instance
                                          .addPostFrameCallback((_) {
                                        Provider.of<ProductsFilter>(context)
                                            .setProducts(null);
                                      });
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ProductsSearch()),
                                      );
                                    }
                                  },
                                  icon: Icon(Icons.search),
                                  color: Color.fromRGBO(112, 112, 112, 1),
                                ),
                                prefixIcon: IconButton(
                                    icon: SvgPicture.asset(
                                      'assets/scanner.svg',
                                      color: Color.fromRGBO(112, 112, 112, 1),
                                      height: 20,
                                    ),
                                    onPressed: () {
                                      homePageProvider.setVisibility(false);
                                    })),
                          ),
                        )
                      : SizedBox(
                          height: 0,
                        )),
              Container(
                  color: Colors.transparent,
                  height: 170,
                  margin: EdgeInsets.all(10),
                  child: CarouselWithIndicatorDemo()),
              Container(
                margin: EdgeInsets.only(top: 10, bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    /*BoxShadow(
                        blurRadius: 6,
                        color: Colors.black26,
                        offset: Offset(2,0)),
                        BoxShadow(
                        blurRadius: 6,
                        color: Colors.black26,
                        offset: Offset(0,-2))*/
                  ],
                ),
                alignment: Alignment.center,
                height: 170,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 70,
                          height: 70,
                          child: RaisedButton(
                            onPressed: () {},
                            padding: EdgeInsets.all(15),
                            color: Color.fromRGBO(238, 76, 125, 1),
                            shape: CircleBorder(),
                            child: SvgPicture.asset(
                              'assets/hotsale.svg',
                              color: Color.fromRGBO(252, 252, 252, 1),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Hot Deals",
                          style: TextStyle(
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.w700,
                              color: Color.fromRGBO(56, 52, 71, 1),
                              fontSize: 16),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 70,
                          height: 70,
                          child: RaisedButton(
                            onPressed: () {},
                            padding: EdgeInsets.all(20),
                            color: Color.fromRGBO(238, 76, 125, 1),
                            shape: CircleBorder(),
                            child: SvgPicture.asset(
                              'assets/party.svg',
                              color: Color.fromRGBO(252, 252, 252, 1),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "New Arrivals",
                          style: TextStyle(
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.w700,
                              color: Color.fromRGBO(56, 52, 71, 1),
                              fontSize: 16),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 70,
                          height: 70,
                          child: RaisedButton(
                            onPressed: () {},
                            padding: EdgeInsets.all(20),
                            color: Color.fromRGBO(238, 76, 125, 1),
                            shape: CircleBorder(),
                            child: SvgPicture.asset(
                              'assets/like.svg',
                              color: Color.fromRGBO(252, 252, 252, 1),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "For you",
                          style: TextStyle(
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.w700,
                              color: Color.fromRGBO(56, 52, 71, 1),
                              fontSize: 16),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: 400,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 135 / 215,
                    crossAxisSpacing: 10,
                    crossAxisCount: 2,
                  ),
                  shrinkWrap: true,
                  itemBuilder: (conetext, index) {
                    return Cardviewhome(
                      product: filter.productsAll.elementAt(index),
                    );
                  },
                  itemCount: filter.productsAll.length,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
