import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:kaspersky_sdk/src/easy_scanner/easy_listener.dart';
import 'package:kaspersky_sdk/src/easy_scanner/model/easy_mode.dart';
import 'package:kaspersky_sdk/src/easy_scanner/model/easy_object.dart';
import 'package:kaspersky_sdk/src/easy_scanner/model/easy_result.dart';
import 'package:kaspersky_sdk/src/easy_scanner/model/object_end_event.dart';
import 'package:kaspersky_sdk/src/easy_scanner/model/threat_detected_event.dart';

/// The On-Demand Easy Scanner interface provides target scanning methods with
/// predefined options of the On-Demand Scanner.
///
/// NOTE: To get more information about On-Demand Scanner, refer to Scanner
/// interface.
class EasyScanner {
  static const MethodChannel _channel =
  MethodChannel('de.berlin.tu/kaspersky_sdk/easyScanner');

  /// Gets the result of the scan or current progress of the scan.
  Future<EasyResult> getResult() async {
    Map<String, dynamic>? map =
    await _channel.invokeMapMethod<String, dynamic>('getResult');
    if (map == null) {
      throw Exception('return value is null');
    }
    return EasyResult.fromJson(map);
  }

  /// Checks whether the scanning process is paused.
  Future<bool> isPaused() async {
    bool? isPaused = await _channel.invokeMethod<bool>('isPaused');
    if (isPaused == null) {
      throw Exception('return value is null');
    }
    return isPaused;
  }

  /// Checks whether the scanning process is running.
  Future<bool> isScanInProgress() async {
    bool? isPaused = await _channel.invokeMethod<bool>('isScanInProgress');
    if (isPaused == null) {
      throw Exception('return value is null');
    }
    return isPaused;
  }

  /// Pauses the scanning process.
  Future<void> pauseScan() async {
    await _channel.invokeMethod<void>('pauseScan');
  }

  /// Cancels the scanning process.
  Future<void> stopScan() async {
    await _channel.invokeMethod<void>('stopScan');
  }

  /// Resumes the scanning process after it was paused.
  Future<void> resumeScan() async {
    await _channel.invokeMethod<void>('resumeScan');
  }

  /// Starts the scanning process. The method allows you to set one of the
  /// following scan modes with predefined options:
  ///
  ///     Basic
  ///     Light
  ///     LightPlus
  ///     Recommended
  ///     Full
  ///
  /// For more information about scan modes refer to the EasyMode enumeration.
  void scan(EasyMode mode, EasyListener listener) async {
    _channel.setMethodCallHandler((call) async {
      final dynamic args = jsonDecode(jsonEncode(call.arguments));
      if (call.method == 'onFilesCountCalculated') {
        listener.onFilesCountCalculated(args as int);
      } else if (call.method == 'onMalwareDetected') {
        ThreatDetectedEvent event =
        ThreatDetectedEvent.fromJson(args as Map<String, dynamic>);
        listener.onMalwareDetected(event.object, event.threat);
      } else if (call.method == 'onObjectBegin') {
        listener
            .onObjectBegin(EasyObject.fromJson(args as Map<String, dynamic>));
      } else if (call.method == 'onObjectEnd') {
        ObjectEndEvent event =
        ObjectEndEvent.fromJson(args as Map<String, dynamic>);
        listener.onObjectEnd(event.object, event.status);
      } else if (call.method == 'onRiskwareDetected') {
        ThreatDetectedEvent event =
        ThreatDetectedEvent.fromJson(args as Map<String, dynamic>);
        listener.onRiskwareDetected(event.object, event.threat);
      } else if (call.method == 'onRooted') {
        listener.onRooted();
      } else if (call.method == 'onFinished') {
        listener.onFinished(EasyResult.fromJson(args as Map<String, dynamic>));
      } else {
        throw UnsupportedError('Method ${call.method} is unsupported');
      }
    });
    bool? success = await _channel.invokeMethod<bool>(
        'scan', mode.toString().split('.')[1]);
    if (success == null || !success) {
      listener.onError("Scan failed due to an unknown reason");
      return;
    }
    Map<String, dynamic>? json =
    await _channel.invokeMapMethod<String, dynamic>('getResult');
    if (json == null) {
      listener.onError("Scan finished but did not return an easy result");
      return;
    }
    listener.onFinished(EasyResult.fromJson(json));
  }
}
