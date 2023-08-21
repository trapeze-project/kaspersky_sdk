// ignore_for_file: constant_identifier_names

/// The EasyStatus enumeration provides status codes for the result of the scan
/// performed by the Easy Scanner.
enum EasyStatus {
  /// Failed to process an object; access is denied.
  AccessDenied,

  /// Indicates that an object has not been scanned because of a time-out or
  /// because the user has canceled scanning.
  Canceled,

  /// An object has been processed successfully.
  Ok,

  /// An object has been skipped.
  Skipped,

  /// Internal scanner error.
  UnknownError,

  /// Failed to write to a temporary file created when an archive was unpacked.
  WriteError
}
