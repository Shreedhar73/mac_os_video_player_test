import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_realm_test/bloc/video_bloc.dart' as video;
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart' as explode;

class VideoFullScreen extends StatefulWidget {
  const VideoFullScreen({super.key});

  @override
  State<VideoFullScreen> createState() => _VideoFullScreenState();
}

class _VideoFullScreenState extends State<VideoFullScreen> {
  late final player = Player();
  late final controller = VideoController(player);
  final extractor = explode.YoutubeExplode();

  @override
  void initState() {
    super.initState();
    showTitle();
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
      Media(
        url,
      ),
    );
  }

  Future<void> showTitle() async {
    controller.player.stream.playing.listen((isPlaying) {
      if (isPlaying) {
        BlocProvider.of<video.VideoBloc>(context).add(video.VideoPlayedEvent());
      } else {
        BlocProvider.of<video.VideoBloc>(context).add(video.VideoPausedEvent());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: MaterialDesktopVideoControlsTheme(
          normal: MaterialDesktopVideoControlsThemeData(
            buttonBarButtonSize: 24.0,
            buttonBarButtonColor: Colors.white,
            displaySeekBar: false,
            bottomButtonBarMargin: EdgeInsets.zero,
            topButtonBarMargin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            // seekOnDoubleTap: true,
            seekBarHeight: 5,
            seekBarThumbSize: 0,
            seekBarMargin: EdgeInsets.zero,
            // controlsHoverDuration: const Duration(days: 1),
            primaryButtonBar: [],
            buttonBarHeight: 130,
            topButtonBar: [
              Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 1,
                    color: Colors.transparent,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                        const Spacer(),
                        MaterialDesktopCustomButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.check_circle_outline_sharp,
                          ),
                        ),
                        MaterialDesktopCustomButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.check_circle_outline_sharp,
                          ),
                        ),
                        MaterialDesktopCustomButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.check_circle_outline_sharp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
            bottomButtonBar: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: FloatingActionButton(
                      onPressed: () {},
                      child: const Icon(
                        Icons.window_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 10,
                    width: MediaQuery.of(context).size.width * 1,
                    child: const MaterialDesktopSeekBar(),
                  ),
                  Container(
                    height: 45,
                    width: MediaQuery.of(context).size.width * 1,
                    color: Colors.transparent,
                    child: const Row(
                      children: [
                        MaterialDesktopPlayOrPauseButton(
                          iconSize: 30,
                          iconColor: Colors.white,
                        ),
                        // MaterialDesktopCustomButton(
                        //   onPressed: () async {
                        //     await showTitle();
                        //     await player.playOrPause();
                        //   },
                        //   icon: const Icon(Icons.play_arrow),
                        //   iconSize: 30,
                        //   iconColor: Colors.white,
                        // ),
                        MaterialDesktopPositionIndicator(
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                        Spacer(),
                        MaterialDesktopFullscreenButton(
                          iconColor: Colors.white,
                          iconSize: 30,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          fullscreen: MaterialDesktopVideoControlsThemeData(
            buttonBarButtonSize: 24.0,
            buttonBarButtonColor: Colors.white,
            displaySeekBar: false,
            automaticallyImplySkipNextButton: false,
            automaticallyImplySkipPreviousButton: false,
            bottomButtonBarMargin: EdgeInsets.zero,
            topButtonBarMargin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            seekBarHeight: 5,
            seekBarThumbSize: 0,
            seekBarMargin: EdgeInsets.zero,
            primaryButtonBar: [],
            buttonBarHeight: 200,
            topButtonBar: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 70,
                    width: MediaQuery.of(context).size.width * 2.1,
                    color: Colors.black.withOpacity(0.3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                          width: 200,
                          child: Row(
                            children: [
                              Flexible(
                                child: Text(
                                  'Ultimate guide to typography and its importance in design',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        MaterialDesktopCustomButton(
                          onPressed: () {},
                          icon: const Icon(Icons.check_circle_outline_sharp),
                        ),
                        MaterialDesktopCustomButton(
                          onPressed: () {},
                          icon: const Icon(Icons.check_circle_outline_sharp),
                        ),
                        MaterialDesktopCustomButton(
                          onPressed: () {},
                          icon: const Icon(Icons.close),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
            bottomButtonBar: [
              Container(
                height: double.infinity,
                width: MediaQuery.of(context).size.width * 2.1,
                color: Colors.transparent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: FloatingActionButton(
                        onPressed: () {},
                        child: const Icon(
                          Icons.window_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 80,
                      width: MediaQuery.of(context).size.width * 2.1,
                      color: Colors.black.withOpacity(0.3),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                            width: MediaQuery.of(context).size.width * 2.1,
                            child: const MaterialDesktopSeekBar(),
                          ),
                          SizedBox(
                            height: 50,
                            width: MediaQuery.of(context).size.width * 2.1,
                            child: const Row(
                              children: [
                                MaterialDesktopPlayOrPauseButton(
                                  iconSize: 30,
                                  iconColor: Colors.white,
                                ),
                                MaterialDesktopPositionIndicator(
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                                Spacer(),
                                MaterialDesktopFullscreenButton(
                                  iconColor: Colors.white,
                                  iconSize: 30,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // child: Column(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   crossAxisAlignment: CrossAxisAlignment.end,
                //   children: [
                //     Padding(
                //       padding: const EdgeInsets.only(right: 10),
                //       child: FloatingActionButton(
                //         onPressed: () {},
                //         child: const Icon(
                //           Icons.window_rounded,
                //           color: Colors.white,
                //         ),
                //       ),
                //     ),
                //     Container(
                //       height: 85,
                //       width: MediaQuery.of(context).size.width * 2.1,
                //       color: Colors.green,
                //       child: Column(
                //         mainAxisAlignment: MainAxisAlignment.end,
                //         crossAxisAlignment: CrossAxisAlignment.end,
                //         children: [
                //           SizedBox(
                //             height: 10,
                //             width: MediaQuery.of(context).size.width * 2.1,
                //             child: const MaterialDesktopSeekBar(),
                //           ),
                //           Container(
                //             height: 45,
                //             width: MediaQuery.of(context).size.width * 2.1,
                //             color: Colors.transparent,
                //             child: const Row(
                //               children: [
                //                 MaterialDesktopPlayOrPauseButton(
                //                   iconSize: 30,
                //                   iconColor: Colors.white,
                //                 ),
                //                 MaterialDesktopPositionIndicator(
                //                   style: TextStyle(
                //                     color: Colors.white,
                //                     fontSize: 12,
                //                   ),
                //                 ),
                //                 Spacer(),
                //                 MaterialDesktopFullscreenButton(
                //                   iconColor: Colors.white,
                //                   iconSize: 30,
                //                 ),
                //               ],
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ],
                // ),
              ),
            ],
          ),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 1,
            child: Stack(
              children: [
                Video(
                  controller: controller,
                  controls: MaterialDesktopVideoControls,
                  fill: Colors.black,
                ),
                BlocBuilder<video.VideoBloc, video.VideoState>(
                  builder: (context, state) {
                    if (state is video.VideoPaused) {
                      return const Padding(
                        padding: EdgeInsets.only(
                          top: 300,
                          left: 20,
                          right: 20,
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Ultimate guide to typography and its importance in design',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                )
                // StreamBuilder<bool>(
                //   stream: player.stream.playing,
                //   builder: (context, snapshot) {
                //     final isPlaying = snapshot.data;
                //     if (snapshot.hasData) {
                //       return Padding(
                //         padding: const EdgeInsets.only(
                //           top: 300,
                //           left: 20,
                //           right: 20,
                //         ),
                //         child: Align(
                //           alignment: Alignment.centerLeft,
                //           child: Text(
                //             isPlaying! == false
                //                 ? 'Ultimate guide to typography and its importance in design'
                //                 : '',
                //             style: const TextStyle(
                //               color: Colors.white,
                //             ),
                //           ),
                //         ),
                //       );
                //     } else {
                //       return Container();
                //     }
                //   },
                // ),
              ],
            ),
          ),
        ),
      ),
      // bottomNavigationBar: Container(
      //   height: MediaQuery.of(context).size.height * 0.12,
      //   width: MediaQuery.of(context).size.width,
      //   color: Colors.grey,
      // ),
    );
  }
}
