import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/customwidgets/shimmercell.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/models/enums/media_type.dart';
import 'package:movie/models/videolist.dart';
import 'package:movie/style/themestyle.dart';
import 'package:movie/views/home_page/action.dart';

import 'state.dart';

Widget buildView(
    SwiperState state, Dispatch dispatch, ViewService viewService) {
  final ThemeData _theme = ThemeStyle.getTheme(viewService.context);
  Widget _buildSwiperCardCell(VideoListResult d) {
    return GestureDetector(
        key: ValueKey('card${d.id}'),
        onTap: () => dispatch(HomePageActionCreator.onCellTapped(
            d.id,
            d.backdropPath,
            d.title ?? d.name,
            d.posterPath,
            state.showHeaderMovie ? MediaType.movie : MediaType.tv)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: new BoxDecoration(
                color: _theme.brightness == Brightness.light
                    ? Colors.white
                    : Color(0xFF404040),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: _theme.brightness == Brightness.light
                          ? Colors.grey[200]
                          : Colors.transparent,
                      offset: Offset(0, Adapt.px(20)),
                      blurRadius: Adapt.px(30),
                      spreadRadius: Adapt.px(1)),
                ],
              ),
              margin: EdgeInsets.fromLTRB(
                  Adapt.px(30), Adapt.px(5), Adapt.px(30), Adapt.px(30)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: Adapt.px(120),
                    height: Adapt.px(170),
                    decoration: BoxDecoration(
                        color: _theme.primaryColorLight,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: CachedNetworkImageProvider(ImageUrl.getUrl(
                                d.posterPath, ImageSize.w300)))),
                  ),
                  SizedBox(
                    width: Adapt.px(20),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: Adapt.px(20),
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            width: Adapt.screenW() - Adapt.px(450),
                            child: Text(
                              d.title ?? d.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  //color: Colors.black,
                                  fontWeight: FontWeight.w800,
                                  fontSize: Adapt.px(35)),
                            ),
                          ),
                          Container(
                            width: Adapt.px(160),
                            child: RatingBarIndicator(
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              unratedColor: Colors.grey[300],
                              itemSize: Adapt.px(22),
                              itemPadding: EdgeInsets.only(right: Adapt.px(8)),
                              rating: d.voteAverage / 2,
                            ),
                          ),
                          Text(
                            d.voteAverage.toStringAsFixed(1),
                            style: TextStyle(
                                fontSize: Adapt.px(22),
                                fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                      SizedBox(
                        height: Adapt.px(20),
                      ),
                      Container(
                        width: Adapt.screenW() - Adapt.px(210),
                        child: Text(
                          d.overview,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              //color: Colors.grey,
                              fontSize: Adapt.px(24)),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ));
  }

  Widget _buildSwiper() {
    var _model = state.showHeaderMovie ? state.movie : state.tv;
    Widget _child = _model.results.length > 0
        ? Swiper(
            key: ValueKey(_model),
            autoplay: true,
            duration: 1000,
            autoplayDelay: 10000,
            viewportFraction: 0.9999,
            itemCount: _model.results.length,
            itemBuilder: (ctx, index) {
              var d = _model.results[index];
              return _buildSwiperCardCell(d);
            },
          )
        : Container(
            margin: EdgeInsets.only(bottom: Adapt.px(55)),
            child: ShimmerCell(
              Adapt.screenW() - Adapt.px(60),
              Adapt.px(170),
              0,
              baseColor: _theme.primaryColorDark,
              highlightColor: _theme.primaryColorLight,
            ),
          );
    return Container(
      height: Adapt.px(225),
      child: AnimatedSwitcher(
          duration: Duration(milliseconds: 600),
          switchInCurve: Curves.easeIn,
          switchOutCurve: Curves.easeOut,
          child: _child),
    );
  }

  return _buildSwiper();
}
