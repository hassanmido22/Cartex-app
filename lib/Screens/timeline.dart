import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:gp_login_screen/Models/orders.dart';
import 'package:provider/provider.dart';
import '../Providers/OrderProvider.dart';

class DateTimeComboLinePointChart extends StatelessWidget {
  /// Creates a [TimeSeriesChart] with sample data and no transition.

  @override
  Widget build(BuildContext context) {
    return new charts.TimeSeriesChart(
      _createSampleData(Provider.of<OrderProvider>(context).ordersList()),
      animate: true,
      
      // Configure the default renderer as a line renderer. This will be used
      // for any series that does not define a rendererIdKey.
      //
      // This is the default configuration, but is shown here for  illustration.
      defaultRenderer: new charts.LineRendererConfig(),
      
      // Custom renderer configuration for the point series.
      customSeriesRenderers: [
        new charts.PointRendererConfig(
            // ID used to link series to this renderer.
            customRendererId: 'customPoint')
      ],
      // Optionally pass in a [DateTimeFactory] used by the chart. The factory
      // should create the same type of [DateTime] as the data provided. If none
      // specified, the default creates local date time.
      dateTimeFactory: const charts.LocalDateTimeFactory(),
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<TimeSeriesSales, DateTime>> _createSampleData(
      List<Orders> orders) {
    final List<TimeSeriesSales> pointsData = [];
    final List<TimeSeriesSales> itemsData = [];
    final List<TimeSeriesSales> totalExpensesData = [];

    orders.forEach((ord) {
      pointsData.add(new TimeSeriesSales(ord.createdAt, ord.points));
    });

    orders.forEach((ord) {
      itemsData.add(new TimeSeriesSales(ord.createdAt, ord.items.length));
    });

    orders.forEach((ord) {
      totalExpensesData
          .add(new TimeSeriesSales(ord.createdAt, ord.total.toInt()));
    });

    return [
      new charts.Series<TimeSeriesSales, DateTime>(
        id: 'Desktop',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesSales sales, _) => sales.time,
        measureFn: (TimeSeriesSales sales, _) => sales.sales,
        data: pointsData,
      ),
      new charts.Series<TimeSeriesSales, DateTime>(
        id: 'Tablet',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (TimeSeriesSales sales, _) => sales.time,
        measureFn: (TimeSeriesSales sales, _) => sales.sales,
        data: itemsData,
      ),
      new charts.Series<TimeSeriesSales, DateTime>(
          id: 'Mobile',
          colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
          domainFn: (TimeSeriesSales sales, _) => sales.time,
          measureFn: (TimeSeriesSales sales, _) => sales.sales,
          data: totalExpensesData)
      // Configure our custom point renderer for this series.
      //..setAttribute(charts.rendererIdKey, 'customPoint'),
    ];
  }
}

/// Sample time series data type.
class TimeSeriesSales {
  final DateTime time;
  final int sales;

  TimeSeriesSales(this.time, this.sales);
}
