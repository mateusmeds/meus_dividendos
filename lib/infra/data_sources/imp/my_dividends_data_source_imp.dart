import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:my_dividends/infra/data_sources/my_dividends_data_source.dart';
import 'package:http/http.dart' as http;

class MyDividendsDataSourceImp implements MyDividendsDataSource {
  final String host = "https://brapi.dev/api/";

  Uri _buildUri(String path) {
    return Uri.parse(host + path);
  }

  Map<String, String> _buildHeaders() {
    return {'content-type': 'application/json'};
  }

  @override
  Future<Either<Exception, Map<String, dynamic>>>
      getAllAvailableTickers() async {
    try {
      final response = await http.get(
        _buildUri('available'),
        headers: _buildHeaders(),
      );
      var responseBodyString = utf8.decode(response.bodyBytes);
      var tickers = jsonDecode(responseBodyString);
      return Right(tickers);
    } on Exception {
      return Left(Exception('Error getting tickers'));
    }
  }

  @override
  Future<Either<Exception, Map<String, dynamic>>> getStockByTicker(
      String ticker) async {
    try {
      final response = await http.get(
        _buildUri(
            'quote/$ticker?range=1d&interval=1d&fundamental=true&dividends=true'),
        headers: _buildHeaders(),
      );
      var responseBodyString = utf8.decode(response.bodyBytes);
      var stock = jsonDecode(responseBodyString);
      return Right(stock);
    } on Exception {
      return Left(Exception('Error getting stock'));
    }
  }

  @override
  Future<Either<Exception, Map<String, dynamic>>> getStocksByTicker(
      List<String> tickers) async {
    try {
      final response = await http.get(
        _buildUri(
            'quote/${tickers.join(',')}?range=1d&interval=1d&fundamental=true&dividends=true'),
        headers: _buildHeaders(),
      );
      var responseBodyString = utf8.decode(response.bodyBytes);
      var stock = jsonDecode(responseBodyString);
      return Right(stock);
    } on Exception {
      return Left(Exception('Error getting stock'));
    }
  }
}
