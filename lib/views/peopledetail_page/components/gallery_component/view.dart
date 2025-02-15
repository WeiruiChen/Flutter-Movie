import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/customwidgets/shimmercell.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/models/imagemodel.dart';
import 'package:movie/style/themestyle.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    GalleryState state, Dispatch dispatch, ViewService viewService) {
  final ThemeData _theme = ThemeStyle.getTheme(viewService.context);
  Widget _buildImageCell(ImageData d) {
    return Hero(
      key: ValueKey('image${d.filePath}'),
      tag: 'image${d.filePath}',
      child: Container(
        margin: EdgeInsets.only(left: Adapt.px(30)),
        width: Adapt.px(200),
        height: Adapt.px(180),
        decoration: BoxDecoration(
            color: _theme.primaryColorDark,
            borderRadius: BorderRadius.circular(Adapt.px(20)),
            image: DecorationImage(
                fit: BoxFit.cover,
                image: CachedNetworkImageProvider(
                    ImageUrl.getUrl(d.filePath, ImageSize.w300)))),
      ),
    );
  }

  Widget _buildGallery() {
    var _model = state?.images?.profiles ?? [];
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 300),
      child: Container(
          key: ValueKey(_model),
          height: Adapt.px(180),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: _model.length > 0
                ? (_model.map(_buildImageCell).toList()
                  ..add(SizedBox(
                    width: Adapt.px(30),
                  )))
                : <Widget>[
                    SizedBox(
                      width: Adapt.px(30),
                    ),
                    ShimmerCell(
                      Adapt.px(200),
                      Adapt.px(180),
                      Adapt.px(20),
                      baseColor: _theme.primaryColorDark,
                      highlightColor: _theme.primaryColorLight,
                    ),
                    SizedBox(
                      width: Adapt.px(30),
                    ),
                    ShimmerCell(
                      Adapt.px(200),
                      Adapt.px(180),
                      Adapt.px(20),
                      baseColor: _theme.primaryColorDark,
                      highlightColor: _theme.primaryColorLight,
                    ),
                    SizedBox(
                      width: Adapt.px(30),
                    ),
                    ShimmerCell(
                      Adapt.px(200),
                      Adapt.px(180),
                      Adapt.px(20),
                      baseColor: _theme.primaryColorDark,
                      highlightColor: _theme.primaryColorLight,
                    ),
                    SizedBox(
                      width: Adapt.px(30),
                    ),
                    ShimmerCell(
                      Adapt.px(200),
                      Adapt.px(180),
                      Adapt.px(20),
                      baseColor: _theme.primaryColorDark,
                      highlightColor: _theme.primaryColorLight,
                    ),
                  ],
          )),
    );
  }

  return Container(
    key: ValueKey('gallery'),
    padding: EdgeInsets.only(top: Adapt.px(50)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
            padding: EdgeInsets.symmetric(horizontal: Adapt.px(30)),
            child: Row(
              children: <Widget>[
                Text(
                  'Photos',
                  style: TextStyle(
                      fontSize: Adapt.px(40), fontWeight: FontWeight.w500),
                ),
                Expanded(child: Container()),
                InkWell(
                  onTap: () => dispatch(GalleryActionCreator.viewMoreTapped()),
                  child: Text(
                    'View more',
                    style:
                        TextStyle(color: Colors.grey, fontSize: Adapt.px(24)),
                  ),
                )
              ],
            )),
        SizedBox(
          height: Adapt.px(30),
        ),
        _buildGallery(),
        SizedBox(
          height: Adapt.px(50),
        ),
      ],
    ),
  );
}
