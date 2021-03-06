import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselWithIndicatorDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicatorDemo> {
  int _current = 0;

  final List<String> imgList = [
    'https://souqcms.s3-eu-west-1.amazonaws.com/cms/boxes/img/desktop/L_1595434623_Samsung-Phones-Web-MB-EN.pnghttps://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://souqcms.s3-eu-west-1.amazonaws.com/cms/boxes/img/desktop/L_1595434053_Perfumesforhim-mweb-en.jpg',
    'https://souqcms.s3-eu-west-1.amazonaws.com/cms/boxes/img/desktop/L_1595434054_Perfumesforher-mweb-en.jpg',
    'https://souqcms.s3-eu-west-1.amazonaws.com/cms/boxes/img/desktop/L_1595434053_GW-MB-Footwear-Deals-en.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Stack(overflow: Overflow.clip, children: [
      CarouselSlider(
        items: imgList
            .map(
              (item) => Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(15)),
                child: Image.network(
                  item,
                  //color: Colors.red,
                  fit: BoxFit.cover,
                  width: width,
                ),
              ),
            )
            .toList(),
        options: CarouselOptions(
            aspectRatio: 5,
            height: 200,
            viewportFraction: 1.0,
            enlargeCenterPage: false,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            }),
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imgList.map((url) {
            int index = imgList.indexOf(url);
            return Container(
              width: 8.0,
              height: 8.0,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _current != index
                    ? Colors.white
                    : Color.fromRGBO(238, 76, 125, 1),
              ),
            );
          }).toList(),
        ),
      ),
      /*Positioned(
          right: 10,
          top: 10,
          child: RaisedButton(
              color: Colors.white70,
              onPressed: () {},
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Text(
                "Shop Now",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w800,
                    color: Color.fromRGBO(238, 76, 125, 1),
                    fontSize: 14),
              )))*/
    ]);
  }
}
