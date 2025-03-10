extension ExtendedIterableMethods<DataType> on Iterable<DataType>? {
  DataType? firstWhereOrNull(bool Function(DataType e) test) {
    try {
      if (this == null) return null;
      final item = this!.firstWhere(test);
      return item;
    } catch (e) {
      return null;
    }
  }

  DataType? firstOrNull() {
    try {
      if (this == null) return null;
      return this!.first;
    } catch (e) {
      return null;
    }
  }

  DataType? lastOrNull() {
    try {
      if (this == null) return null;
      return this!.last;
    } catch (e) {
      return null;
    }
  }

  DataType? lastWhereOrNull(bool Function(DataType e) test) {
    try {
      if (this == null) return null;
      final item = this!.lastWhere(test);
      return item;
    } catch (e) {
      return null;
    }
  }
}
