import 'package:full_stack_app/database/database.dart';

class Dog {
  late int? id;
  late String name;
  late int age;

  Dog({
    this.id,
    required this.name,
    required this.age,
  });

  Dog.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    age = json['age'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'age': age,
    };
  }

  static Future<int> insert(Dog dog) async {
    final db = await DBProvider.instance.database;
    return await db.insert('dogs', dog.toJson());
  }

  static Future<List<Dog>> fetchAll() async {
    final db = await DBProvider.instance.database;
    final List<Map<String, dynamic>> maps = await db.query('dogs');
    return List.generate(maps.length, (i) {
      return Dog(
        id: maps[i]['id'] as int,
        name: maps[i]['name'] as String,
        age: maps[i]['age'] as int,
      );
    });
  }

  @override
  String toString() {
    return 'Dog{id: $id, name: $name, age: $age}';
  }
}
