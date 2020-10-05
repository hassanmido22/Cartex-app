import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gp_login_screen/Providers/filter_products.dart';
import 'package:provider/provider.dart';
import '../Models/top_product_chart.dart';
import '../Providers/UserProvider.dart';
import '../Providers/charts.dart';

class Chart extends StatelessWidget {
  //List<TopProducts> products;
  @override
  Widget build(BuildContext context) {
    ChartsProvider chartsProvider = Provider.of<ChartsProvider>(context);
    List<TopProducts> products = chartsProvider.getTopProducts();
    List<Productchart> barchartt = [];
    List<Color> colors = [
      new Color(0xFF3366cc),
      new Color(0xFFF51B00),
      new Color(0xFF888888),
    ];
    products.asMap().forEach((x, value) {
      barchartt
          .add(new Productchart(value.name, value.count, colors.elementAt(x)));
    });

    List<charts.Series<Productchart, String>> series = [
      charts.Series(
        id: "products",
        data: barchartt,
        domainFn: (Productchart series, _) => series.name,
        measureFn: (Productchart series, _) => series.count,
        colorFn: (Productchart series, _) =>
            charts.ColorUtil.fromDartColor(series.colorval),
      )
    ];
    return Column(
      children: <Widget>[
        Text(
          'Hightest Puchased Products',
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Nunito',
            fontWeight: FontWeight.bold,
            color: Color(0xff333333),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Expanded(
          child: charts.BarChart(
            series,
            animate: true,
            vertical: false,
          ),
        ),
      ],
    );
  }
}

class Productchart {
  String name;
  int count;
  Color colorval;
  Productchart(this.name, this.count, this.colorval);
}
