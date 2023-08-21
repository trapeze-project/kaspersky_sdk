import 'package:json_annotation/json_annotation.dart';
import 'package:kaspersky_sdk/src/easy_scanner/model/easy_object.dart';
import 'package:kaspersky_sdk/src/easy_scanner/model/threat_info.dart';

part 'threat_detected_event.g.dart';

@JsonSerializable()
class ThreatDetectedEvent {
  final EasyObject object;
  final ThreatInfo threat;

  ThreatDetectedEvent(this.object, this.threat);

  factory ThreatDetectedEvent.fromJson(Map<String, dynamic> json) =>
      _$ThreatDetectedEventFromJson(json);

  Map<String, dynamic> toJson() => _$ThreatDetectedEventToJson(this);
}
