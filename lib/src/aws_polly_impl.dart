import 'dart:async';

import 'package:aws_polly/aws_polly.dart';
import 'package:flutter/services.dart';

class _MethodCalls {
  static final initialize = 'initialize';
  static final getUrl = 'getUrl';
}

class AwsPollyImpl implements AwsPolly {
  static const MethodChannel _channel = const MethodChannel('aws_polly');
  final String poolId;
  final AWSRegionType region;

  AwsPollyImpl({
    this.poolId,
    this.region,
  }) {
    _initialize();
  }

  void _initialize() async {
    Map<String, String> request = {
      'poolId': poolId,
      'region': region.string,
    };

    await _channel.invokeMethod(_MethodCalls.initialize, request);
  }

  Future<String> getUrl({
    String input,
    AWSPolyVoiceId voiceId = AWSPolyVoiceId.ivy,
  }) async {
    Map<String, String> request = {
      'input': input,
      'voiceId': voiceId.string,
    };
    return await _channel.invokeMethod(_MethodCalls.getUrl, request);
  }
}
