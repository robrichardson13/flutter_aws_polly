import 'package:flutter/foundation.dart';

import 'aws_polly_impl.dart';
import 'models/aws_region_type.dart';
import 'models/aws_poly_voice_id.dart';

abstract class AwsPolly {
  Future<String> getUrl({
    @required String input,
    @required AWSPolyVoiceId voiceId,
  });

  static AwsPolly _instance;
  static AwsPolly instance({
    @required String poolId,
    @required AWSRegionType region,
  }) {
    if (_instance == null) {
      _instance = AwsPollyImpl(
        poolId: poolId,
        region: region,
      );
    }
    return _instance;
  }
}
