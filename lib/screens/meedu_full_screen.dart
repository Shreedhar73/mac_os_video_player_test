import 'package:flutter/material.dart';

class MeeduFullScreen extends StatefulWidget {
  const MeeduFullScreen({super.key});

  @override
  State<MeeduFullScreen> createState() => _MeeduFullScreenState();
}

class _MeeduFullScreenState extends State<MeeduFullScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meedu Full Screen'),
        centerTitle: true,
      ),
    );
  }
}
