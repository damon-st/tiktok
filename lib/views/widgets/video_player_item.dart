import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerItem extends StatefulWidget {
  final String videoUrl;
  final String thumblain;
  const VideoPlayerItem(
      {Key? key, required this.videoUrl, required this.thumblain})
      : super(key: key);

  @override
  State<VideoPlayerItem> createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  late VideoPlayerController videoPlayerController;
  bool loading = true;
  bool isPlaying = false;
  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.network(widget.videoUrl,
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true))
      ..initialize().then((value) {
        loading = false;
        isPlaying = true;
        videoPlayerController.play();
        videoPlayerController.setLooping(true);
        videoPlayerController.setVolume(1);
        setState(() {});
      });
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      decoration: const BoxDecoration(
        color: Colors.black,
      ),
      child: loading
          ? CachedNetworkImage(
              imageUrl: widget.thumblain,
              fit: BoxFit.cover,
              width: size.width,
              height: size.height,
              placeholder: (c, r) => const SizedBox(
                width: 100,
                height: 100,
                child: Padding(
                  padding: EdgeInsets.all(50),
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 30,
                  ),
                ),
              ),
            )
          : AspectRatio(
              aspectRatio: videoPlayerController.value.aspectRatio,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  GestureDetector(
                      onTap: () {
                        resmu();
                      },
                      child: VideoPlayer(videoPlayerController)),
                  VideoProgressIndicator(videoPlayerController,
                      allowScrubbing: true),
                  Positioned(
                    bottom: size.height / 2 + -100,
                    child: AnimatedOpacity(
                      opacity: isPlaying ? 0.0 : 1.0,
                      duration: const Duration(milliseconds: 500),
                      child: InkWell(
                        onTap: () {
                          resmu();
                        },
                        child: Icon(
                          !isPlaying ? Icons.play_arrow : Icons.pause,
                          color: Colors.white,
                          size: 100,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }

  void resmu() {
    if (videoPlayerController.value.isPlaying) {
      videoPlayerController.pause();
      setState(() {
        isPlaying = false;
      });
    } else {
      videoPlayerController.play();
      isPlaying = true;
    }
    setState(() {});
  }
}
