extension IterableExtension<T> on Iterable<T> {
  T? firstWhereOrNull(bool Function(T element) test) {
    for (var element in this) {
      if (test(element)) return element;
    }
    return null;
  }

  Iterable<T> copy() {
    return map((e) => e);
  }
}

extension NullIterableExtension<T> on Iterable<T>? {
  bool get isNullOrEmpty {
    return this == null || this!.isEmpty;
  }
}

extension ListEquality<T> on List<T> {
  bool strongEquals(List<T> other) {
    if (length != other.length) {
      return false;
    }

    final first = this;
    final second = other;
    for (int i = 0; i < first.length; i++) {
      if (first[i] != second[i]) {
        return false;
      }
    }

    return true;
  }
}

extension CurrencyPrinter on double {
  String currencyString() {
    return toStringAsFixed(4).replaceAll('.', ',');
  }
}
