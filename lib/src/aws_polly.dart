import 'aws_polly_impl.dart';
import 'models/aws_region_type.dart';
import 'models/aws_poly_voice_id.dart';

/// A client used to initialize the instance and generate urls from an input.
///
/// Example on how to initialize:
///
/// ```dart
/// final AwsPolly _awsPolly = AwsPolly.instance(
///   poolId: 'us-east-1:xxxx-xxx-xxxxx',
///   region: AWSRegionType.USEast1,
/// );
/// ```
///
/// Example on how to generate a url:
///
/// ```dart
/// final url = await _awsPolly.getUrl(
///   voiceId: AWSPolyVoiceId.nicole,
///   input: 'This is a sample text playing through Poly!',
/// );
/// ```
///

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
