import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:my_dividends/core/dependency_injection.dart';
import 'package:my_dividends/core/hive_config.dart';
import 'package:my_dividends/domain/enums/stock_dividend_type.dart';
import 'package:my_dividends/domain/enums/stock_negotiation_type.dart';
import 'package:my_dividends/domain/models/cash_dividends_model.dart';
import 'package:my_dividends/domain/models/dividend_model.dart';
import 'package:my_dividends/domain/models/outputs/stock_output_model.dart';
import 'package:my_dividends/domain/models/stock_model.dart';
import 'package:my_dividends/domain/models/stock_negotiation_model.dart';
import 'package:my_dividends/domain/repositories/my_dividends_repository.dart';
import 'package:my_dividends/infra/data_sources/imp/my_dividends_data_source_imp.dart';
import 'package:my_dividends/infra/data_sources/imp/stock_data_source_imp.dart';
import 'package:my_dividends/infra/data_sources/stock_data_source.dart';
import 'package:my_dividends/infra/repositories/imp/my_dividends_repository_imp.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_dividends/services/dividends/calculate_dividends_received_by_stock.dart';
import 'package:my_dividends/services/dividends/calculate_dividends_to_receive_by_stock.dart';

class MockMyDividendsRepository extends Mock
    implements MyDividendsRepositoryImp {}

final mockMyDividendsRepository = MockMyDividendsRepository();

StockOutputModel stockOutputModel = StockOutputModel(
  stocks: [
    StockModel(
      isinCode: "BRSANBACNOR8",
      ticker: 'SANB3',
      currentQuote: 10.0,
      name: 'Santander Brasil',
      quantity: 50,
      urlImage: 'https://s2.glbi',
      cashDividendsModel: CashDividendsModel(
        dividends: [
          DividendModel(
            stockDividendType:
                StockDividendTypeExtension.fromName('JRS CAP PROPRIO'),
            value: 1.0,
            announcementDate: DateTime(2023, 1, 1),
            paymentDate: DateTime(2023, 6, 1),
            dateWith: DateTime(2023, 2, 1),
            isinCode: "BRSANBACNOR8",
          ),
        ],
      ),
    ),
    StockModel(
      ticker: 'ITSA4',
      isinCode: "BRITSAACNOR6",
      currentQuote: 12.0,
      name: 'Itaúsa',
      quantity: 100,
      urlImage: 'https://s2.glbi',
      cashDividendsModel: CashDividendsModel(
        dividends: [
          DividendModel(
            stockDividendType:
                StockDividendTypeExtension.fromName('JRS CAP PROPRIO'),
            value: 1.0,
            announcementDate: DateTime(2023, 1, 1),
            paymentDate: DateTime(2023, 6, 1),
            dateWith: DateTime(2023, 2, 1),
            isinCode: "BRITSAACNOR6",
          ),
        ],
      ),
    ),
    StockModel(
      ticker: 'BBDC4',
      isinCode: "BRBBDCACNOR5",
      currentQuote: 15.0,
      name: 'Banco do Brasil',
      quantity: 150,
      urlImage: 'https://s2.glbi',
      cashDividendsModel: CashDividendsModel(
        dividends: [
          DividendModel(
            stockDividendType:
                StockDividendTypeExtension.fromName('JRS CAP PROPRIO'),
            value: 1.0,
            announcementDate: DateTime(2023, 1, 1),
            paymentDate: DateTime(2023, 6, 1),
            dateWith: DateTime(2023, 2, 1),
            isinCode: "BRBBDCACNOR5",
          ),
        ],
      ),
    ),
  ],
);

