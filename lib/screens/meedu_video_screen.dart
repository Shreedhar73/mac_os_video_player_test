import 'package:flutter/material.dart';
import 'package:flutter_meedu_videoplayer/meedu_player.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class MeeduVideoScreen extends StatefulWidget {
  const MeeduVideoScreen({super.key});

  @override
  State<MeeduVideoScreen> createState() => _MeeduVideoScreenState();
}

class _MeeduVideoScreenState extends State<MeeduVideoScreen> {
  final extractor = YoutubeExplode();

  final _meeduPlayerController = MeeduPlayerController(
    controlsStyle: ControlsStyle.custom,
    autoHideControls: true,
    durations: const Durations(
      // brightnessOverlayDuration: Duration.zero,
      controlsAutoHideDuration: Duration(
        seconds: 10,
      ),
      // controlsDuration: Duration(
      //   seconds: 50,
      // ),
      videoFitOverlayDuration: Duration(
        minutes: 50,
      ),
    ),
    enabledButtons: const EnabledButtons(
      playBackSpeed: false,
      videoFit: false,
      lockControls: false,
      muteAndSound: false,
      rewindAndfastForward: false,
      pip: false,
    ),
    enabledOverlays: const EnabledOverlays(
      brightness: false,
    ),
    loadingWidget: const CircularProgressIndicator(
      color: Colors.white,
    ),
    customIcons: const CustomIcons(
      fullscreen: Icon(
        Icons.fullscreen,
        color: Colors.white,
      ),
    ),
    excludeFocus: true,
    pipEnabled: false,
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _init();
    });
  }

  _init() async {
    final url = await extractUrl();
    _meeduPlayerController.setDataSource(
      DataSource(
        type: DataSourceType.network,
        source:
            // 'https://user-images.githubusercontent.com/28951144/229373695-22f88f13-d18f-4288-9bf1-c3e078d83722.mp4',
            url,
      ),
      autoplay: false,
    );
    setState(() {});
  }

  Future<String> extractUrl() async {
    final streamManifest =
        await extractor.videos.streamsClient.getManifest('7sze1_6BGkY');
    final streamInfo = streamManifest.muxed.withHighestBitrate();
    final url = streamInfo.url.toString();
    return url;
  }

  Future<void> playVideo() async {
    await _meeduPlayerController.play();
  }

  @override
  void dispose() {
    _meeduPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meedu Video Screen'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: MeeduVideoPlayer(
              controller: _meeduPlayerController,
              customControls: (context, controller, responsive) {
                return controller.fullscreen.value == true
                    ? Column(
                        children: [
                          Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.black.withOpacity(0.7),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.access_time_outlined,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  Icon(
                                    Icons.access_time_outlined,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  Icon(
                                    Icons.access_time_outlined,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Spacer(),
                          Container(
                            height: 300,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.transparent,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: FloatingActionButton(
                                      onPressed: () {},
                                      child: const Icon(Icons.add),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  height: 5,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.7),
                                    border: Border.all(
                                      color: Colors.transparent,
                                    ),
                                  ),
                                  child: const PlayerSlider(),
                                ),
                                Container(
                                  height: 51,
                                  width: MediaQuery.of(context).size.width,
                                  color: Colors.black.withOpacity(0.7),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 15,
                                    ),
                                    child: Row(
                                      children: [
                                        IconButton(
                                          onPressed: () async {
                                            await controller.togglePlay();
                                          },
                                          icon: RxBuilder(
                                            (context) => Icon(
                                              _meeduPlayerController
                                                      .playerStatus.playing
                                                  ? Icons.pause
                                                  : Icons.play_arrow,
                                              size: 30,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        RxBuilder(
                                          (context) => Text(
                                            _meeduPlayerController.duration
                                                        .value.inMinutes >=
                                                    60
                                                ? '${printDurationWithHours(_meeduPlayerController.position.value)} / ${printDurationWithHours(
                                                    _meeduPlayerController
                                                        .duration.value,
                                                  )}'
                                                : '${printDuration(_meeduPlayerController.position.value)} / ${printDuration(_meeduPlayerController.duration.value)}',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: responsive.fontSize(),
                                            ),
                                          ),
                                        ),
                                        const Spacer(),
                                        IconButton(
                                          onPressed: () {
                                            controller
                                                .toggleFullScreen(context);
                                          },
                                          icon: const Icon(
                                            Icons.fullscreen,
                                            color: Colors.white,
                                            size: 30,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height: 56,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(
                                  color: Colors.transparent,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 5,
                                      // width:
                                      //     MediaQuery.of(context).size.width * 1,
                                      color: Colors.black.withOpacity(0.7),
                                      child: const PlayerSlider(),
                                    ),
                                  ),
                                  Container(
                                    height: 51,
                                    width:
                                        MediaQuery.of(context).size.width * 1,
                                    color: Colors.black.withOpacity(0.7),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                      ),
                                      child: Row(
                                        children: [
                                          IconButton(
                                            onPressed: () async {
                                              await controller.togglePlay();
                                            },
                                            icon: RxBuilder(
                                              (context) => Icon(
                                                _meeduPlayerController
                                                        .playerStatus.playing
                                                    ? Icons.pause
                                                    : Icons.play_arrow,
                                                size: responsive.iconSize(),
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          RxBuilder(
                                            (context) => Text(
                                              _meeduPlayerController.duration
                                                          .value.inMinutes >=
                                                      60
                                                  ? '${printDurationWithHours(_meeduPlayerController.position.value)} / ${printDurationWithHours(
                                                      _meeduPlayerController
                                                          .duration.value,
                                                    )}'
                                                  : '${printDuration(_meeduPlayerController.position.value)} / ${printDuration(_meeduPlayerController.duration.value)}',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: responsive.fontSize(),
                                              ),
                                            ),
                                          ),
                                          const Spacer(),
                                          IconButton(
                                            onPressed: () {
                                              controller
                                                  .toggleFullScreen(context);
                                            },
                                            icon: Icon(
                                              Icons.fullscreen,
                                              color: Colors.white,
                                              size: responsive.iconSize(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
              },
            ),
          ),
        ],
      ),
    );
  }

  String printDuration(Duration? duration) {
    if (duration == null) return "--:--";

    String twoDigits(int n) => n.toString().padLeft(2, "0");

    String twoDigitMinutes = twoDigits(duration.inMinutes).replaceAll("-", "");
    String twoDigitSeconds =
        twoDigits(duration.inSeconds.remainder(60)).replaceAll("-", "");
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  String printDurationWithHours(Duration? duration) {
    if (duration == null) return "--:--:--";

    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitHours = twoDigits(duration.inHours);
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitHours:$twoDigitMinutes:$twoDigitSeconds";
  }
}

class PlayerSlider extends StatelessWidget {
  const PlayerSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _ = MeeduPlayerController.of(context);
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        LayoutBuilder(builder: (ctx, constraints) {
          return RxBuilder(
            //observables: [_.buffered, _.duration],
            (__) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                color: Colors.grey,
                width: constraints.maxWidth * _.bufferedPercent.value,
                height: 10,
              );
            },
          );
        }),
        RxBuilder(
          //observables: [_.sliderPosition, _.duration],
          (__) {
            final double value =
                _.sliderPosition.value.inMilliseconds.toDouble();
            final double max = _.duration.value.inMilliseconds.toDouble();
            // if (value > max || max <= 0) {
            //   return Container();
            // }
            return Container(
              constraints: const BoxConstraints(
                maxHeight: 30,
              ),
              padding: const EdgeInsets.only(bottom: 8),
              alignment: Alignment.center,
              child: SliderTheme(
                data: SliderThemeData(
                  trackShape: MSliderTrackShape(),
                  thumbColor: Colors.transparent,
                  activeTrackColor: Colors.red,
                  trackHeight: 10,
                  thumbShape:
                      const RoundSliderThumbShape(enabledThumbRadius: 0.0),
                ),
                child: Slider(
                  min: 0,
                  divisions: null,
                  value: value,
                  inactiveColor: Colors.transparent,
                  onChangeStart: (v) {
                    _.onChangedSliderStart();
                  },
                  onChangeEnd: (v) {
                    _.onChangedSliderEnd();
                    _.seekTo(
                      Duration(milliseconds: v.floor()),
                    );
                  },
                  label: printDuration(_.sliderPosition.value),
                  max: max,
                  onChanged: _.onChangedSlider,
                ),
              ),
            );
          },
        )
      ],
    );
  }
}

class MSliderTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    SliderThemeData? sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    const double trackHeight = 2;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2 + 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
