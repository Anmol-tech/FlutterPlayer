import 'dart:convert';

import 'package:Player/Pages/Home.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widgets/flutter_widgets.dart';
import 'package:http/http.dart';
import 'package:video_player/video_player.dart';

class OnlinePlayer extends StatefulWidget {
  OnlinePlayer({Key key}) : super(key: key);

  @override
  _OnlinePlayerState createState() => _OnlinePlayerState();
}

class _OnlinePlayerState extends State<OnlinePlayer> {
  var file;

  String videolink;
  FlickManager flickManager;

  void setUrl() async {
    final data = Data();
    if (!data.link.contains('?')) {
      setState(() {
        flickManager = FlickManager(
            videoPlayerController: VideoPlayerController.network(data.link));
      });
    } else {
      var urlAPI = 'https://q-stream-media-player.herokuapp.com/';
      var videourl = data.link;
      var response = await get(urlAPI + '?key=$videourl');
      var decoder = JsonDecoder();

      videolink = decoder.convert(response.body)['best'];
      print(videolink);

      setState(() {
        flickManager = FlickManager(
            videoPlayerController: VideoPlayerController.network(videolink));
      });
    }
  }

  @override
  void initState() {
    super.initState();
    setUrl();
    try {
      flickManager = FlickManager(
          videoPlayerController: VideoPlayerController.asset(null));
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: ObjectKey(flickManager),
      onVisibilityChanged: (visibility) {
        if (visibility.visibleFraction == 0 && this.mounted) {
          flickManager.flickControlManager.autoPause();
        } else if (visibility.visibleFraction == 1) {
          flickManager.flickControlManager.autoResume();
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: FloatingActionButton(
              child: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
            ),
          ),
          Center(
            child: Container(
              child: FlickVideoPlayer(
                flickManager: flickManager,
                flickVideoWithControls: FlickVideoWithControls(
                  controls: FlickPortraitControls(
                    iconSize: 30,
                    fontSize: 20,
                    progressBarSettings: FlickProgressBarSettings(
                      handleRadius: 10,
                      handleColor: Theme.of(context).accentColor,
                      height: 5,
                    ),
                  ),
                ),
                flickVideoWithControlsFullscreen: FlickVideoWithControls(
                  controls: FlickPortraitControls(
                    iconSize: 30,
                    fontSize: 20,
                    progressBarSettings: FlickProgressBarSettings(
                      handleRadius: 10,
                      handleColor: Theme.of(context).accentColor,
                      height: 5,
                    ),
                  ),
                  videoFit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
