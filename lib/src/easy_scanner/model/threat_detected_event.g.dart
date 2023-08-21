// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'threat_detected_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ThreatDetectedEvent _$ThreatDetectedEventFromJson(Map json) =>
    ThreatDetectedEvent(
      EasyObject.fromJson(Map<String, dynamic>.from(json['object'] as Map)),
      ThreatInfo.fromJson(Map<String, dynamic>.from(json['threat'] as Map)),
    );

Map<String, dynamic> _$ThreatDetectedEventToJson(
        ThreatDetectedEvent instance) =>
    <String, dynamic>{
      'object': instance.object,
      'threat': instance.threat,
    };
