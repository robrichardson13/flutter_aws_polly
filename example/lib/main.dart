import 'package:flutter/material.dart';
import 'package:aws_polly/aws_polly.dart';
import 'package:just_audio/just_audio.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _url = 'Unknown';
  final AwsPolly _awsPolly = AwsPolly.instance(
    poolId: 'us-east-1:ed12259f-71b9-4e14-97fb-cf9983d326d4',
    region: AWSRegionType.USEast1,
  );

  void onPlay() async {
    final url = await _awsPolly.getUrl(
      voiceId: AWSPolyVoiceId.nicole,
      input: 'Rob Richardson is super cool',
    );
    setState(() => _url = url);
    final player = AudioPlayer();
    await player.setUrl(url);
    player.play();
  }

//TODO, add functionality to generate the URL + play the url separately

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: ListView(
            children: <Widget>[
              // Text('Url: $_url'),
              FlatButton(
                child: Text('Play'),
                onPressed: onPlay,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
