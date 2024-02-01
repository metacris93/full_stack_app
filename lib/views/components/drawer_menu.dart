import 'package:flutter/material.dart';

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
                  Icons.logout,
                  color: Colors.white,
                ),
                title: const Text(
                  'Cerrar Sesión',
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
              ))
        ],
      ),
    );
  }
}
