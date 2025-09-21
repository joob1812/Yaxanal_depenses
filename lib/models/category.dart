class Category {
  final String name;
  final int color;
  final String icon;

  Category({required this.name, required this.color, required this.icon});

  Map<String, dynamic> toMap() {
    return {'name': name, 'color': color, 'icon': icon};
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(name: map['name'], color: map['color'], icon: map['icon']);
  }
}
