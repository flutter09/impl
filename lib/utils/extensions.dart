extension NonNullListExtension<T> on List<T?>? {
  List<T> getNonNullList() {
    if (this == null) {
      return [];
    }

    ///for (var item in this where((element) => element != null)):
    ///This is a list comprehension. It iterates over the elements in the list (referred to as this),
    ///filtering out elements that are not null using the where method. It creates an iterable containing the non-null elements.
    ///
    /// ...[item!]: The spread operator (...) is used to spread the elements of the iterable produced
    /// by the list comprehension into a new list. The [item!] syntax is used to ensure that each non-null element is added to
    /// the new list.
    return [for (var item in this!.where((element) => element != null)) ...[item!]];
  }
}