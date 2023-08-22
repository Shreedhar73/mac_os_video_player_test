part of 'video_bloc.dart';

abstract class VideoEvent extends Equatable {
  const VideoEvent();

  @override
  List<Object> get props => [];
}

class PlayButtonPressedEvent extends VideoEvent {
  @override
  List<Object> get props => [];
}

class VideoPausedEvent extends VideoEvent {
  @override
  List<Object> get props => [];
}

class VideoPlayedEvent extends VideoEvent {
  @override
  List<Object> get props => [];
}
