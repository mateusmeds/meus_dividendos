class TickerModel {
  TickerModel(this.ticker);

  String ticker;

  factory TickerModel.fromJson(String json) {
    return TickerModel(json);
  }

  Map<String, dynamic> toJson() {
    return {
      'ticker': ticker,
    };
  }
}
