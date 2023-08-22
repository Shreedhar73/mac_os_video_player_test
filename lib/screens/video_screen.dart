import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_realm_test/bloc/video_bloc.dart' as video;
import 'package:flutter_realm_test/screens/video_full_screen.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart' as explode;

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late final player = Player();
  late final controller = VideoController(player);
  final extractor = explode.YoutubeExplode();

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   // _init();
    // });
    initializePlayer();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  Future<String> extractUrl() async {
    final streamManifest =
        await extractor.videos.streamsClient.getManifest('7sze1_6BGkY');
    final streamInfo = streamManifest.muxed.withHighestBitrate();
    final url = streamInfo.url.toString();
    return url;
  }

  Future<void> initializePlayer() async {
    final url = await extractUrl();
    player.open(
      play: false,
      Media(
        url,
        // 'https://user-images.githubusercontent.com/28951144/229373695-22f88f13-d18f-4288-9bf1-c3e078d83722.mp4',
      ),
    );
  }

  Future<void> playVideo() async {
    await controller.player.play();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Screen'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            Center(
              child: MaterialDesktopVideoControlsTheme(
                normal: MaterialDesktopVideoControlsThemeData(
                  buttonBarButtonSize: 24.0,
                  buttonBarButtonColor: Colors.white,
                  displaySeekBar: false,
                  bottomButtonBarMargin: EdgeInsets.zero,
                  seekBarHeight: 5,
                  seekBarThumbSize: 0,
                  seekBarMargin: EdgeInsets.zero,
                  primaryButtonBar: [],
                  bottomButtonBar: [
                    Column(
                      children: [
                        Container(
                          height: 5,
                          width: MediaQuery.of(context).size.width * 1,
                          padding: EdgeInsets.zero,
                          color: Colors.black.withOpacity(0.7),
                          child: const MaterialDesktopSeekBar(),
                        ),
                        Container(
                          height: 51,
                          width: MediaQuery.of(context).size.width * 1,
                          padding: EdgeInsets.zero,
                          color: Colors.black.withOpacity(0.7),
                          child: Row(
                            children: [
                              const MaterialDesktopPlayOrPauseButton(
                                iconSize: 30,
                                iconColor: Colors.white,
                              ),
                              const MaterialDesktopPositionIndicator(
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                              const Spacer(),
                              MaterialDesktopCustomButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const VideoFullScreen(),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.fullscreen),
                                iconColor: Colors.white,
                                iconSize: 30,
                              ),
                              // MaterialFullscreenButton(
                              //   iconColor: Colors.white,
                              //   iconSize: 30,
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                fullscreen: const MaterialDesktopVideoControlsThemeData(
                  // Modify theme options:
                  displaySeekBar: true,
                  automaticallyImplySkipNextButton: false,
                  automaticallyImplySkipPreviousButton: false,
                ),
                child: BlocBuilder<video.VideoBloc, video.VideoState>(
                  builder: (context, state) {
                    if (state is video.VideoInitial) {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width * 9.0 / 16.0,
                        child: Stack(
                          children: [
                            Video(
                              controller: controller,
                              controls: MaterialDesktopVideoControls,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: InkWell(
                                onTap: () async {
                                  await playVideo();
                                  if (mounted) {
                                    BlocProvider.of<video.VideoBloc>(context)
                                        .add(video.PlayButtonPressedEvent());
                                  }
                                },
                                child: const CircleAvatar(
                                  backgroundColor: Colors.black,
                                  radius: 50,
                                  child: Icon(
                                    Icons.play_arrow,
                                    color: Colors.white,
                                    size: 50,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else if (state is video.VideoPlayButtonPressed) {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width * 9.0 / 16.0,
                        child: Video(
                          controller: controller,
                          controls: MaterialDesktopVideoControls,
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await controller.player.play();
              },
              child: const Text('Play'),
            ),
          ],
        ),
      ),
    );
  }
}
