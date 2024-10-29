class Category {
  String uuid;
  String name;

  Category({required this.uuid, required this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      uuid: json['uuid'],
      name: json['name'],
    );
  }
}
