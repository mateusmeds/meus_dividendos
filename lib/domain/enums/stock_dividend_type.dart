enum StockDividendType {
  dividend,
  jcp,
  restCapDin,
  yield,
  none,
}

extension StockDividendTypeExtension on StockDividendType {
  static String fromEnum(StockDividendType type) {
    switch (type) {
      case StockDividendType.jcp:
        return 'JCP';
      case StockDividendType.dividend:
        return 'DIVIDENDO';
      case StockDividendType.restCapDin:
        return 'REST. CAP.';
      case StockDividendType.yield:
        return 'RENDIMENTO';
      default:
        return 'OUTROS';
    }
  }

  static StockDividendType fromName(String name) {
    switch (name) {
      case 'JRS CAP PROPRIO':
        return StockDividendType.jcp;
      case 'DIVIDENDO':
        return StockDividendType.dividend;
      case 'REST CAP DIN':
        return StockDividendType.restCapDin;
      case 'RENDIMENTO':
        return StockDividendType.yield;
      default:
        return StockDividendType.none;
    }
  }
}
