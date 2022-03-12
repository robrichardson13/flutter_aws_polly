import 'aws_polly_impl.dart';
import 'models/aws_region_type.dart';
import 'models/aws_poly_voice_id.dart';

abstract class AwsPolly {
  /// Returns a string given the [input] and [voiceId].
  ///
  /// [voiceId] defaults to `AWSPolyVoiceId.ivy'.
  ///
  Future<String> getUrl({
    required String input,
    AWSPolyVoiceId voiceId,
  });

  static AwsPolly? _instance;

  /// Create a static instance of the AwsPolly client.
  ///
  /// Calling this multiple times will return back the same instance.
  ///
  static AwsPolly instance({
    required String poolId,
    AWSRegionType region = AWSRegionType.USEast1,
  }) {
    if (_instance == null) {
      _instance = AwsPollyImpl(
        poolId: poolId,
        region: region,
      );
    }
    return _instance!;
  }
}
