import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class DisplayVideoPlayer extends StatefulWidget {
  final String videoUrl;
  const DisplayVideoPlayer({Key? key, required this.videoUrl})
      : super(key: key);

  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<DisplayVideoPlayer> {
  late VideoPlayerController controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = VideoPlayerController.network(widget.videoUrl)
      ..addListener(() {
        setState(() {});
      })
      ..setLooping(true)
      ..initialize().then((value) => controller.play());
    setLandScape();
  }

  Future setLandScape() async {
    await SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  }

  Future reset() async {
    await SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  Future<bool> avoidreturnButton() async {
    reset();
    Get.back();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: avoidreturnButton,
      child: Scaffold(
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => controller.value.isPlaying
              ? controller.pause()
              : controller.play(),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              VideoPlayerWidget(
                controller: controller,
              ),
              Positioned(child: buildIndicator()),
              Positioned(
                bottom: 5,
                right: 10,
                child: ValueListenableBuilder(
                  valueListenable: controller,
                  builder: (context, VideoPlayerValue value, child) {
                    //Do Something with the value.
                    return Text(
                      "${value.position.inMinutes.ceil()}:${value.position.inSeconds.remainder(60)}",
                      style: TextStyle(color: Colors.white),
                    );
                  },
                ),
              ),
              buildPlay(),
              Positioned(
                  top: 5,
                  left: 10,
                  child: IconButton(
                    onPressed: () {
                      reset();
                      Get.back();
                    },
                    icon: Icon(
                      Icons.close,
                      color: Colors.red,
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Widget buildIndicator() => VideoProgressIndicator(
        controller,
        allowScrubbing: true,
      );
  Widget buildPlay() => controller.value.isPlaying
      ? Container()
      : Container(
          alignment: Alignment.center,
          color: Colors.black26,
          child: Icon(Icons.play_arrow, color: Colors.white, size: 80),
        );
}

class VideoPlayerWidget extends StatelessWidget {
  final VideoPlayerController controller;
  const VideoPlayerWidget({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) =>
      controller != null && controller.value.isInitialized
          ? VideoPlayer(controller)
          : Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
}
