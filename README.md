# Flutter AWS Polly Plugin

This plugin is a [Flutter](https://flutter.io) wrapper for [AWS Polly](https://docs.aws.amazon.com/polly/latest/dg/what-is.html) which is a cloud service that converts text into lifelike speech.

## Getting Started

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  aws_polly: ^1.0.3
```


### AWS Console

Here are the steps to generate a functional `Pool ID` in the AWS Console

1. You must have first have an account with [AWS](https://aws.amazon.com/).
2. Go to the [Amazon Cognito](https://console.aws.amazon.com/cognito) console.
3. Click on `Manage Identity Pools` and `Create new identity pool`.
4. Name the new identity pool and make sure to check `Enable access to unauthenticated identities`.
5. After creating the pool you'll be given your `Identity pool ID`, which will look something like <em>`us-east-1:xxxx-xxx-xxxxx`</em>
6. Now we need to give our new IAM policy the correct permissions, so go to the [IAM Console](https://console.aws.amazon.com/iam/).
7. Click on Roles, find your newly created `Unauth_Role` and click it.
8. Click on `Attach policies` and search for `AmazonPollyReadOnlyAccess` and add it to the role.

## Usage

Then you just have to import the package with

```dart
import 'package:aws_polly/aws_polly.dart';
```

In order to generate a URL to play first create the client using your new poolId and region (`USEast1` is the default).

```dart
final AwsPolly _awsPolly = AwsPolly.instance(
    poolId: 'us-east-1:xxxx-xxx-xxxxx',
    region: AWSRegionType.USEast1,
);
```

Then in order to generate a new URL, simply call on the `getUrl()` function:

```dart
final url = await _awsPolly.getUrl(
    voiceId: AWSPolyVoiceId.nicole,
    input: 'This is a sample text playing through Poly!',
);
```

Be sure to check the example project to see how to turn the .mp3 URL into a playable audio file.

## Feedback

Please feel free to [give me any feedback](https://github.com/robrichardson13/flutter_aws_polly/issues) helping support this plugin !