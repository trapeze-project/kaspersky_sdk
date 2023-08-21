import 'package:json_annotation/json_annotation.dart';
import 'package:kaspersky_sdk/src/easy_scanner/model/severity_level.dart';
import 'package:kaspersky_sdk/src/easy_scanner/model/verdict_category.dart';

part 'threat_info.g.dart';

/// This interface is used by the SDK to provide information about detected
/// threats.
///
/// Note: the ThreatInfo object passed to the
/// FolderMonitorListenerV2.onCleanFileScanned(ThreatInfo, ThreatType) method is
/// not applicable to uninfected files and should therefore be ignored in the
/// method implementation.
@JsonSerializable()
class ThreatInfo {
  /// Set of verdict categories
  @JsonKey(defaultValue: [])
  final List<VerdictCategory> categories;

  /// The full path to the scanned file.
  @JsonKey(defaultValue: '')
  final String fileFullPath;

  /// The display name of the current object. It can be "fileFullPath" if the
  /// object is file, or it can be in "fileFullPath/fileNameInArchive" if the
  /// object is a file inside an archive.
  @JsonKey(defaultValue: '')
  final String objectName;

  /// The package name if the threat is in an installed application.
  @JsonKey(defaultValue: '')
  final String packageName;

  /// severity level for this threat
  @JsonKey(defaultValue: SeverityLevel.Unspecified)
  final SeverityLevel severityLevel;

  /// The name of the malware/riskware/adware, according to the Anti-Virus
  /// database.
  @JsonKey(defaultValue: '')
  final String virusName;

  /// true if the threat is in an installed application. Returns false if the
  /// threat is not in an installed application.
  @JsonKey(defaultValue: false)
  final bool isApplication;

  /// true if there was a connection problem during the file scan; otherwise,
  /// returns false.
  @JsonKey(defaultValue: false)
  final bool isCloudCheckFailed;

  /// true if the threat has Device Admin rights. Otherwise, returns false.
  @JsonKey(defaultValue: false)
  final bool isDeviceAdminThreat;

  ThreatInfo(this.categories,
      this.fileFullPath,
      this.objectName,
      this.packageName,
      this.severityLevel,
      this.virusName,
      this.isApplication,
      this.isCloudCheckFailed,
      this.isDeviceAdminThreat,);

  factory ThreatInfo.fromJson(Map<String, dynamic> json) =>
      _$ThreatInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ThreatInfoToJson(this);
}
