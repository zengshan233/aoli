import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum IMGAGE_TYPE { LOCAL, REMOTE, SVG }

class Img extends StatefulWidget {
  final String url;
  final String package;
  final double width;
  final double height;
  final BoxFit fit;
  final Alignment alignment;
  Img(
      {this.url,
      this.package,
      this.width,
      this.height,
      this.fit = BoxFit.cover,
      this.alignment = Alignment.center});

  @override
  _ImgState createState() => _ImgState();
}

class _ImgState extends State<Img> {
  IMGAGE_TYPE imageType = IMGAGE_TYPE.LOCAL;

  setImageType() {
    String urlPrefix = widget.url.split('/').first;
    String format = widget.url.split('.').last;
    if (urlPrefix == 'assets') {
      imageType = format == 'svg' ? IMGAGE_TYPE.SVG : IMGAGE_TYPE.LOCAL;
    } else if (urlPrefix.contains('http')) {
      imageType = IMGAGE_TYPE.REMOTE;
    }
  }

  Widget buildImg() {
    switch (imageType) {
      case IMGAGE_TYPE.LOCAL:
        return buildLocalImg();
      // case IMGAGE_TYPE.SVG:
      //   return buildSvg();
      case IMGAGE_TYPE.REMOTE:
        return buildRemoteImg();
      default:
        return buildLocalImg();
    }
  }

  @override
  void initState() {
    super.initState();
    setImageType();
  }

  @override
  Widget build(BuildContext context) {
    return buildImg();
  }

  Widget buildLocalImg() {
    return Image.asset(
      widget.url,
      width: widget.width,
      height: widget.height,
      fit: widget.fit,
      alignment: widget.alignment,
    );
  }

  Widget buildRemoteImg() {
    if (kIsWeb) {
      return Image.network(
        widget.url,
        width: widget.width,
        height: widget.height,
        fit: widget.fit,
      );
    } else {
      return CachedNetworkImage(
          imageUrl: widget.url,
          width: widget.width,
          height: widget.height,
          fit: widget.fit,
          errorWidget: (a, b, c) => Container(width: 100, height: 100),
          fadeInDuration: Duration(milliseconds: 300),
          progressIndicatorBuilder: (context, url, progress) {
            return Container();
          });
    }
  }
}
