// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'easy_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EasyResult _$EasyResultFromJson(Map json) => EasyResult(
      json['filesCount'] as int? ?? 0,
      json['filesScanned'] as int? ?? 0,
      (json['malwareList'] as List<dynamic>?)
              ?.map((e) =>
                  ThreatInfo.fromJson(Map<String, dynamic>.from(e as Map)))
              .toList() ??
          [],
      json['objectsScanned'] as int? ?? 0,
      json['objectsSkipped'] as int? ?? 0,
      (json['riskwareList'] as List<dynamic>?)
              ?.map((e) =>
                  ThreatInfo.fromJson(Map<String, dynamic>.from(e as Map)))
              .toList() ??
          [],
      json['isRooted'] as bool? ?? false,
    );

Map<String, dynamic> _$EasyResultToJson(EasyResult instance) =>
    <String, dynamic>{
      'filesCount': instance.filesCount,
      'filesScanned': instance.filesScanned,
      'malwareList': instance.malwareList,
      'objectsScanned': instance.objectsScanned,
      'objectsSkipped': instance.objectsSkipped,
      'riskwareList': instance.riskwareList,
      'isRooted': instance.isRooted,
    };
