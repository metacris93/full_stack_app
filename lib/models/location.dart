import 'package:json_annotation/json_annotation.dart';

part 'location.g.dart';

@JsonSerializable()
class Location {
  final int id;
  final String name;
  final String url;
  @JsonKey(name: 'user_itinerary_summary')
  final String userItinerarySummary;
  @JsonKey(name: 'tour_package_name')
  final String tourPackageName;

  Location({
    required this.id,
    required this.name,
    required this.url,
    required this.userItinerarySummary,
    required this.tourPackageName,
  });

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  Map<String, dynamic> toJson() => _$LocationToJson(this);
}
