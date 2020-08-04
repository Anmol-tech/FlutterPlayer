import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:Player/Pages/Home.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widgets/flutter_widgets.dart';

import 'package:video_player/video_player.dart';

class OfflinePlayer extends StatefulWidget {
  OfflinePlayer({Key key}) : super(key: key);

  @override
  _OfflinePlayerState createState() => _OfflinePlayerState();
}

class _OfflinePlayerState extends State<OfflinePlayer> {
  var file;

  var videolink;
  FlickManager flickManager;

  void setUrl() async {
    File file = await FilePicker.getFile(type: FileType.video);
    print(file.path);
    setState(() {
      flickManager =
          FlickManager(videoPlayerController: VideoPlayerController.file(file));
    });
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
