import 'package:flutter/services.dart';
import 'package:kaspersky_sdk/src/antivirus/kav_sdk_init_listener.dart';

/// Handles the initialization of the Kaspersky SDK
class KavSdk {
  static const MethodChannel _channel =
  MethodChannel('de.berlin.tu/kaspersky_sdk/antivirus');

  /// Init the Kaspersky SDK. Attach a listener to react to events emitted by
  /// the initialization process.
  static void init(KavSdkInitListener listener) async {
    _channel.invokeMethod('init').then((success) {
      _channel.setMethodCallHandler((call) async {
        if (call.method == 'onInitializationFailed') {
          listener.onInitializationFailed(call.arguments);
        } else if (call.method == 'onSdkInitialized') {
          listener.onSdkInitialized();
        } else {
          throw UnsupportedError('Method ${call.method} is unsupported');
        }
      });
    });
  }
}
