import 'package:barcode_scan/barcode_scan.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:drawing_animation/drawing_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gp_login_screen/Providers/OrderProvider.dart';
import 'package:gp_login_screen/Providers/charts.dart';
import 'package:gp_login_screen/Providers/wishlistProvider.dart';
import 'package:gp_login_screen/model/element.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gp_login_screen/Providers/branchProvider.dart';
import 'package:gp_login_screen/Screens/HomePage.dart';
import 'package:gp_login_screen/Screens/HomePage_NoSHopping.dart';
import 'package:provider/provider.dart';

import '../Providers/UserInfoProvider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserProvider>(context).fetchUser();
      Provider.of<OrderProvider>(context).getorders().then((value) => {
            Provider.of<WishlistProvider>(context).fetchWhitelist(),
            Provider.of<UserProvider>(context).fetchUser().then((value) =>
                {Provider.of<ChartsProvider>(context).getTheHeightestProduct()})
          });
    });
  }

  scan() async {
    try {
      var options = ScanOptions(
        strings: {
          "cancel": "cancel",
          "flash_on": "Flast on",
          "flash_off": "fLash off",
        },
      );

      await BarcodeScanner.scan(options: options).then((result) async {
        if (result.rawContent.isNotEmpty) {
          print(result.rawContent);
          Provider.of<BranchProvider>(context)
              .getBranchApi(result.rawContent)
              .then((value) => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ShoppingPage(),
                        ))
                  });
        }
        return Container(
          color: Colors.red,
        );
      });
    } on PlatformException catch (e) {
      var result = ScanResult(
        type: ResultType.Error,
        format: BarcodeFormat.unknown,
      );

      if (e.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          result.rawContent = 'The user did not grant the camera permission!';
        });
      } else {
        result.rawContent = 'Unknown error: $e';
      }
      print(result);
    }
  }

  final bool dialVisible = true;
  bool toogle;
  int _index = 0;
  bool run = true;

  SpeedDial buildSpeedDial() {
    return SpeedDial(
      backgroundColor: const Color(0xFFEE4C7D),
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(size: 22.0),
      // child: Icon(Icons.add),
      visible: dialVisible,
      curve: Curves.bounceIn,
      children: [
        SpeedDialChild(
          child: Icon(Icons.edit, color: Colors.white),
          backgroundColor: const Color(0xFF6ED8A2),
          onTap: () => print('FIRST CHILD'),
          label: 'Add Items',
          labelStyle: TextStyle(
              fontWeight: FontWeight.w500,
              fontFamily: 'Nunito-med',
              fontSize: 24,
              color: Colors.white),
          labelBackgroundColor: const Color(0xFF6ED8A2),
        ),
        SpeedDialChild(
          child: Icon(Icons.menu, color: Colors.white),
          backgroundColor: const Color(0xFF14999E),
          onTap: () => print('FIRST CHILD'),
          label: 'List itmes',
          labelStyle: TextStyle(
              fontWeight: FontWeight.w500,
              fontFamily: 'Nunito-med',
              fontSize: 24,
              color: Colors.white),
          labelBackgroundColor: const Color(0xFF14999E),
        ),
      ],
    );
  }

  toggleWidget({List<String> path, List<String> title, int index}) {
    return
        //Expanded(child:
        Container(
      //height: 300,
      child: Card(
        elevation: 0,
        margin: EdgeInsets.all(5),
        shape: RoundedRectangleBorder(
          side: BorderSide(
              color: index != _index ? Color(0xffEE4C7D) : Colors.white),
          borderRadius: BorderRadius.circular(25),
        ),
        color: index == _index ? Color(0xffEE4C7D) : Colors.white,
        child: InkWell(
          borderRadius: BorderRadius.circular(25),
          highlightColor: Color.fromRGBO(255, 255, 255, 0.1),
          onTap: () {},
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset(
                path[index],
                color: index != _index ? Color(0xffEE4C7D) : Colors.white,
                height: 50,
              ),
              SizedBox(height: 20),
              Text(
                title[index],
                style: TextStyle(
                  fontSize: 20,
                  color: index != _index ? Color(0xffEE4C7D) : Colors.white,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ),
      ),
      // ),
    );
  }

  @override
  Widget build(BuildContext context) {
    UserProvider user = Provider.of<UserProvider>(context);
    BranchProvider branchProvider = Provider.of<BranchProvider>(context);
    List<String> titles = ['Main Home', 'Start Shopping'];
    List<String> iconsPaths = ['assets/browser.svg', 'assets/supermarket.svg'];
    final Shader linearGradient = LinearGradient(
      colors: <Color>[Color(0xffEE4C7D), Color(0xffEF1859)],
    ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
    return WillPopScope(
      onWillPop: () => SystemNavigator.pop(),
      child: Scaffold(
        //floatingActionButton: buildSpeedDial(),
        backgroundColor: Colors.white,
        body: branchProvider.getLoading()
            ? Center(
                child: AnimatedDrawing.svg(
                "assets/logo.svg",
                run: this.run,
                width: 150,
                duration: new Duration(milliseconds: 1500),
                lineAnimation: LineAnimation.oneByOne,
                animationCurve: Curves.decelerate,
                onFinish: () => setState(() {}),
              ))
            : SingleChildScrollView(
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(20),
                  child: Container(
                    margin: EdgeInsets.fromLTRB(10, 80, 0, 0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                              child: CachedNetworkImage(
                                imageUrl: user.getLoading()
                                    ? ''
                                    : user.getUser().avatar,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            ),
                            Flexible(
                              child: Container(
                                alignment: FractionalOffset.topLeft,
                                child: user.getLoading()
                                    ? CircularProgressIndicator(
                                        backgroundColor: Colors.red,
                                      )
                                    : Text(
                                        'Welcome , ${user.getUser().username}',
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontFamily: 'Nunito-bold',
                                            fontWeight: FontWeight.w600,
                                            foreground: Paint()
                                              ..shader = linearGradient),
                                        overflow: TextOverflow.clip,
                                      ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          alignment: FractionalOffset.topLeft,
                          child: Text(
                            'Select what your going to do ..',
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Nunito-bold',
                              fontWeight: FontWeight.w600,
                              color: Color(0xff707070),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          height: 350,
                          width: 300,
                          margin: EdgeInsets.only(top: 40, bottom: 20),
                          child: PageView.builder(
                            itemCount: 2,
                            controller: PageController(viewportFraction: 0.7),
                            onPageChanged: (int index) =>
                                {setState(() => _index = index), print(index)},
                            itemBuilder: (_, i) {
                              return Transform.scale(
                                scale: i == _index ? 1 : 0.9,
                                child: toggleWidget(
                                    index: i, path: iconsPaths, title: titles),
                              );
                            },
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: RaisedButton(
                            padding: EdgeInsets.only(
                                left: 55, right: 55, top: 15, bottom: 15),
                            color: Colors.white,
                            child: Text(
                              "Lets Go",
                              style: TextStyle(
                                fontSize: 20,
                                color: Color(0xffEE4C7D),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            onPressed: () async {
                              if (_index == 0) {
                                List<ElementTask> s = [];
                                s.add(ElementTask("item 1", true));
                                s.add(ElementTask("item 2", true));
                                s.add(ElementTask("item 3", true));
                                s.add(ElementTask("item 4", true));
                                s.add(ElementTask("item 5", true));
                                Map<String, List<ElementTask>> x = {};
                                x.addAll({"list1": s});
                                x.addAll({"list2": s});
                                /*DonePage(
                                            currentList: x,
                                          )*/
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomeScreen()
                                      //TaskPage()

                                      ),
                                );
                              } else {
                                scan();
                              }
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                              side: BorderSide(color: Color(0xffEE4C7D)),
                            ),
                          ),
                        )
                        /*Row(
                    children: <Widget>[
                      toggleWidget(
                          index: 0, path: 'assets/browser.svg', title: 'Main Home'),
                      toggleWidget(
                          index: 1,
                          path: 'assets/supermarket.svg',
                          title: 'Start Shopping')
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          height: 100,
                          child: Card(
                            elevation: 0,
                            margin: EdgeInsets.all(5),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Color(0xffEE4C7D)),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            color: Colors.white,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(25),
                              highlightColor: Color.fromRGBO(255, 255, 255, 0.1),
                              onTap: () {},
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SvgPicture.asset(
                                    'assets/pin.svg',
                                    color: Color(0xffEE4C7D),
                                    height: 30,
                                  ),
                                  SizedBox(width: 20),
                                  Text(
                                    "Inside",
                                    style: TextStyle(
                                      fontSize: 22,
                                      color: Color(0xffEE4C7D),
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 100,
                          child: Card(
                            elevation: 0,
                            margin: EdgeInsets.all(5),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Color(0xffEE4C7D)),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            color: Colors.white,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(25),
                              highlightColor: Color.fromRGBO(255, 255, 255, 0.1),
                              onTap: () {},
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SvgPicture.asset(
                                    'assets/out.svg',
                                    color: Color(0xffEE4C7D),
                                    height: 30,
                                  ),
                                  SizedBox(width: 20),
                                  Text(
                                    "Outside",
                                    style: TextStyle(
                                      fontSize: 22,
                                      color: Color(0xffEE4C7D),
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )*/
                        /*
                  Row(
                    children: <Widget>[
                      Container(
                        alignment: FractionalOffset.center,
                        
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 3,
                              offset: Offset(0.0, 0.3),
                            ),
                          ],
                        ),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              child: Container(
                                child: Image.asset('drawables/scan.png'),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => Scanner()),
                                );
                              },
                              child: Container(
                                child: Text(
                                  'Start Shopping',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'Nunito-bold',
                                    color: const Color(0xff14999E),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        alignment: FractionalOffset.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.transparent),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 3.0,
                              offset: Offset(0.0, 0.3),
                            ),
                          ],
                        ),
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Container(
                                child: Image.asset('drawables/home.png'),
                              ),
                            ),
                            SizedBox(
                              width: 50,
                            ),
                            Container(
                              child: Text(
                                'Main Home',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Nunito-bold',
                                  color: const Color(0xff14999E),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )*/
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
