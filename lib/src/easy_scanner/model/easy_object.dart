import 'package:json_annotation/json_annotation.dart';

part 'easy_object.g.dart';

/// The interface provides information about objects currently being scanned by
/// EasyScanner. An object can be a file, an archive, or a file in an archive. An object can also be a part of an application. In that case, getPackageName() returns not an empty string.
@JsonSerializable()
class EasyObject {
  /// The full path to the scanned file.
  @JsonKey(defaultValue: '')
  final String fileFullPath;

  /// The display name of the current object. The display name can be
  /// "fileFullPath" if the object is a file, or
  /// "fileFullPath//nestedArchive//fileInNestedArchive" if the object is a file
  /// in an archive. Archives and their content are delimited with a double
  /// slash.
  @JsonKey(defaultValue: '')
  final String objectName;

  /// The package name if the scanned object is an application; otherwise,
  /// returns an empty string.
  @JsonKey(defaultValue: '')
  final String packageName;

  EasyObject(this.fileFullPath, this.objectName, this.packageName);

  factory EasyObject.fromJson(Map<String, dynamic> json) =>
      _$EasyObjectFromJson(json);

  Map<String, dynamic> toJson() => _$EasyObjectToJson(this);
}
