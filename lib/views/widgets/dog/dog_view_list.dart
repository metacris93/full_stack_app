import 'package:flutter/material.dart';
import 'package:full_stack_app/helpers/general.dart';
import 'package:full_stack_app/models/dog.dart';
import 'package:full_stack_app/views/widgets/dog/create_dog_view_app.dart';
import 'package:full_stack_app/views/widgets/dog/dog_detail_view.dart';

class DogViewList extends StatelessWidget {
  final List<Dog> dogs;
  const DogViewList({super.key, required this.dogs});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dogs',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue[900],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      // body: const Center(child: DogListView(dogs: dogs)),
      body: ListView.builder(
          itemCount: dogs.length,
          itemBuilder: (context, index) {
            return Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey,
                    width: 0.5,
                  ),
                ),
              ),
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 2, horizontal: 25),
                title: Text(dogs[index].name),
                // leading: const Icon(Icons.pets),
                // trailing: const Icon(Icons.more_vert),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DogDetailView(dog: dogs[index]),
                    ),
                  );
                },
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
        onPressed: () {
          Route<dynamic> route = MaterialPageRoute<dynamic>(
              builder: (context) => const CreateDogViewApp());
          redirectToRoute(false, route, context);
        },
        backgroundColor: Colors.blue[900],
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
