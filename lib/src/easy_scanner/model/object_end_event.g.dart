// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'object_end_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ObjectEndEvent _$ObjectEndEventFromJson(Map json) => ObjectEndEvent(
      EasyObject.fromJson(Map<String, dynamic>.from(json['object'] as Map)),
      $enumDecode(_$EasyStatusEnumMap, json['status']),
    );

Map<String, dynamic> _$ObjectEndEventToJson(ObjectEndEvent instance) =>
    <String, dynamic>{
      'object': instance.object,
      'status': _$EasyStatusEnumMap[instance.status],
    };

const _$EasyStatusEnumMap = {
  EasyStatus.AccessDenied: 'AccessDenied',
  EasyStatus.Canceled: 'Canceled',
  EasyStatus.Ok: 'Ok',
  EasyStatus.Skipped: 'Skipped',
  EasyStatus.UnknownError: 'UnknownError',
  EasyStatus.WriteError: 'WriteError',
};
