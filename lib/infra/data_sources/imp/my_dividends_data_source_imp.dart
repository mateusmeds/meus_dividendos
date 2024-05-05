import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:my_dividends/infra/data_sources/my_dividends_data_source.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;

class MyDividendsDataSourceImp implements MyDividendsDataSource {
  final String host = "https://brapi.dev/api/";

  Uri _buildUri(String path, {String pathParams = ''}) {
    return Uri.parse(
        host + path + "?token=jZcLjNmUBWxAq4XTUgU1hi&" + pathParams);
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
          'quote/$ticker',
          pathParams: "range=1d&interval=1d&fundamental=true",
        ),
        headers: _buildHeaders(),
      );
      var responseBodyString = utf8.decode(response.bodyBytes);
      Map<String, dynamic> stock = jsonDecode(responseBodyString);
      var dividends = await _getDividendsByTicker(ticker);
      List<dynamic> stockMap = stock.values.first;
      stockMap.first['dividendsData'] = {"cashDividends": dividends};
      return Right({'results': stockMap});
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
            'quote/${tickers.join(',')}?range=1d&interval=1d&fundamental=true'),
        headers: _buildHeaders(),
      );
      var responseBodyString = utf8.decode(response.bodyBytes);
      Map<String, dynamic> stock = jsonDecode(responseBodyString);
      return Right(stock);
    } on Exception {
      return Left(Exception('Error getting stock'));
    }
  }

  Future<List<Map<String, dynamic>>> _getDividendsByTicker(
      String ticker) async {
    var response = await http
        .get(Uri.parse('http://www.dividendobr.com/lib/search.php?q=$ticker'));

    String html = response.body;

    List<Map<String, dynamic>> dividends = [];

    var document = parse(html);

    var petzElements = document.querySelectorAll('ul li a');

    for (var element in petzElements) {
      var text = element.text.trim();
      if (text.contains(ticker.substring(0, 4))) {
        var smallElement = element.querySelector('small');
        var smallText = smallElement!.innerHtml.trim();

        var info = smallText.split('<br>');

        info = info.map((e) => e.trim()).toList();

        var tipo = info[0];
        var aprovadoEm = info[1].split(':')[1].trim();
        var pagamentoEm = info[2].split(':')[1].trim();
        var dataExEm = info[3].split(':')[1].trim();
        var petzInfo = info
            .where((element) => element.contains('($ticker)'))
            .first
            .split('($ticker)')[1]
            .trim()
            .replaceAll('[', '')
            .replaceAll(']', '');

        dividends.add({
          'type': tipo,
          'approvedOn': aprovadoEm,
          'paymentDate': pagamentoEm,
          'lastDatePrior': dataExEm,
          'value': _getDividendValue(petzInfo),
        });
      }
    }
    return dividends;
  }

  double _getDividendValue(String? text) {
    if (text == null || text.isEmpty) {
      return 0;
    }
    text = adicionarVirgula(text);
    if (double.tryParse(text) != null) return double.parse(text);
    return double.parse(text.replaceAll(',', '.'));
  }

  String adicionarVirgula(String numero) {
    int posicaoVirgula = numero.indexOf(',');
    if (posicaoVirgula == -1) {
      return "0,$numero";
    } else {
      return numero;
    }
  }
}
