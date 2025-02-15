import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/base_api_model/movie_comment.dart';
import 'package:movie/models/base_api_model/movie_stream_link.dart';

import 'action.dart';
import 'state.dart';

Reducer<LiveStreamPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<LiveStreamPageState>>{
      LiveStreamPageAction.action: _onAction,
      LiveStreamPageAction.setStreamLinks: _setStreamLinks,
      LiveStreamPageAction.commentChanged: _commentChanged,
      LiveStreamPageAction.setComment: _setComment,
      LiveStreamPageAction.insertComment: _insertComment,
      LiveStreamPageAction.videoPlayerUpdate: _videoPlayerUpdate
    },
  );
}

LiveStreamPageState _onAction(LiveStreamPageState state, Action action) {
  final LiveStreamPageState newState = state.clone();
  return newState;
}

LiveStreamPageState _videoPlayerUpdate(
    LiveStreamPageState state, Action action) {
  final LiveStreamPageState newState = state.clone();
  newState.chewieController = state.chewieController;
  newState.streamAddress = state.streamAddress;
  return newState;
}

LiveStreamPageState _setComment(LiveStreamPageState state, Action action) {
  final MovieComments comments = action.payload;
  final LiveStreamPageState newState = state.clone();
  newState.comments = comments;
  return newState;
}

LiveStreamPageState _insertComment(LiveStreamPageState state, Action action) {
  final MovieComment comment = action.payload;
  final LiveStreamPageState newState = state.clone();
  if (newState.comments != null) newState.comments.data.insert(0, comment);
  return newState;
}

LiveStreamPageState _commentChanged(LiveStreamPageState state, Action action) {
  final String comment = action.payload;
  final LiveStreamPageState newState = state.clone();
  newState.comment = comment;
  return newState;
}

LiveStreamPageState _setStreamLinks(LiveStreamPageState state, Action action) {
  final List<MovieStreamLink> streamLinks = action.payload ?? [];
  final LiveStreamPageState newState = state.clone();
  newState.streamLinks = streamLinks;
  return newState;
}
