import Flutter
import UIKit
//import AWSCore
import AWSMobileClient
import AWSPolly

public class SwiftAwsPollyPlugin: NSObject, FlutterPlugin {
  struct MethodCalls {
    static let initialize = "initialize"
    static let getUrl = "getUrl"
  }

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "aws_polly", binaryMessenger: registrar.messenger())
    let instance = SwiftAwsPollyPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case MethodCalls.initialize:
      let request = call.arguments as! [String: String]
      let poolId = request["poolId"]!
      let region = request["region"]!


      // Region of Amazon Polly.
      let AwsRegion = AWSRegionType.regionTypeForString(regionString: region)

      // Cognito pool ID. Pool needs to be unauthenticated pool with
      // Amazon Polly permissions.
      let CognitoIdentityPoolId = poolId

      // Initialize the Amazon Cognito credentials provider.
      let credentialProvider = AWSCognitoCredentialsProvider(regionType: AwsRegion, identityPoolId: CognitoIdentityPoolId)

      let configuration = AWSServiceConfiguration(region: AwsRegion, credentialsProvider: credentialProvider)
      AWSServiceManager.default().defaultServiceConfiguration = configuration
      
      result(nil)
    case MethodCalls.getUrl:
      let request = call.arguments as! [String: String]
      let text = request["input"]!
      let voiceId = request["voiceId"]!

      // First, Amazon Polly requires an input, which we need to prepare.
      // Again, we ignore the errors, however this should be handled in
      // real applications. Here we are using the URL Builder Request,
      // since in order to make the synthesis quicker we will pass the
      // presigned URL to the system audio player.
      let input = AWSPollySynthesizeSpeechURLBuilderRequest()

      // Text to synthesize
      input.text = text

      // We expect the output in MP3 format
      input.outputFormat = AWSPollyOutputFormat.mp3

      // Choose the voice ID
      input.voiceId = AWSPollyVoiceId.voiceIdForString(voiceIdString: voiceId)

      // Create an task to synthesize speech using the given synthesis input
      let builder = AWSPollySynthesizeSpeechURLBuilder.default().getPreSignedURL(input)

      // Request the URL for synthesis result
      builder.continueOnSuccessWith(block: { (awsTask: AWSTask<NSURL>) -> Any? in
        // The result of getPresignedURL task is NSURL.
        // Again, we ignore the errors in the example.
        let url = awsTask.result!

        // Try playing the data using the system AVAudioPlayer
        result(url.absoluteString)
        return nil
      })
    default:
      print("none")
    }
  }
}
