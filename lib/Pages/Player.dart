import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:Player/Pages/Home.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widgets/flutter_widgets.dart';
import 'package:http/http.dart';
import 'package:video_player/video_player.dart';

class DefaultPlayer extends StatefulWidget {
  DefaultPlayer({Key key}) : super(key: key);

  @override
  _DefaultPlayerState createState() => _DefaultPlayerState();
}

class _DefaultPlayerState extends State<DefaultPlayer> {
  var file;

  var videolink;
  FlickManager flickManager;

  getFile() async {
    file = await FilePicker.getFile();
  }

  void setUrl() async {
    var urlAPI = 'https://q-stream-media-player.herokuapp.com/';
    final data = Data();
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

  @override
  void initState() {
    super.initState();
    setUrl();
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
      child: Container(
        child: FlickVideoPlayer(
          flickManager: flickManager,
          flickVideoWithControls: FlickVideoWithControls(
            controls: FlickPortraitControls(),
          ),
          flickVideoWithControlsFullscreen: FlickVideoWithControls(
            controls: FlickLandscapeControls(),
          ),
        ),
      ),
    );
  }
}
