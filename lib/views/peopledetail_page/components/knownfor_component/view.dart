import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/generated/i18n.dart';
import 'package:movie/models/combinedcredits.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/models/enums/media_type.dart';
import 'package:movie/style/themestyle.dart';
import 'package:movie/views/peopledetail_page/action.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../style/themestyle.dart';
import 'state.dart';

Widget buildView(
    KnownForState state, Dispatch dispatch, ViewService viewService) {
  final ThemeData _theme = ThemeStyle.getTheme(viewService.context);
  Widget _buildknowforCell(CastData d) {
    return GestureDetector(
        key: ValueKey('knowforCell${d.id}'),
        onTap: () => dispatch(PeopleDetailPageActionCreator.onCellTapped(
            d.id,
            d.backdropPath,
            d.title ?? d.name,
            d.posterPath,
            d.mediaType == 'movie' ? MediaType.movie : MediaType.person)),
        child: Container(
          margin: EdgeInsets.only(left: Adapt.px(20)),
          width: Adapt.px(240),
          height: Adapt.px(400),
          child: Card(
            elevation: 1.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: Adapt.px(240),
                  height: Adapt.px(342),
                  decoration: BoxDecoration(
                      color: _theme.primaryColorLight,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: CachedNetworkImageProvider(
                            ImageUrl.getUrl(d.posterPath, ImageSize.w300)),
                      )),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: Adapt.px(15),
                      left: Adapt.px(20),
                      right: Adapt.px(20)),
                  child: Text(
                    d.title ?? d.name,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: Adapt.px(26)),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Widget _buildShimmerCell() {
    return SizedBox(
      width: Adapt.px(240),
      height: Adapt.px(480),
      child: Shimmer.fromColors(
        baseColor: _theme.primaryColorDark,
        highlightColor: _theme.primaryColorLight,
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.grey[200],
              width: Adapt.px(240),
              height: Adapt.px(342),
            ),
            Container(
              height: Adapt.px(24),
              margin: EdgeInsets.fromLTRB(0, Adapt.px(15), Adapt.px(20), 0),
              color: Colors.grey[200],
            ),
            Container(
              height: Adapt.px(24),
              margin: EdgeInsets.fromLTRB(
                  0, Adapt.px(5), Adapt.px(50), Adapt.px(20)),
              color: Colors.grey[200],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKnownForCell() {
    if (state.cast.length > 0)
      return Container(
        height: Adapt.px(480),
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: state.cast.take(8).map(_buildknowforCell).toList(),
        ),
      );
    else
      return Container(
        height: Adapt.px(480),
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            SizedBox(
              width: Adapt.px(30),
            ),
            _buildShimmerCell(),
            SizedBox(
              width: Adapt.px(20),
            ),
            _buildShimmerCell(),
            SizedBox(
              width: Adapt.px(20),
            ),
            _buildShimmerCell(),
          ],
        ),
      );
  }

  return AnimatedSwitcher(
      key: ValueKey('knownfor'),
      switchInCurve: Curves.easeIn,
      switchOutCurve: Curves.easeOut,
      duration: Duration(milliseconds: 600),
      child: Container(
        key: ValueKey(state.cast),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Adapt.px(30)),
              child: Text(
                I18n.of(viewService.context).knownFor,
                softWrap: true,
                style: TextStyle(
                    fontWeight: FontWeight.w500, fontSize: Adapt.px(40)),
              ),
            ),
            SizedBox(
              height: Adapt.px(30),
            ),
            _buildKnownForCell(),
          ],
        ),
      ));
}
