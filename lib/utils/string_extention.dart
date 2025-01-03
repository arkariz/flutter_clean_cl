extension StringExtension on String {
  String toCamelCase() {
  final parts = split('_');
  final capitalizedParts = parts.map((part) {
    return part.isEmpty
        ? part
        : part[0].toUpperCase() + part.substring(1).toLowerCase();
  });
  return capitalizedParts.join('');
}
}