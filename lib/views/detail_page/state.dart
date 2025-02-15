import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movie/globalbasestate/store.dart';
import 'package:movie/models/base_api_model/account_state.dart';
import 'package:movie/models/imagemodel.dart';
import 'package:movie/models/moviedetail.dart';

class MovieDetailPageState implements Cloneable<MovieDetailPageState> {
  GlobalKey<ScaffoldState> scaffoldkey;
  int mediaId;
  String bgPic;
  MovieDetailModel detail;
  ImageModel imagesmodel;
  AccountState accountState;
  AnimationController animationController;
  ScrollController scrollController;
  bool hasStreamLink;

  @override
  MovieDetailPageState clone() {
    return MovieDetailPageState()
      ..scaffoldkey = scaffoldkey
      ..detail = detail
      ..bgPic = bgPic
      ..mediaId = mediaId
      ..imagesmodel = imagesmodel
      ..accountState = accountState
      ..animationController = animationController
      ..scrollController = scrollController
      ..hasStreamLink = hasStreamLink;
  }
}

MovieDetailPageState initState(Map<String, dynamic> args) {
  MovieDetailPageState state = MovieDetailPageState();
  state.scaffoldkey =
      GlobalKey<ScaffoldState>(debugLabel: '_MovieDetialPagekey');
  state.mediaId = args['id'];
  state.bgPic = args['bgpic'];
  state.detail = MovieDetailModel.fromParams();
  state.imagesmodel = ImageModel.fromParams(backdrops: [], posters: []);
  state.accountState = AccountState.fromParams(
      id: 0,
      uid: GlobalStore.store.getState().user?.uid,
      mediaId: state.mediaId,
      favorite: false,
      watchlist: false,
      mediaType: 'movie');
  state.hasStreamLink = false;
  return state;
}
