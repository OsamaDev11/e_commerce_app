const String _currencySymbol = '\$';

extension PriceFormatter on num {
  String get asPrice => '$_currencySymbol${toStringAsFixed(2)}';
}
