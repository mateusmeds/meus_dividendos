import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:my_dividends/domain/models/isin_code_model.dart';
import 'package:my_dividends/domain/models/outputs/isin_code_output_model.dart';
import 'package:my_dividends/domain/models/stock_model.dart';
import 'package:my_dividends/infra/data_sources/stock_data_source.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class StockDataSourceImp implements StockDataSource {
  StockDataSourceImp() {
    _registerAdapter();
  }

  final String nameBox = 'my_dividends_tb_stocks';

  late Box<StockModel> context;

  Map<String, String> _buildHeaders() {
    return {'content-type': 'application/json'};
  }

  @override
  Future<Either<Exception, bool>> add(StockModel stockModel) async {
    await _openBox();
    try {
      await context.add(stockModel);
      return const Right(true);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  @override
  Future<Either<Exception, List<StockModel>>> getAll() async {
    await _openBox();
    try {
      return Right(context.values.toList());
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  @override
  Future<Either<Exception, StockModel>> getById(int key) async {
    await _openBox();
    try {
      var result =
          context.values.where((element) => element.key == key).toList().last;
      return Right(result);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  @override
  Future<Either<Exception, StockModel?>> getByTicker(String ticker) async {
    await _openBox();
    try {
      var result = context.values.where((element) => element.ticker == ticker);

      var stock = result.isNotEmpty ? result.last : null;

      return Right(stock);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  @override
  Future<Either<Exception, bool>> alter(StockModel stockModel) async {
    await _openBox();
    try {
      await context.put(stockModel.key, stockModel);
      return const Right(true);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  Future<void> _openBox() async {
    try {
      context = await Hive.openBox<StockModel>(nameBox);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  void _registerAdapter() {
    if (!Hive.isAdapterRegistered(StockModelAdapter().typeId)) {
      Hive.registerAdapter<StockModel>(StockModelAdapter());
    }
  }

  @override
  Future<Either<Exception, Map<String, dynamic>>> getIsinCodes(
      String ticker) async {
    await _openBox();
    try {
      final tickerFourDigits = ticker.substring(0, 4);

      Map<String, dynamic> jwtHeader = {
        "language": "en-us",
        "pageNumber": 1,
        "pageSize": 120,
        "company": ticker,
      };

      String jwtHeaderString =
          base64.encode(utf8.encode(jsonEncode(jwtHeader)));

      var response = await http.get(
        Uri.parse(
            "https://sistemaswebb3-listados.b3.com.br/listedCompaniesProxy/CompanyCall/GetInitialCompanies/${jwtHeaderString}"),
      );

      var responseBodyString = utf8.decode(response.bodyBytes);
      var responseDecoded = jsonDecode(responseBodyString);

      if (responseDecoded['results'] == null ||
          responseDecoded['results'].isEmpty) {
        return Left(Exception('Ticker not found'));
      }

      final List<dynamic> results = responseDecoded['results'];

      String codeCVM = "";

      for (var item in results) {
        if (item['issuingCompany'] == tickerFourDigits) {
          codeCVM = item['codeCVM'];
          break;
        }
      }

      if (codeCVM.isEmpty) {
        return Left(Exception('Ticker not found'));
      }

      jwtHeader = {
        "codeCVM": codeCVM,
        "language": "pt-br",
      };

      jwtHeaderString = base64.encode(utf8.encode(jsonEncode(jwtHeader)));
      response = await http.get(
        Uri.parse(
            "https://sistemaswebb3-listados.b3.com.br/listedCompaniesProxy/CompanyCall/GetDetail/${jwtHeaderString}"),
        headers: _buildHeaders(),
      );
      responseBodyString = utf8.decode(response.bodyBytes);
      responseDecoded = jsonDecode(responseBodyString);
      return Right(responseDecoded);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }
}
