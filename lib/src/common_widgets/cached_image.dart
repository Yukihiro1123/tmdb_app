import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedImage extends StatelessWidget {
  final String? imageURL;
  final double width;
  final double height;
  final bool isCircle;
  final BoxFit? boxFit;
  final ColorFilter? colorFilter;
  const CachedImage({
    super.key,
    required this.imageURL,
    required this.width,
    required this.height,
    required this.isCircle,
    this.boxFit,
    this.colorFilter,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageURL ?? '',
      imageBuilder: (context, imageProvider) => Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
          image: DecorationImage(
            fit: boxFit ?? BoxFit.fill,
            image: imageProvider,
            colorFilter: colorFilter ??
                const ColorFilter.mode(Colors.transparent, BlendMode.srcATop),
          ),
        ),
      ),
      placeholder: (context, url) => Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
        ),
      ),
      errorWidget: (context, url, dynamic error) {
        print("エラー：$error");
        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            image: const DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage("assets/images/cinema.jpeg"),
            ),
            shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
          ),
        );
      },
    );
  }
}
