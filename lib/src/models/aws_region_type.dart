enum AWSRegionType {
  USEast1,
  USWest1,
  USWest2,
  EUWest1,
  EUCentral1,
  APNortheast1,
  APNortheast2,
  APSoutheast1,
  APSoutheast2,
  SAEast1,
  CNNorth1,
  USGovWest1,
  Unknown,
}

extension AWSRegionTypeExtension on AWSRegionType {
  /// Return a string for the given AWSRegionType
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
