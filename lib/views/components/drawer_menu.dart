import 'package:flutter/material.dart';
import 'package:full_stack_app/database/database.dart';
import 'package:full_stack_app/helpers/constant.dart';
import 'package:full_stack_app/helpers/general.dart';
import 'package:full_stack_app/models/dog.dart';
import 'package:full_stack_app/views/widgets/dog/dog_view_list.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      surfaceTintColor: Theme.of(context).primaryColor,
      backgroundColor: Theme.of(context).primaryColor,
      width: MediaQuery.of(context).size.width * 0.7,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/images/logo.png'),
              fit: BoxFit.contain,
            )),
            child: Text(''),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: ListTile(
                leading: const Icon(
                  Icons.pets,
                  color: Colors.white,
                ),
                title: const Text(
                  DrawerConstants.crudDog,
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  fetchDogsAndNavigate(context);
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(
                      width: 0.5,
                      color: Colors.white,
                    )),
              )),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: ListTile(
                leading: const Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                title: const Text(
                  SingInFormConstants.logout,
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(
                      width: 0.5,
                      color: Colors.white,
                    )),
              )),
        ],
      ),
    );
  }

  void fetchDogsAndNavigate(BuildContext context) async {
    final dogs = await Dog.fetchAll();
    Route<dynamic> route = MaterialPageRoute<dynamic>(
        builder: (context) => DogViewList(dogs: dogs));
    Navigator.pop(context);
    await Navigator.push(context, route);
  }
}
