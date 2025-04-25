class MenuModel {
  const MenuModel({required this.title, required this.menus});

  final String title;
  final List<MenuItemModel> menus;

  MenuModel.fromJson(Map<String, dynamic> json)
      : title = json['title'] as String,
        menus = (json['menus'] as List<dynamic>)
            .map((e) => MenuItemModel.fromJson(e as Map<String, dynamic>))
            .toList();

  MenuModel copyWith({String? title, List<MenuItemModel>? menus}) {
    return MenuModel(
      title: title ?? this.title,
      menus: menus ?? this.menus,
    );
  }
}

class MenuItemModel {
  const MenuItemModel({
    required this.id,
    required this.title,
    this.description,
    this.image,
    this.isFavorite,
  });

  final String id;
  final String title;
  final String? description;
  final String? image;
  final bool? isFavorite;

  MenuItemModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        title = json['title'] as String,
        description = json['description'] as String?,
        image = json['image'] as String?,
        isFavorite = json['is_favorite'] as bool?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'image': image,
        'is_favorite': isFavorite,
      };

  MenuItemModel copyWith({
    String? id,
    String? title,
    String? description,
    String? image,
    bool? isFavorite,
  }) {
    return MenuItemModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      image: image ?? this.image,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
