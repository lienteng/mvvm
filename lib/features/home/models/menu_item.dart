class MenuItem {
  final int id;
  final String name;
  final String icon;
  final String route;
  final String description;
  final bool isActive;

  MenuItem({
    required this.id,
    required this.name,
    required this.icon,
    required this.route,
    required this.description,
    required this.isActive,
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      id: json['id'],
      name: json['name'],
      icon: json['icon'],
      route: json['route'],
      description: json['description'],
      isActive: json['is_active'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'icon': icon,
      'route': route,
      'description': description,
      'is_active': isActive,
    };
  }
}
