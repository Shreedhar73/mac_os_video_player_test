import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart' as explode;

class DesktopVideoScreen extends StatefulWidget {
  const DesktopVideoScreen({super.key});

  @override
  State<DesktopVideoScreen> createState() => _DesktopVideoScreenState();
}

class _DesktopVideoScreenState extends State<DesktopVideoScreen> {
  late final player = Player();
  late final controller = VideoController(player);
  final extractor = explode.YoutubeExplode();

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  Future<String> extractUrl() async {
    final streamManifest =
        await extractor.videos.streamsClient.getManifest('XKHEtdqhLK8');
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Full Screen'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 200,
            ),
            MaterialDesktopVideoControlsTheme(
              normal: const MaterialDesktopVideoControlsThemeData(
                seekBarMargin: EdgeInsets.zero,
                topButtonBar: [],
              ),
              fullscreen: const MaterialDesktopVideoControlsThemeData(
                seekBarMargin: EdgeInsets.zero,
                topButtonBar: [],
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.3,
                child: Video(
                  controller: controller,
                  controls: MaterialDesktopVideoControls,
                ),
              ),
            ),
            const SizedBox(
              height: 200,
            ),
          ],
        ),
      ),
    );
  }
}
