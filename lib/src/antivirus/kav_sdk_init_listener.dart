/// Listener interface for Kaspersky SDK initialization events
abstract class KavSdkInitListener {

  /// Initialization failed. The given reason provides more information about
  /// the reason.
  void onInitializationFailed(String result);

  /// Kaspersky SDK successfully initialized.
  void onSdkInitialized();
}
