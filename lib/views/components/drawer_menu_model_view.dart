import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:full_stack_app/database/repositories/user_repository.dart';
import 'package:full_stack_app/helpers/constant.dart';
import 'package:full_stack_app/helpers/general.dart';
import 'package:full_stack_app/helpers/network.dart';
import 'package:full_stack_app/http/location_api.dart';
import 'package:full_stack_app/models/dog.dart';
import 'package:full_stack_app/models/user_sign_in.dart';
import 'package:full_stack_app/views/widgets/dog/dog_view_list.dart';
import 'package:full_stack_app/views/widgets/location/location_view_list.dart';
import 'package:full_stack_app/views/widgets/map/main_view.dart';
import 'package:full_stack_app/views/widgets/snackbar.dart';
import 'package:http/http.dart';

Widget getDrawerHeader(AsyncValue<UserSignIn?> appNameAsyncValue) {
  return DrawerHeader(
    decoration: const BoxDecoration(
        image: DecorationImage(
      image: AssetImage('assets/images/logo.png'),
      fit: BoxFit.contain,
    )),
    child: Stack(
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: appNameAsyncValue.when(
              data: (value) => Text(
                    value?.name ?? 'Desconocido',
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
              error: (err, stack) {
                showError(err.toString());
                return Text('Error: $err');
              },
              loading: () => const CircularProgressIndicator()),
        ),
      ],
    ),
  );
}

Widget getDogSelectMenu(BuildContext context) {
  return Padding(
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
      ));
}

void fetchDogsAndNavigate(BuildContext context) async {
  final dogs = await Dog.fetchAll();
  Route<dynamic> route =
      MaterialPageRoute<dynamic>(builder: (context) => DogViewList(dogs: dogs));
  if (!context.mounted) return;
  Navigator.of(context).pop(context);
  Navigator.push(context, route);
}

Widget getLocationSelectMenu(BuildContext context, Client httpClient) {
  return Padding(
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
          fetchLocationsAndNavigate(context, httpClient);
        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(
              width: 0.5,
              color: Colors.white,
            )),
      ));
}

Future<void> fetchLocationsAndNavigate(
    BuildContext context, Client httpClient) async {
  try {
    if (!(await Network.isConnected())) {
      showError(SingInFormConstants.loginErrors);
      return;
    }
    LocationApi locationApi = LocationApi(httpClient: httpClient);
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

Widget getLogoutSelectMenu(
    BuildContext context, UserRepository userRepository) {
  return Padding(
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
          await userRepository.deleteAll();
          if (!context.mounted) return;
          await replacementToRouteNamed(false, 'login', context);
        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(
              width: 0.5,
              color: Colors.white,
            )),
      ));
}

Widget getMapSelectMenu(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
    child: ListTile(
      leading: const Icon(
        Icons.map,
        color: Colors.white,
      ),
      title: const Text(
        DrawerConstants.map,
        style: TextStyle(color: Colors.white),
      ),
      onTap: () {
        Route<dynamic> route = MaterialPageRoute<dynamic>(builder: (context) => const MapMainPage());
        if (!context.mounted) return;
        Navigator.of(context).pop(context);
        Navigator.push(context, route);
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(
          width: 0.5,
          color: Colors.white,
        )),
    ),
  );
}
