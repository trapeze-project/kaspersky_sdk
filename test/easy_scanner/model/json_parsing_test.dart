import 'package:flutter_test/flutter_test.dart';
import 'package:kaspersky_sdk/kaspersky_sdk.dart';
import 'package:kaspersky_sdk/src/easy_scanner/model/object_end_event.dart';
import 'package:kaspersky_sdk/src/easy_scanner/model/threat_detected_event.dart';

void main() {
  group('JSON Parsing Tests', () {
    group('Null Values', () {
      test('Easy Object', () {
        Map<String, dynamic> json = {};
        EasyObject easyObject = EasyObject.fromJson(json);
        expect(easyObject.fileFullPath, '');
        expect(easyObject.objectName, '');
        expect(easyObject.packageName, '');
      });
      test('Easy Result', () {
        Map<String, dynamic> json = {};
        EasyResult easyResult = EasyResult.fromJson(json);
        expect(easyResult.filesCount, 0);
        expect(easyResult.filesScanned, 0);
        expect(easyResult.malwareList, []);
        expect(easyResult.objectsScanned, 0);
        expect(easyResult.objectsSkipped, 0);
        expect(easyResult.riskwareList, []);
        expect(easyResult.isRooted, false);
      });
      test('Object End Event', () {
        Map<String, dynamic> json = {};
        try {
          ObjectEndEvent.fromJson(json);
        } catch (e) {
          expect(e.runtimeType.toString(), '_CastError');
        }
      });
      test('Threat Detected Event', () {
        Map<String, dynamic> json = {};
        try {
          ThreatDetectedEvent.fromJson(json);
        } catch (e) {
          expect(e.runtimeType.toString(), '_CastError');
        }
      });
      test('Threat Info', () {
        Map<String, dynamic> json = {};
        ThreatInfo threatInfo = ThreatInfo.fromJson(json);
        expect(threatInfo.categories, []);
        expect(threatInfo.fileFullPath, '');
        expect(threatInfo.objectName, '');
        expect(threatInfo.packageName, '');
        expect(threatInfo.severityLevel, SeverityLevel.Unspecified);
        expect(threatInfo.virusName, '');
        expect(threatInfo.isApplication, false);
        expect(threatInfo.isCloudCheckFailed, false);
        expect(threatInfo.isDeviceAdminThreat, false);
      });
    });
  });
}
