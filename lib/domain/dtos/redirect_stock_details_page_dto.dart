import 'package:my_dividends/domain/dtos/redirect_base_dto.dart';
import 'package:my_dividends/domain/models/stock_model.dart';

class RedirectStockDetailsPageDTO extends RedirectBaseDTO {
  RedirectStockDetailsPageDTO({
    required this.stock,
    required context,
    required page,
    replace = false,
    removeUntil = false,
  }) : super(
          context: context,
          replace: replace,
          removeUntil: removeUntil,
        );

  StockModel stock;
}
