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

  static Future<Dog> fetchById(int id) async {
    final db = await DBProvider.instance.database;
    final List<Map<String, dynamic>> maps =
        await db.query('dogs', where: 'id = ?', whereArgs: [id]);
    final dog = maps.length == 1
        ? Dog(
            id: maps[0]['id'] as int,
            name: maps[0]['name'] as String,
            age: maps[0]['age'] as int,
          )
        : throw Exception('Dog not found');
    return dog;
  }

  static Future<void> update(Dog dog) async {
    final db = await DBProvider.instance.database;
    await db.update(
      'dogs',
      dog.toJson(),
      where: 'id = ?',
      whereArgs: [dog.id],
    );
  }

  static Future<bool> delete(int id) async {
    final db = await DBProvider.instance.database;
    int count = await db.delete(
      'dogs',
      where: 'id = ?',
      whereArgs: [id],
    );
    return count > 0;
  }

  @override
  String toString() {
    return 'Dog{id: $id, name: $name, age: $age}';
  }
}
