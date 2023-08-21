import 'package:json_annotation/json_annotation.dart';
import 'package:kaspersky_sdk/src/easy_scanner/model/easy_object.dart';
import 'package:kaspersky_sdk/src/easy_scanner/model/easy_status.dart';

part 'object_end_event.g.dart';

@JsonSerializable()
class ObjectEndEvent {
  final EasyObject object;
  final EasyStatus status;

  ObjectEndEvent(this.object, this.status);

  factory ObjectEndEvent.fromJson(Map<String, dynamic> json) =>
      _$ObjectEndEventFromJson(json);

  Map<String, dynamic> toJson() => _$ObjectEndEventToJson(this);
}
