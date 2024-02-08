class UserLocationRequest {
  late int? id;
  late String uuid;
  late double latitude;
  late double longitude;
  late String timestamp;

  UserLocationRequest(
      {this.id,
      required this.uuid,
      required this.latitude,
      required this.longitude,
      required this.timestamp});

  Map<String, dynamic> toMap() => {
        'id': id,
        'uuid': uuid,
        'latitude': latitude,
        'longitude': longitude,
        'timestamp': timestamp,
      };
  UserLocationRequest.fromStorage(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    timestamp = json['timestamp'];
  }
  @override
  String toString() {
    return 'UserLocationRequest{id: $id, uuid: $uuid, latitude: $latitude, longitude: $longitude, timestamp: $timestamp}';
  }
}
