part of 'video_bloc.dart';

abstract class VideoState extends Equatable {
  const VideoState();

  @override
  List<Object> get props => [];
}

class VideoInitial extends VideoState {}

class VideoPlayButtonPressed extends VideoState {}

class VideoPaused extends VideoState {}

class VideoPlayed extends VideoState {}
