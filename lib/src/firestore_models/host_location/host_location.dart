import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ks_flutter_commons/ks_flutter_commons.dart';

import '../../../models.dart';

part 'host_location.freezed.dart';
part 'host_location.g.dart';

class FirestorePositionConverter implements JsonConverter<FirestorePosition, Map<String, dynamic>> {
  const FirestorePositionConverter();

  @override
  FirestorePosition fromJson(Map<String, dynamic> positionMap) {
    final geohash = (positionMap['geohash'] ?? '') as String;
    final geopoint = positionMap['geopoint'] as GeoPoint;
    return FirestorePosition(geohash: geohash, geopoint: geopoint);
  }

  @override
  Map<String, dynamic> toJson(FirestorePosition position) {
    final geohash = position.geohash;
    final geopoint = position.geopoint;
    return <String, dynamic>{
      'geohash': geohash,
      'geopoint': geopoint,
    };
  }
}

@freezed
class HostLocation with _$HostLocation {
  const factory HostLocation({
    required String hostLocationId,
    @AutoTimestampConverter() DateTime? createdAt,
    @AutoTimestampConverter() DateTime? updatedAt,
    required String title,
    required String hostId,
    required String address,
    required String description,
    required String imageURL,
    @FirestorePositionConverter() required FirestorePosition position,
  }) = _HostLocation;

  factory HostLocation.fromJson(Map<String, dynamic> json) => _$HostLocationFromJson(json);

  factory HostLocation.fromDocumentSnapshot(DocumentSnapshot ds) {
    final data = ds.data()! as Map<String, dynamic>;
    return HostLocation.fromJson(<String, dynamic>{
      'hostLocationId': ds.id,
      ...data,
    });
  }
}