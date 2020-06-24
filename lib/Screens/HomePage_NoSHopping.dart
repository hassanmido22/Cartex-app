import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gp_login_screen/widgets/appBar.dart';
import 'package:gp_login_screen/widgets/carousel.dart';
import 'package:provider/provider.dart';
import '../Providers/HomePageProvider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final homePageProvider = Provider.of<HomePageProvider>(context);
    return Scaffold(
      appBar: MyAppBar(),
      drawer: Drawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            //homePageProvider.getVisibility()
            //?
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
                              labelText: 'Search for product , category ..',
                              suffixIcon: IconButton(
                                onPressed: () {
                                  homePageProvider.setVisibility(false);
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
                                  onPressed: () {})),
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
                            'assets/hot sale.svg',
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
            )
          ],
        ),
      ),
    );
  }
}
