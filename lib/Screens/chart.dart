import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import '../Models/top_product_chart.dart';
import '../Providers/UserProvider.dart';

class Chart extends StatelessWidget {
  //List<TopProducts> products;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TopProducts>>(
      future: getTheHeightestProduct(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<TopProducts> products = snapshot.data;
          List<Productchart> barchartt = new List<Productchart>(2);
          List<Color> colors = [
            new Color(0xFF3366cc),
            new Color(0xFFF51B00),
          ];
          products.asMap().forEach((x, value) {
            /*barchartt.add(
                new Productchart(value.name, value.count, Color(0xFF3366cc)));*/
            barchartt[x] =
                new Productchart(value.name, value.count, colors.elementAt(x));
          });

          /*var barchart = [
            new Productchart(products.name, products.count, Color(0xFF3366cc)),
            new Productchart(products.name, products.count, Color(0xFFF51B00)),
          ];*/
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

          //final List<TopProducts> data ;
          print(snapshot.data);
          print('in');
          //print(products.name);
          return Scaffold(
            //List<charts.Series<TopProducts,String>> series=[] ;

            appBar: AppBar(
              title: Text(
                'Top 2 products statistics',
              ),
            ),

            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 400,
                child: Card(
                  child: Column(
                    children: <Widget>[
                      Text(
                        'highest 2 products you bought',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Expanded(
                        child: charts.BarChart(series, animate: true),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return new CircularProgressIndicator();
        }
      },
    );
  }
}

class Productchart {
  String name;
  int count;
  Color colorval;
  Productchart(this.name, this.count, this.colorval);
}
