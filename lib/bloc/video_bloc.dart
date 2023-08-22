import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'video_event.dart';
part 'video_state.dart';

class VideoBloc extends Bloc<VideoEvent, VideoState> {
  VideoBloc() : super(VideoInitial()) {
    on<PlayButtonPressedEvent>(_onPlayButtonPressedEvent);
    on<VideoPausedEvent>(_onVideoPausedEvent);
    on<VideoPlayedEvent>(_onVideoPlayedEvent);
  }

  Future<void> _onPlayButtonPressedEvent(
      PlayButtonPressedEvent event, Emitter<VideoState> emit) async {
    emit(VideoPlayButtonPressed());
  }

  Future<void> _onVideoPausedEvent(
      VideoPausedEvent event, Emitter<VideoState> emit) async {
    emit(VideoPaused());
  }

  Future<void> _onVideoPlayedEvent(
      VideoPlayedEvent event, Emitter<VideoState> emit) async {
    emit(VideoPlayed());
  }
}
