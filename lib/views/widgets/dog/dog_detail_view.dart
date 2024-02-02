import 'package:flutter/material.dart';
import 'package:full_stack_app/models/dog.dart';

class DogDetailView extends StatelessWidget {
  final Dog dog;

  const DogDetailView({super.key, required this.dog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(dog.name, style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue[900],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Nombre: ${dog.name}',
              style: const TextStyle(fontSize: 22),
            ),
            Text(
              'Edad: ${dog.age}',
              style: const TextStyle(fontSize: 22),
            ),
            // Add more fields as needed
          ],
        ),
      ),
    );
  }
}
