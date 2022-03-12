import 'package:flutter/material.dart';
import 'package:aws_polly/aws_polly.dart';
import 'package:just_audio/just_audio.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? _url;

  final AwsPolly _awsPolly = AwsPolly.instance(
    poolId: 'us-east-1:xxxx-xxx-xxxxx',
    region: AWSRegionType.USEast1,
  );

  void onLoadUrl() async {
    setState(() => _url = null);
    final url = await _awsPolly.getUrl(
      voiceId: AWSPolyVoiceId.nicole,
      input: 'This is a sample text playing through Poly!',
    );
    setState(() => _url = url);
  }

  void onPlay() async {
    if (_url == null) return;
    final player = AudioPlayer();
    await player.setUrl(_url!);
    player.play();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter AWS Polly'),
        ),
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 8),
              ElevatedButton(
                child: Text('Load URL'),
                onPressed: onLoadUrl,
              ),
              ElevatedButton(
                child: Text('Play URL'),
                onPressed: onPlay,
              ),
              SizedBox(height: 8),
              Container(
                height: 1,
                color: Theme.of(context).primaryColor,
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(8),
                  children: <Widget>[
                    Text('URL: $_url'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
