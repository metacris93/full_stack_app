import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:full_stack_app/database/database.dart';
import 'package:full_stack_app/helpers/constant.dart';
import 'package:full_stack_app/helpers/general.dart';
import 'package:full_stack_app/helpers/network.dart';
// import 'package:full_stack_app/helpers/general.dart';
import 'package:full_stack_app/http/location_api.dart';
import 'package:full_stack_app/models/dog.dart';
import 'package:full_stack_app/views/widgets/dog/dog_view_list.dart';
import 'package:full_stack_app/views/widgets/location/location_view_list.dart';
import 'package:full_stack_app/views/widgets/snackbar.dart';

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
                  Icons.location_city,
                  color: Colors.white,
                ),
                title: const Text(
                  DrawerConstants.locations,
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  fetchLocationsAndNavigate(context);
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
                onTap: () async {
                  await replacementToRouteNamed(false, 'login', context);
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
    if (!context.mounted) return;
    Navigator.of(context).pop(context);
    Navigator.push(context, route);
  }

  Future<void> fetchLocationsAndNavigate(BuildContext context) async {
    try {
      if (!(await Network.isConnected())) {
        showError(SingInFormConstants.loginErrors);
        return;
      }
      LocationApi locationApi = LocationApi();
      final locations = await locationApi.fetchLocation();
      Route<dynamic> route = MaterialPageRoute<dynamic>(
          builder: (context) => LocationViewList(locations: locations));
      if (!context.mounted) return;
      Navigator.of(context).pop(context);
      Navigator.push(context, route);
    } catch (ex, stackTrace) {
      Fluttertoast.showToast(
          msg: '${ex.toString()} ${stackTrace.toString()}',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } finally {}
  }
}
