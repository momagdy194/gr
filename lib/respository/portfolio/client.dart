import 'package:dio/dio.dart';
import 'package:untitled2/helpers/http_helper.dart';
import 'package:untitled2/models/data_overview.dart';
import 'package:untitled2/models/profile/market_index.dart';

class PortfolioClient extends FetchClient {

  Future<List<MarketIndexModel>> fetchIndexes() async {
    final Response<dynamic> response = await super.financialModelRequest('/api/v3/actives');
    return MarketIndexModel.toList(response.data);
  }

  Future<StockOverviewModel> fetchStocks({String symbol}) async {
    final Response<dynamic> response = await super.financialModelRequest('/api/v3/quote/$symbol');
    print("ssss"+symbol);
    print(response.data[0]);
    return StockOverviewModel.fromJson(response.data[0]);
  }
}