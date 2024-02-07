import 'dart:async';

import 'package:flutter_background_service/flutter_background_service.dart';
// import 'package:full_stack_app/database/database.dart';
// import 'package:full_stack_app/database/repositories/user_repository.dart';
// import 'package:full_stack_app/helpers/general.dart';
// import 'package:full_stack_app/http/auth_interceptor.dart';
// import 'package:full_stack_app/http/services/location_api_service.dart';
// import 'package:full_stack_app/models/user_location.dart';
// import 'package:http_interceptor/http_interceptor.dart';

class LocationService {
  static const int duration = 10;

  @pragma('vm:entry-point')
  void startSyncCurrentLocationService(ServiceInstance service) async {
    Timer.periodic(const Duration(seconds: duration), (timer) {
      print('***** EN EL LocationService *****');
      // try {
      //   var location = await getCurrentLocation();
      //   var userLoggedIn = await DBProvider.instance.getCurrentUser();
      //   if (userLoggedIn == null) {
      //     throw 'User not registered on database';
      //   }
      //   var httpClient = InterceptedHttp.build(interceptors: [
      //     AuthInterceptor(userLoggedIn.token),
      //   ]);
      //   var userRepository = UserRepository(dbProvider: DBProvider.instance);
      //   var locationApi = LocationApiService(
      //       httpClient: httpClient.client!, userRepository: userRepository);
      //   var userLocation = UserLocation(
      //       latitude: location.latitude, longitude: location.longitude);
      //   locationApi.saveCurrentLocation(userLocation);
      // } catch (ex, stackTrace) {
      //   // print('***** NO SE PUDO OBTENER LA UBICACION *****');
      //   print('${ex.toString()} ${stackTrace.toString()}');
      // }
    });
  }
}
