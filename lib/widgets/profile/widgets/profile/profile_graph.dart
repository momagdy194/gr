import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:untitled2/models/profile/stock_chart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SimpleTimeSeriesChart extends StatelessWidget {
  final List<StockChart> chart;

  final Color color;

  SimpleTimeSeriesChart({
    @required this.chart,
    @required this.color
  });

  @override
  Widget build(BuildContext context) {

    return SfCartesianChart(
      primaryXAxis: DateTimeAxis(),
      trackballBehavior: TrackballBehavior(
        enable: true,
        activationMode: ActivationMode.singleTap,
        tooltipDisplayMode: TrackballDisplayMode.groupAllPoints,
      ),
      tooltipBehavior: TooltipBehavior(
        canShowMarker: true,
        enable: true,
      ),
      zoomPanBehavior: ZoomPanBehavior(enableSelectionZooming: true),
      series: <ChartSeries>[
        // Renders CandleSeries
        CandleSeries<StockChart, DateTime>(
          dataSource: this.chart,
          xValueMapper: (StockChart sales, _) => DateTime.parse(sales.date),
          lowValueMapper: (StockChart sales, _) => sales.low,
          highValueMapper: (StockChart sales, _) => sales.high,
          openValueMapper: (StockChart sales, _) => sales.open,
          closeValueMapper: (StockChart sales, _) => sales.close,
        ),
      ],
    );
  }
}

/// Sample time series data type.
List sampleData = [
  {"open": 50.0, "high": 100.0, "low": 40.0, "close": 80, "volumeto": 5000.0},
  {"open": 80.0, "high": 90.0, "low": 55.0, "close": 65, "volumeto": 4000.0},
  {"open": 65.0, "high": 120.0, "low": 60.0, "close": 90, "volumeto": 7000.0},
  {"open": 90.0, "high": 95.0, "low": 85.0, "close": 80, "volumeto": 2000.0},
  {"open": 80.0, "high": 85.0, "low": 40.0, "close": 50, "volumeto": 3000.0},
];

/// Sample time series data type.
class RowDataXX {
  final DateTime timeStamp;
  final double cost;
  final open;
  final high;
  final low;
  final adjClose;
  final volume;
  final unadjustedVolume;
  final change;
  final changePercent;
  final vwap;
  final changeOverTime;
  final DateTime date;
  final double close;
  final String label;

  RowDataXX(
      {this.timeStamp,
        this.cost,
        this.open,
        this.high,
        this.low,
        this.adjClose,
        this.volume,
        this.unadjustedVolume,
        this.change,
        this.changePercent,
        this.vwap,
        this.changeOverTime,
        this.date,
        this.close,
        this.label});
}