void main() {
  setUpAll(() async {
    await HiveConfig.start();
    DependencyInjection.load();
  });
  when(() => mockMyDividendsRepository.getAllStockNegotiationsByTicker('SANB3'))
      .thenAnswer(
    (_) async => Right(
      [
        StockNegotiationModel(
          date: DateTime(2023, 1, 1),
          quantity: 100,
          type: StockNegotiationType.buy,
          pricePerStock: 10.0,
          ticker: 'SANB3',
        ),
        StockNegotiationModel(
          date: DateTime(2023, 2, 1),
          quantity: 50,
          type: StockNegotiationType.sell,
          pricePerStock: 10.0,
          ticker: 'SANB3',
        ),
      ],
    ),
  );

  when(() => mockMyDividendsRepository.getStockByTicker('SANB3')).thenAnswer(
    (_) async => Right(
      StockModel(
        isinCode: "BRSANBACNOR8",
        ticker: 'SANB3',
        currentQuote: 10.0,
        name: 'Santander Brasil',
        quantity: 50,
        urlImage: 'https://s2.glbi',
        cashDividendsModel: CashDividendsModel(
          dividends: [
            DividendModel(
              stockDividendType:
                  StockDividendTypeExtension.fromName('JRS CAP PROPRIO'),
              value: 1.0,
              announcementDate: DateTime(2023, 1, 1),
              paymentDate: DateTime(2023, 6, 1),
              dateWith: DateTime(2023, 2, 1),
              isinCode: "BRSANBACNOR8",
            ),
            DividendModel(
              stockDividendType:
                  StockDividendTypeExtension.fromName('JRS CAP PROPRIO'),
              value: 2.0,
              announcementDate: DateTime(2023, 1, 1),
              paymentDate: DateTime(2023, 6, 1),
              dateWith: DateTime(2023, 2, 1),
              isinCode: "BRSANBACNPR5",
            ),
            DividendModel(
              stockDividendType:
                  StockDividendTypeExtension.fromName('JRS CAP PROPRIO'),
              value: 3.0,
              announcementDate: DateTime(2023, 1, 1),
              paymentDate: DateTime(2023, 6, 1),
              dateWith: DateTime(2023, 2, 1),
              isinCode: "BRSANBCDAM13",
            ),
            DividendModel(
              stockDividendType:
                  StockDividendTypeExtension.fromName('DIVIDENDO'),
              value: 1.0,
              announcementDate: DateTime(2023, 1, 1),
              paymentDate: DateTime(2023, 5, 1),
              dateWith: DateTime(2023, 3, 3),
              isinCode: "BRSANBACNOR8",
            ),
            DividendModel(
              stockDividendType:
                  StockDividendTypeExtension.fromName('DIVIDENDO'),
              value: 2.0,
              announcementDate: DateTime(2023, 1, 1),
              paymentDate: DateTime(2023, 5, 1),
              dateWith: DateTime(2023, 3, 3),
              isinCode: "BRSANBACNPR5",
            ),
            DividendModel(
              stockDividendType:
                  StockDividendTypeExtension.fromName('DIVIDENDO'),
              value: 3.0,
              announcementDate: DateTime(2023, 1, 1),
              paymentDate: DateTime(2023, 5, 1),
              dateWith: DateTime(2023, 3, 3),
              isinCode: "BRSANBCDAM13",
            ),
            DividendModel(
              stockDividendType:
                  StockDividendTypeExtension.fromName('DIVIDENDO'),
              value: 1.0,
              announcementDate: DateTime(2023, 1, 1),
              paymentDate: DateTime(2023, 1, 15),
              dateWith: DateTime(2023, 1, 5),
              isinCode: "BRSANBACNOR8",
            ),
            DividendModel(
              stockDividendType:
                  StockDividendTypeExtension.fromName('DIVIDENDO'),
              value: 2.0,
              announcementDate: DateTime(2023, 1, 1),
              paymentDate: DateTime(2023, 1, 15),
              dateWith: DateTime(2023, 1, 5),
              isinCode: "BRSANBACNPR5",
            ),
            DividendModel(
              stockDividendType:
                  StockDividendTypeExtension.fromName('DIVIDENDO'),
              value: 3.0,
              announcementDate: DateTime(2023, 1, 1),
              paymentDate: DateTime(2023, 1, 15),
              dateWith: DateTime(2023, 1, 5),
              isinCode: "BRSANBCDAM13",
            ),
            DividendModel(
              stockDividendType:
                  StockDividendTypeExtension.fromName('DIVIDENDO'),
              value: 1.0,
              announcementDate: DateTime(2023, 2, 1),
              paymentDate: DateTime(2023, 3, 31),
              dateWith: DateTime(2023, 2, 2),
              isinCode: "BRSANBACNOR8",
            ),
            DividendModel(
              stockDividendType:
                  StockDividendTypeExtension.fromName('DIVIDENDO'),
              value: 2.0,
              announcementDate: DateTime(2023, 2, 1),
              paymentDate: DateTime(2023, 3, 31),
              dateWith: DateTime(2023, 2, 2),
              isinCode: "BRSANBACNPR5",
            ),
            DividendModel(
              stockDividendType:
                  StockDividendTypeExtension.fromName('DIVIDENDO'),
              value: 3.0,
              announcementDate: DateTime(2023, 2, 1),
              paymentDate: DateTime(2023, 3, 31),
              dateWith: DateTime(2023, 2, 2),
              isinCode: "BRSANBCDAM13",
            ),
          ],
        ),
      ),
    ),
  );

  // test('StockModel', () async {
  //   var teste = await MyDividendsDataSourceImp().getAllAvailableTickers();
  //   print(teste);
  // });

  // test('StockModel 2', () async {
  //   var teste =
  //       await getDependency<MyDividendsRepository>().getStockByTicker('SANB3');
  //   teste.fold(
  //       (l) => print('erro'), (r) => print(r.cashDividendsModel?.toJson()));
  // });

  // test('Dividendos a receber', () async {
  //   var dividend =
  //       CalculateDividendsToReceiveByStock(mockMyDividendsRepository);
  //   var teste = await dividend('SANB3');
  //   expect(teste, const Right(100.0));
  // });

  // test('Dividendos recebidos', () async {
  //   var dividend = CalculateDividendsReceivedByStock(mockMyDividendsRepository);
  //   var teste = await dividend('SANB3');
  //   expect(teste, const Right(150.0));
  // });

  test('Patrimonio atual', () async {
    expect(stockOutputModel.currentEquity, 3950.0);
  });

  test('get isin code', () async {
    var output =
        await getDependency<MyDividendsRepository>().getIsinCodes('SANB4');
    print(output);
  });

  // test('StockModel 4', () async {
  //   var teste = await MyDividendsRepositoryImp(MyDividendsDataSourceImp())
  //       .getStockByTicker('SANB3');
  //   print(teste.fold((l) => print('erro'), (r) {
  //     r.stocks!.first.cashDividendsModel?.dividends?.forEach((element) {
  //       print(element.toJson());
  //     });
  //   }));
  // });

  // test('StockModel 8', () async {
  //   var teste = await getDependency<MyDividendsRepository>().getAllStocks();
  //   print(teste.fold((l) => print('erro'), (r) => print(r.length)));
  // });
}
