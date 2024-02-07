class UserLocation {
  late double latitude;
  late double longitude;

  UserLocation({required this.latitude, required this.longitude});

  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
      };
}
