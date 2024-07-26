// Extension method to add firstWhereOrNull to List
extension FirstWhereOrNullExtension<E> on List<E> {
  E? firstWhereOrNull(bool Function(E element) test) {
    for (var element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}