import 'package:freezed_annotation/freezed_annotation.dart';

part 'menu.freezed.dart';

@freezed
abstract class Menu with _$Menu {
  const factory Menu({
    required String title,
    required List<MenuItem> menus,
  }) = _Menu;
}

@freezed
abstract class MenuItem with _$MenuItem {
  const factory MenuItem({
    required String id,
    required String title,
    String? description,
    String? icon,
  }) = _MenuItem;
}
