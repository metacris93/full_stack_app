import 'package:flutter/material.dart';
import 'package:full_stack_app/helpers/general.dart';
import 'package:full_stack_app/models/dog.dart';
import 'package:full_stack_app/views/widgets/dog/create_dog_view_app.dart';
import 'package:full_stack_app/views/widgets/dog/dog_detail_view.dart';
import 'package:full_stack_app/views/widgets/dog/edit_dog_view.dart';

class DogViewList extends StatefulWidget {
  final List<Dog> dogs;
  const DogViewList({Key? key, required this.dogs}) : super(key: key);

  @override
  State<DogViewList> createState() => _DogViewListState();
}

class _DogViewListState extends State<DogViewList> {
  late List<Dog> dogs;

  @override
  void initState() {
    super.initState();
    dogs = widget.dogs;
  }

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
                trailing:
                    Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                  GestureDetector(
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                EditDogView(dog: dogs[index])),
                      );
                      var updatedDogs = await Dog.fetchAll();
                      setState(() {
                        dogs = updatedDogs;
                      });
                    },
                    child: const Icon(Icons.edit),
                  ),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: () async {
                      await _showDeleteConfirmationDialog(
                          context, dogs[index].id);
                    },
                    child: const Icon(Icons.delete),
                  )
                ]),
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

  Future<void> _showDeleteConfirmationDialog(
      BuildContext context, int? dogId) async {
    showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar eliminación'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('¿Estás seguro de que quieres eliminar este elemento?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Eliminar'),
              onPressed: () {
                if (dogId != null) {
                  Dog.delete(dogId);
                  setState(() {
                    dogs.removeWhere((dog) => dog.id == dogId);
                  });
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
