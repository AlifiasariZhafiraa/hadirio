extension StringCasingExtension on String? {
  String toCapitalized() {
    if (this == null) {
      return '';
    } else {
      return '${this![0].toUpperCase()}${this!.substring(1).toLowerCase()}';
    }
  }

  String toCapitalized2() {
    if (this == null) {
      return '-';
    } else {
      return '${this![0].toUpperCase()}${this!.substring(1).toLowerCase()}';
    }
  }

  String toTitleCase() {
    if (this == null) {
      return '';
    }
    return this!
        .replaceAll(RegExp(' +'), ' ')
        .split(' ')
        .map((str) => str.toCapitalized())
        .join(' ');
  }

  String replaceStatus() {
    if (this == null) {
      return '-';
    }
    return this == 'Masuk' ? 'Tepat Waktu' : this!;
  }
}
