import 'package:kaspersky_sdk/src/easy_scanner/model/easy_object.dart';
import 'package:kaspersky_sdk/src/easy_scanner/model/easy_result.dart';
import 'package:kaspersky_sdk/src/easy_scanner/model/easy_status.dart';
import 'package:kaspersky_sdk/src/easy_scanner/model/threat_info.dart';

abstract class EasyListener {
  /// Called when the Easy Scanner has finished calculating the number of files
  /// to be scanned.
  void onFilesCountCalculated(int fileCount);

  /// Called when the Easy Scanner has detected a malware object. An object can
  /// be a file, an archive, or a file in an archive.
  void onMalwareDetected(EasyObject object, ThreatInfo threat);

  /// Called when the Easy Scanner starts processing an object. An object can be
  /// a file, an archive, or a file in an archive.
  void onObjectBegin(EasyObject object);

  /// Called when the Easy Scanner has finished processing an object. An object
  /// can be a file, an archive, or a file in an archive.
  void onObjectEnd(EasyObject object, EasyStatus status);

  /// Called when the Easy Scanner has detected a probably infected object or
  /// adware. An object can be a file, an archive, or a file in an archive.
  void onRiskwareDetected(EasyObject object, ThreatInfo threat);

  /// Called when the Easy Scanner has detected that the device is rooted.
  void onRooted();

  /// Called when the Easy Scanner finished scanning
  void onFinished(EasyResult result);

  /// Called when the Easy Scanner has an error
  void onError(String message);
}
