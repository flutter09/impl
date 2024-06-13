extension ListExtension<T> on List<T> {
  List<T> modifyAt(int index, T Function(T) function) {
    if (index >= 0 && index < length) {
      List<T> newList = List.from(this);
      newList[index] = function(newList[index]);
      return newList;
    } else {
      throw RangeError.range(index, 0, length - 1, 'Index out of range');
    }
  }

  Iterable<R> mapIndexed<R>(R Function(int index, T value) f) sync* {
    int index = 0;
    for (var value in this) {
      yield f(index, value);
      index++;
    }
  }

  void updateWhere(
      bool Function(T element) condition, T Function(T element) update) {
    for (var i = 0; i < length; i++) {
      if (condition(this[i])) {
        this[i] = update(this[i]);
      }
    }
  }

  void updateFirstWhere(
      bool Function(T element) condition, T Function(T element) update) {
    for (var i = 0; i < length; i++) {
      if (condition(this[i])) {
        this[i] = update(this[i]);
        break;
      }
    }
  }

  double sum(double Function(T) getProperty) {
    if (isEmpty) {
      throw Exception("List is empty");
    }
    return map((element) => getProperty(element))
        .fold(0, (prev, amount) => prev + amount);
  }

  List<R> nonNullMap<R>(R? Function(T) transform) {
    return map((item) => transform(item)).whereType<R>().toList();
  }

  List<T> removeAndGetRest(T elementToRemove) {
    List<T> modifiedList = List.from(this);
    modifiedList.remove(elementToRemove);
    return modifiedList;
  }

  T? firstWhereOrNull(bool Function(T) test) {
    try {
      return firstWhere(test);
    } catch (e) {
      return null;
    }
  }

  double? sumOrNull(double Function(T) getProperty) {
    if (isEmpty) {
      return null;
    }
    return map((element) => getProperty(element))
        .fold(0, (prev, amount) => (prev ?? 0) + amount);
  }

  Map<K, List<T>> groupBy<K>(K Function(T) keySelector) {
    Map<K, List<T>> map = {};
    for (var element in this) {
      var key = keySelector(element);
      map.putIfAbsent(key, () => []).add(element);
    }
    return map;
  }

  Iterable<R> mapIndexedWithLength<R>(
      R Function(T element, int index, int length) f) {
    return List.generate(length, (index) => f(this[index], index, length));
  }
}
