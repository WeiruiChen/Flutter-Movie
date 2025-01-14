import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/generated/i18n.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/style/themestyle.dart';
import 'package:shimmer/shimmer.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    CurrentSeasonState state, Dispatch dispatch, ViewService viewService) {
  final ThemeData _theme = ThemeStyle.getTheme(viewService.context);
  Widget _buildShimmerCell() {
    return Container(
      height: Adapt.px(360),
      child: Shimmer.fromColors(
        baseColor: _theme.primaryColorDark,
        highlightColor: _theme.primaryColorLight,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: Adapt.px(30),
            ),
            Container(
              width: Adapt.px(250),
              height: Adapt.px(360),
              color: Colors.grey[200],
            ),
            SizedBox(
              width: Adapt.px(20),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: Adapt.px(200),
                  height: Adapt.px(35),
                  color: Colors.grey[200],
                ),
                SizedBox(
                  height: Adapt.px(8),
                ),
                Container(
                  width: Adapt.px(300),
                  height: Adapt.px(24),
                  color: Colors.grey[200],
                ),
                SizedBox(
                  height: Adapt.px(8),
                ),
                Container(
                  width: Adapt.screenW() - Adapt.px(340),
                  height: Adapt.px(24),
                  color: Colors.grey[200],
                ),
                SizedBox(
                  height: Adapt.px(8),
                ),
                Container(
                  width: Adapt.screenW() - Adapt.px(400),
                  height: Adapt.px(24),
                  color: Colors.grey[200],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCell() {
    if (state.nowseason == null)
      return _buildShimmerCell();
    else {
      var airdata = state.nextToAirData ?? state.lastToAirData;
      return GestureDetector(
        onTap: () => dispatch(CurrentSeasonActionCreator.onCellTapped(
            state.tvid,
            state.nowseason.seasonNumber,
            state.nowseason.name,
            state.nowseason.posterPath)),
        child: Container(
          padding: EdgeInsets.only(left: Adapt.px(20), right: Adapt.px(20)),
          child: Card(
            child: Row(
              children: <Widget>[
                Hero(
                  tag: 'seasonpic${state.nowseason.seasonNumber}',
                  child: CachedNetworkImage(
                    width: Adapt.px(250),
                    height: Adapt.px(375),
                    fit: BoxFit.cover,
                    imageUrl: state.nowseason.posterPath == null
                        ? ImageUrl.emptyimage
                        : ImageUrl.getUrl(
                            state.nowseason.posterPath, ImageSize.w300),
                  ),
                ),
                SizedBox(
                  width: Adapt.px(20),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Hero(
                        tag: 'seasonname${state.nowseason.seasonNumber}',
                        child: Material(
                          color: Colors.transparent,
                          child: Container(
                              width: Adapt.screenW() - Adapt.px(340),
                              child: Text(
                                state.nowseason.name ?? '',
                                style: TextStyle(
                                    fontSize: Adapt.px(35),
                                    fontWeight: FontWeight.bold),
                              )),
                        )),
                    Container(
                        width: Adapt.screenW() - Adapt.px(340),
                        child: RichText(
                          text: TextSpan(
                              style: TextStyle(
                                  fontSize: Adapt.px(24),
                                  fontWeight: FontWeight.bold),
                              children: [
                                TextSpan(text: airdata?.airDate ?? ''),
                                TextSpan(text: ' | '),
                                TextSpan(text: airdata?.name ?? '')
                              ]),
                        )),
                    SizedBox(
                      height: Adapt.px(10),
                    ),
                    Container(
                      width: Adapt.screenW() - Adapt.px(360),
                      child: Text(
                        state.nowseason.overview?.isNotEmpty == true
                            ? state.nowseason.overview
                            : '${state.nowseason.name} of ${state.name} premiered on ${DateFormat.yMMMd().format(DateTime.tryParse(state.nowseason.airDate ?? '1900-01-01'))}',
                        maxLines: 8,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      );
    }
  }

  return SliverToBoxAdapter(
      child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Padding(
          padding: EdgeInsets.all(Adapt.px(30)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(I18n.of(viewService.context).currentSeason,
                  style: TextStyle(
                      fontSize: Adapt.px(40), fontWeight: FontWeight.w800)),
              GestureDetector(
                child: Text(
                  'View All Seasons',
                  style: TextStyle(color: Colors.grey),
                ),
                onTap: () => dispatch(
                    CurrentSeasonActionCreator.onAllSeasonsTapped(
                        state.tvid, state.seasons)),
              )
            ],
          )),
      _buildCell()
    ],
  ));
}
