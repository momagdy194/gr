class MarketIndexModel {
  final String symbol;
  final double change;
  final double price;
  final String name;

  MarketIndexModel({
    this.symbol, 
    this.change, 
    this.price, 
    this.name
  });

  static List<MarketIndexModel> toList(List<dynamic> items) {
    return items
    .map((item) => MarketIndexModel.fromJson(item))
    .toList();
  }

  factory MarketIndexModel.fromJson(Map<String, dynamic> json) {
    return MarketIndexModel(
      symbol:  json['changesPercentage'],
      change: json['changes'],
      price: double.parse(json['price']),
      name: json['ticker'],
    );
  }
}