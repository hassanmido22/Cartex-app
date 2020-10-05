import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gp_login_screen/Models/profileModel.dart';
import 'package:gp_login_screen/Providers/OrderProvider.dart';
import 'package:gp_login_screen/Providers/wishlistProvider.dart';
import 'package:gp_login_screen/Screens/ChartsPage.dart';
import 'package:gp_login_screen/Screens/WishlistScreen.dart';
import 'package:gp_login_screen/Screens/editProfile.dart';
import 'package:gp_login_screen/Screens/ordersScreen.dart';
import 'package:provider/provider.dart';
import '../Providers/UserInfoProvider.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    UserProfileModel user = Provider.of<UserProvider>(context).getUser();
    MediaQueryData m = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffF8F8F8),
        elevation: 0,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        title: Text(
          "Profile",
          style: TextStyle(
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w700,
              color: Color.fromRGBO(56, 52, 71, 1),
              fontSize: 20),
        ),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 20),
            decoration:
                BoxDecoration(color: Color(0xffEE4C7D), shape: BoxShape.circle),
            child: IconButton(
                icon: SvgPicture.asset(
                  'assets/edit.svg',
                  color: Colors.white,
                  width: 20,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditProfileScreen(),
                      ));
                }),
          )
        ],
      ),
      body: Container(
        //padding: EdgeInsets.all(20),
        color: Color(0xffF8F8F8),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    color: Colors.transparent,
                    child: Column(children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Color(0xffEE4C7D), width: 3),
                            shape: BoxShape.circle),
                        //margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: CachedNetworkImage(
                          imageUrl: "${user.avatar}",
                          imageBuilder: (context, imageProvider) => Container(
                            width: (70 * m.size.width) / 236,
                            height: (70 * m.size.width) / 236,
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
                    ]),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    user.username,
                    style: TextStyle(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w700,
                        color: Color.fromRGBO(56, 52, 71, 1),
                        fontSize: 20),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: new BoxDecoration(
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Colors.black12,
                              blurRadius: 6.0,
                              offset: Offset(0.0, 3))
                        ],
                        color: Colors.white,
                        borderRadius: new BorderRadius.circular(25)),
                    padding: EdgeInsets.fromLTRB(25, 8, 25, 8),
                    child: Text(user.points.toStringAsFixed(0) + "  points",
                        style: TextStyle(
                          fontSize: 15,
                          color: Color.fromRGBO(238, 76, 125, 1),
                          fontWeight: FontWeight.w900,
                        )),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                  padding: EdgeInsets.only(left: 15, top: 40, right: 15),
                  decoration: BoxDecoration(
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6.0,
                          offset: Offset(0.0, 3))
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50)),
                  ),
                  child: ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 5, bottom: 5),
                        child: ListTile(
                          onTap: () {
                            Provider.of<OrderProvider>(context).getorders();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Orderslist(),
                                ));
                          },
                          leading: Container(
                            decoration: BoxDecoration(
                                color: Color(0xff888888),
                                borderRadius: BorderRadius.circular(15)),
                            child: IconButton(
                                icon: SvgPicture.asset(
                                  'assets/supermarket.svg',
                                  color: Colors.white,
                                  width: 20,
                                ),
                                onPressed: () {}),
                          ),
                          title: Text(
                            "List Orders",
                            style: TextStyle(
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.w700,
                                color: Color(0xff888888),
                                fontSize: 18),
                          ),
                          trailing: IconButton(
                              icon: Icon(Icons.arrow_forward_ios),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Orderslist(),
                                    ));
                              }),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5, bottom: 5),
                        child: ListTile(
                          onTap: () {
                            Provider.of<WishlistProvider>(context)
                                .fetchWhitelist();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => WishlistScreen(),
                                ));
                          },
                          leading: Container(
                            decoration: BoxDecoration(
                                color: Color(0xff888888),
                                borderRadius: BorderRadius.circular(15)),
                            child: IconButton(
                                icon: SvgPicture.asset(
                                  'assets/post.svg',
                                  color: Colors.white,
                                  width: 20,
                                ),
                                onPressed: () {}),
                          ),
                          title: Text(
                            "My Wishlist",
                            style: TextStyle(
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.w700,
                                color: Color(0xff888888),
                                fontSize: 18),
                          ),
                          trailing: IconButton(
                              icon: Icon(Icons.arrow_forward_ios),
                              onPressed: () {
                                Provider.of<WishlistProvider>(context)
                                    .fetchWhitelist();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => WishlistScreen(),
                                    ));
                              }),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5, bottom: 5),
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChartsPage(),
                                ));
                          },
                          leading: Container(
                            decoration: BoxDecoration(
                                color: Color(0xff888888),
                                borderRadius: BorderRadius.circular(15)),
                            child: IconButton(
                                icon: SvgPicture.asset(
                                  'assets/statistics.svg',
                                  color: Colors.white,
                                  width: 20,
                                ),
                                onPressed: () {}),
                          ),
                          title: Text(
                            "Statistics",
                            style: TextStyle(
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.w700,
                                color: Color(0xff888888),
                                fontSize: 18),
                          ),
                          trailing: IconButton(
                              icon: Icon(Icons.arrow_forward_ios),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ChartsPage(),
                                    ));
                              }),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5, bottom: 5),
                        child: ListTile(
                          leading: Container(
                            decoration: BoxDecoration(
                                color: Color(0xffEE4C7D),
                                borderRadius: BorderRadius.circular(15)),
                            child: IconButton(
                                icon: Icon(Icons.exit_to_app,
                                    color: Colors.white),
                                onPressed: () {}),
                          ),
                          title: Text(
                            "Log out",
                            style: TextStyle(
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.w700,
                                color: Color(0xffEE4C7D),
                                fontSize: 18),
                          ),
                          trailing: IconButton(
                              icon: Icon(Icons.arrow_forward_ios),
                              color: Color(0xffEE4C7D),
                              onPressed: () {}),
                          onTap: () {},
                        ),
                      )
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
