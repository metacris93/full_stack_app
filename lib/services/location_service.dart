import 'dart:async';

import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:full_stack_app/database/database.dart';
import 'package:full_stack_app/database/repositories/user_location_repository.dart';
import 'package:full_stack_app/database/repositories/user_repository.dart';
import 'package:full_stack_app/helpers/general.dart';
import 'package:full_stack_app/helpers/network.dart';
import 'package:full_stack_app/http/auth_interceptor.dart';
import 'package:full_stack_app/http/services/location_api_service.dart';
import 'package:full_stack_app/models/user_location.dart';
import 'package:full_stack_app/exceptions/user_not_logged_in.dart';
import 'package:full_stack_app/models/user_location_request.dart';
import 'package:uuid/uuid.dart';

class LocationService {
  static const int duration = 10;

  @pragma('vm:entry-point')
  void startSyncCurrentLocationService(ServiceInstance service) async {
    Timer.periodic(const Duration(seconds: duration), (timer) async {
      try {
        var location = await getCurrentLocation();
        if (!(await Network.isConnected())) {
          var userLocationRepository =
              UserLocationRepository(dbProvider: DBProvider.instance);
          int timestamp = DateTime.now().millisecondsSinceEpoch;
          var userLocationRequest = UserLocationRequest(
              uuid: const Uuid().v4(),
              latitude: location.latitude,
              longitude: location.longitude,
              timestamp: timestamp.toString());
          await userLocationRepository.insert(userLocationRequest);
          var userList = await userLocationRepository.getAll();
          for (var user in userList) {
            print(user.toString());
          }
          print('****** No internet connection ******');
          return;
        }
        var userLoggedIn = await DBProvider.instance.getCurrentUser();
        if (userLoggedIn == null) {
          throw UserNotLoggedInException;
        }
        var userRepository = UserRepository(dbProvider: DBProvider.instance);
        var locationApi = LocationApiService(
            interceptors: [AuthInterceptor(userLoggedIn.token)],
            userRepository: userRepository);
        var userLocation = UserLocation(
            latitude: location.latitude, longitude: location.longitude);
        await locationApi.saveCurrentLocation(userLocation);
      } on UserNotLoggedInException {
        print('User not logged in.');
      } catch (ex, stackTrace) {
        print('***** startSyncCurrentLocationService *****');
        print('${ex.toString()} ${stackTrace.toString()}');
      }
    });
  }
}
