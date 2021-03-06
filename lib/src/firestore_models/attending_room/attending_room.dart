import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ks_flutter_commons/ks_flutter_commons.dart';

part 'attending_room.freezed.dart';
part 'attending_room.g.dart';

@freezed
class AttendingRoom with _$AttendingRoom {
  const factory AttendingRoom({
    @Default('') String roomId,
    @Default('') String partnerId,
    @AutoTimestampConverter() DateTime? updatedAt,
    @Default(0) int unreadCount,
    @Default(false) bool muteNotification,
    @Default(false) bool isBlocked,
    @Default('') String lastReadMessageId,
  }) = _AttendingRoom;

  factory AttendingRoom.fromJson(Map<String, dynamic> json) => _$AttendingRoomFromJson(json);

  factory AttendingRoom.fromDocumentSnapshot(DocumentSnapshot ds) {
    final data = ds.data()! as Map<String, dynamic>;
    return AttendingRoom.fromJson(<String, dynamic>{
      'roomId': ds.id,
      ...data,
    });
  }
}
