// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'easy_object.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EasyObject _$EasyObjectFromJson(Map json) => EasyObject(
      json['fileFullPath'] as String? ?? '',
      json['objectName'] as String? ?? '',
      json['packageName'] as String? ?? '',
    );

Map<String, dynamic> _$EasyObjectToJson(EasyObject instance) =>
    <String, dynamic>{
      'fileFullPath': instance.fileFullPath,
      'objectName': instance.objectName,
      'packageName': instance.packageName,
    };
