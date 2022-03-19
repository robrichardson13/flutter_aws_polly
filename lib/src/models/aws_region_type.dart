/// These Region Types match to the AWS Regions.
///
enum AWSRegionType {
  /// `us-east-1` AWS region
  USEast1,

  /// `us-west-1` AWS region
  USWest1,

  /// `us-west-2` AWS region
  USWest2,

  /// `eu-west-1` AWS Region
  EUWest1,

  /// `eu-central-1` AWS Region
  EUCentral1,

  /// `ap-northeast-1` AWS Region
  APNortheast1,

  /// `ap-northeast-2` AWS Region
  APNortheast2,

  /// `ap-southeast-1` AWS Region
  APSoutheast1,

  /// `ap-southeast-2` AWS Region
  APSoutheast2,

  /// `sa-east-1` AWS Region
  SAEast1,

  /// `cn-north-1` AWS Region
  CNNorth1,

  /// `us-gov-west-1` AWS Region
  USGovWest1,

  /// Unknown AWS Region
  Unknown,
}

/// Extension for `AWSRegionType` to add helpers.
///
extension AWSRegionTypeExtension on AWSRegionType {
  /// Return a string for the given AWSRegionType.
  ///
  String get string {
    switch (this) {
      case AWSRegionType.USEast1:
        return 'us-east-1';
      case AWSRegionType.USWest1:
        return 'us-west-1';
      case AWSRegionType.USWest2:
        return 'us-west-2';
      case AWSRegionType.EUWest1:
        return 'eu-west-1';
      case AWSRegionType.EUCentral1:
        return 'eu-central-1';
      case AWSRegionType.APNortheast1:
        return 'ap-northeast-1';
      case AWSRegionType.APNortheast2:
        return 'ap-northeast-2';
      case AWSRegionType.APSoutheast1:
        return 'ap-southeast-1';
      case AWSRegionType.APSoutheast2:
        return 'ap-southeast-2';
      case AWSRegionType.SAEast1:
        return 'sa-east-1';
      case AWSRegionType.CNNorth1:
        return 'cn-north-1';
      case AWSRegionType.USGovWest1:
        return 'us-gov-west-1';
      default:
        throw 'Could not parse region type: $this';
    }
  }
}
