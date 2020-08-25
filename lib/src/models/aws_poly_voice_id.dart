enum AWSPolyVoiceId {
  ivy,
  joanna,
  joey,
  justin,
  kendra,
  kimberly,
  matthew,
  salli,
  nicole,
  russell,
  amy,
  brian,
  emma,
}

extension AWSPolyVoiceIdExtension on AWSPolyVoiceId {
  /// Return a string for the given AWSPollyVoiceId
  ///
  String get string => this.toString().split('.').last;
}
