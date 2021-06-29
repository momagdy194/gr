import 'package:meta/meta.dart';

class StockChart {
  final String date;
  final double close;
  final String label;

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

  StockChart(
      {this.date,
      this.close,
      this.label,
      this.open,
      this.high,
      this.low,
      this.adjClose,
      this.volume,
      this.unadjustedVolume,
      this.change,
      this.changePercent,
      this.vwap,
      this.changeOverTime}); //  StockChart({@required this.date, @required this.close, @required this.label});

  static List<StockChart> toList(List<dynamic> items) {
    return items.map((item) => StockChart.fromJson(item)).toList();
  }

  factory StockChart.fromJson(Map<dynamic, dynamic> json) {
    return StockChart(
      date: json['date'],
      close: json['close'],
      label: json['label'],
      open: json['open'],
      high: json['high'],
      low: json['low'],
      adjClose: json['adjClose'],
      volume: json['volume'],
      unadjustedVolume: json['unadjustedVolume'],
      change: json['change'],
      changePercent: json['changePercent'],
      vwap: json['vwap'],
      changeOverTime: json['changeOverTime'],
    );
  }
}
