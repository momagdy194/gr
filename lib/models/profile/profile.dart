import 'package:meta/meta.dart';

import 'package:untitled2/models/profile/stock_profile.dart';
import 'package:untitled2/models/profile/stock_quote.dart';
import 'package:untitled2/models/profile/stock_chart.dart';

class ProfileModel {

  final StockProfile stockProfile;
  final StockQuote stockQuote;
  final List<StockChart> stockChart;

  ProfileModel({
    @required this.stockProfile,
    @required this.stockQuote,
    @required this.stockChart,
  });
}
