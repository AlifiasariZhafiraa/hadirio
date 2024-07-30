class MyDropdownItem {
  String value;
  String? id;

  MyDropdownItem({
    required this.value,
    this.id,
  });

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MyDropdownItem &&
            other.value == value &&
            other.id == id);
  }

  @override
  int get hashCode => Object.hash(value, id);
}
