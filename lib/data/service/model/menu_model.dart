class MenuModel {
  const MenuModel({required this.title, required this.menus});

  final String title;
  final List<MenuItemModel> menus;

  MenuModel.fromJson(Map<String, dynamic> json)
      : title = json['title'] as String,
        menus = (json['menus'] as List<dynamic>)
            .map((e) => MenuItemModel.fromJson(e as Map<String, dynamic>))
            .toList();
}

class MenuItemModel {
  const MenuItemModel({
    required this.id,
    required this.title,
    this.description,
    this.nextMenu,
  });

  final String id;
  final String title;
  final String? description;
  final String? nextMenu;

  MenuItemModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        title = json['title'] as String,
        description = json['description'] as String?,
        nextMenu = json['next_menu'] as String?;
}
