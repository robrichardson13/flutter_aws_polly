package io.robrichardson.aws_polly

import android.content.Context
import androidx.annotation.NonNull
import com.amazonaws.auth.CognitoCachingCredentialsProvider
import com.amazonaws.regions.Regions
import com.amazonaws.services.polly.AmazonPollyPresigningClient
import com.amazonaws.services.polly.model.*
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.Job
import kotlinx.coroutines.launch
import java.util.*


/** AwsPollyPlugin */
class AwsPollyPlugin: FlutterPlugin, MethodCallHandler {
    class MethodCalls {
        companion object {
            const val initialize = "initialize"
            const val getUrl = "getUrl"
        }
    }

    private lateinit var context : Context
    private lateinit var channel : MethodChannel
    private lateinit var pollyClient : AmazonPollyPresigningClient
    private val ioScope = CoroutineScope(Dispatchers.IO + Job() )

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        context = flutterPluginBinding.applicationContext
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "aws_polly")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            MethodCalls.initialize -> {
                @Suppress("UNCHECKED_CAST")
                val arguments = call.arguments as Map<String, String>
                val poolId = arguments["poolId"] as String
                val region = arguments["region"] as String

                // Region of Amazon Polly.
                val awsRegion = Regions.fromName(region)

                // Initialize the Amazon Cognito credentials provider.
                val credentialsProvider = CognitoCachingCredentialsProvider(
                    context,
                    poolId,
                    awsRegion
                )

                // Create a client that supports generation of presigned URLs.
                pollyClient = AmazonPollyPresigningClient(credentialsProvider)
            }
            MethodCalls.getUrl -> {
                @Suppress("UNCHECKED_CAST")
                val arguments = call.arguments as Map<String, String>
                val input = arguments["input"] as String
                val voiceId = arguments["voiceId"] as String

                val capitalizedVoice = voiceId.replaceFirstChar {
                    if (it.isLowerCase()) it.titlecase(
                        Locale.getDefault()
                    ) else it.toString()
                }

                val awsVoice = VoiceId.fromValue(capitalizedVoice)

                // Create speech synthesis request.
                val synthesizeSpeechPresignRequest = SynthesizeSpeechPresignRequest()
                    .withText(input)
                    .withVoiceId(awsVoice)
                    .withOutputFormat(OutputFormat.Mp3)

                ioScope.launch {
                    launch {
                        // Get the presigned URL for synthesized speech audio stream.
                        val url = pollyClient.getPresignedSynthesizeSpeechUrl(synthesizeSpeechPresignRequest)
                        result.success(url.toString())
                    }
                }
            }
            else -> result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
