import 'package:json_annotation/json_annotation.dart';
import 'package:kaspersky_sdk/src/easy_scanner/model/threat_info.dart';

part 'easy_result.g.dart';

/// The interface provides information about the progress of the scan performed
/// by EasyScanner.
@JsonSerializable()
class EasyResult {
  /// Counts all files that have to be scanned. If the scan was not interrupted
  /// the number returned by this method is equal to the value returned by the
  /// getFilesScanned() method after the scan is complete.
  ///
  /// You can use filesCount and filesScanned methods to calculate the progress
  /// of the scan.
  @JsonKey(defaultValue: 0)
  final int filesCount;

  /// Counts files that were scanned. If the scan was not interrupted, the
  /// number returned by this method after the scan is complete is equal to the
  /// value returned by the getFilesCount() method.
  ///
  /// You can use filesCount and filesScanned methods to calculate the progress
  /// of the scan.
  @JsonKey(defaultValue: 0)
  final int filesScanned;

  /// The list of descriptions of malware that was detected during the scan.
  @JsonKey(defaultValue: [])
  final List<ThreatInfo> malwareList;

  /// Counts objects that were scanned.
  @JsonKey(defaultValue: 0)
  final int objectsScanned;

  /// Counts objects that were skipped during scanning.
  @JsonKey(defaultValue: 0)
  final int objectsSkipped;

  /// The list of descriptions of probably infected objects and adware that were
  /// detected during the scan.
  @JsonKey(defaultValue: [])
  final List<ThreatInfo> riskwareList;

  /// Checks whether the device is rooted. The checking is performed using Root
  /// Detector feature of the SDK.
  @JsonKey(defaultValue: false)
  final bool isRooted;

  EasyResult(this.filesCount,
      this.filesScanned,
      this.malwareList,
      this.objectsScanned,
      this.objectsSkipped,
      this.riskwareList,
      this.isRooted,);

  factory EasyResult.fromJson(Map<String, dynamic> json) =>
      _$EasyResultFromJson(json);

  Map<String, dynamic> toJson() => _$EasyResultToJson(this);

  @override
  String toString() =>
      'EasyResult[filesCount=$filesCount, filesScanned=$filesScanned, objectsScanned=$objectsScanned, objectsSkipped=$objectsSkipped, malwareCount=${malwareList
          .length}, riskwareCount=${riskwareList.length}, isRooted=$isRooted]';
}
