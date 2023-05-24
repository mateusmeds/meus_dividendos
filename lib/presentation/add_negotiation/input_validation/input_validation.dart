import 'package:my_dividends/domain/models/ticker_model.dart';
import 'package:my_dividends/utils/validation_form.dart';

class InputValidation {
  static String? validatePrice(String? value) {
    if (ValidationForm.isEmpty(value) || value == 'R\$ 0,00') {
      return 'Campo obrigatório.';
    }

    return null;
  }

  static String? validateQuantity(String? value) {
    if (ValidationForm.isEmpty(value)) {
      return 'Campo obrigatório.';
    }

    if (ValidationForm.containsSpacing(value!)) {
      return 'Não pode conter espaços.';
    }
    if (!ValidationForm.isValidUnsignedIntegerNumber(value)) {
      return 'Digite um número inteiro maior que 0.';
    }
    return null;
  }

  static String? validateTicker(String? value, List<TickerModel> tickers) {
    if (ValidationForm.isEmpty(value)) {
      return 'Campo obrigatório.';
    }
    if (ValidationForm.containsSpacing(value!)) {
      return 'Não pode conter espaços.';
    }
    if (!ValidationForm.isValidTicker(value)) {
      return 'Código inválido.';
    }
    if (!_foundTicker(value, tickers)) {
      return 'Código não encontrado.';
    }
    return null;
  }

  static String? validateDate(String? value) {
    if (ValidationForm.isEmpty(value)) {
      return 'Campo obrigatório.';
    }
    return null;
  }

  static String? validateIsinCode(String? value) {
    if (ValidationForm.isEmpty(value)) {
      return 'Campo obrigatório.';
    }
    if (ValidationForm.containsSpacing(value!)) {
      return 'Não pode conter espaços.';
    }
    return null;
  }

  static bool _foundTicker(String ticker, List<TickerModel> tickers) {
    return tickers.any((element) => element.ticker == ticker);
  }
}
