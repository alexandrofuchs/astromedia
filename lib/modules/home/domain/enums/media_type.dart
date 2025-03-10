import 'package:astromedia/core/helpers/extensions/list_extension.dart';

enum MediaType {
  image("image"),
  video("video"),
  none("");

  final String value;

  const MediaType(this.value);

  factory MediaType.fromValue(String value) =>
      MediaType.values.firstWhereOrNull((e) => e.value == value) ??
      MediaType.none;
}