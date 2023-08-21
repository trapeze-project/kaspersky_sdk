// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'threat_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ThreatInfo _$ThreatInfoFromJson(Map json) => ThreatInfo(
      (json['categories'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$VerdictCategoryEnumMap, e))
              .toList() ??
          [],
      json['fileFullPath'] as String? ?? '',
      json['objectName'] as String? ?? '',
      json['packageName'] as String? ?? '',
      $enumDecodeNullable(_$SeverityLevelEnumMap, json['severityLevel']) ??
          SeverityLevel.Unspecified,
      json['virusName'] as String? ?? '',
      json['isApplication'] as bool? ?? false,
      json['isCloudCheckFailed'] as bool? ?? false,
      json['isDeviceAdminThreat'] as bool? ?? false,
    );

Map<String, dynamic> _$ThreatInfoToJson(ThreatInfo instance) =>
    <String, dynamic>{
      'categories':
          instance.categories.map((e) => _$VerdictCategoryEnumMap[e]).toList(),
      'fileFullPath': instance.fileFullPath,
      'objectName': instance.objectName,
      'packageName': instance.packageName,
      'severityLevel': _$SeverityLevelEnumMap[instance.severityLevel],
      'virusName': instance.virusName,
      'isApplication': instance.isApplication,
      'isCloudCheckFailed': instance.isCloudCheckFailed,
      'isDeviceAdminThreat': instance.isDeviceAdminThreat,
    };

const _$VerdictCategoryEnumMap = {
  VerdictCategory.Adware: 'Adware',
  VerdictCategory.DestructiveMalware: 'DestructiveMalware',
  VerdictCategory.Monitor: 'Monitor',
  VerdictCategory.PswTool: 'PswTool',
  VerdictCategory.RemoteAdmin: 'RemoteAdmin',
  VerdictCategory.Unknown: 'Unknown',
};

const _$SeverityLevelEnumMap = {
  SeverityLevel.High: 'High',
  SeverityLevel.Informational: 'Informational',
  SeverityLevel.Low: 'Low',
  SeverityLevel.Medium: 'Medium',
  SeverityLevel.Unspecified: 'Unspecified',
};
