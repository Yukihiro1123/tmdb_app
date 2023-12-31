import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'shimmer_widget.dart';

class CachedImage extends ConsumerWidget {
  const CachedImage({
    super.key,
    required this.imageURL,
    required this.width,
    required this.height,
    required this.isCircle,
    this.boxFit,
    this.colorFilter,
  });
  final String? imageURL;
  final double width;
  final double height;
  final bool isCircle;
  final BoxFit? boxFit;
  final ColorFilter? colorFilter;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //golden testではネットワーク画像を取得できないのでダミーデータもassetimageで表示する
    return imageURL == null || imageURL == 'assets/images/cinema.jpeg'
        ? Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              image: const DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assets/images/cinema.jpeg'),
              ),
              shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
            ),
          )
        : CachedNetworkImage(
            imageUrl: 'https://image.tmdb.org/t/p/w500${imageURL!}',
            imageBuilder: (context, imageProvider) => Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
                image: DecorationImage(
                  fit: boxFit ?? BoxFit.fill,
                  image: imageProvider,
                  colorFilter: colorFilter ??
                      const ColorFilter.mode(
                        Colors.transparent,
                        BlendMode.srcATop,
                      ),
                ),
              ),
            ),
            placeholder: (context, url) {
              return isCircle
                  ? ShimmerWidget.circular(
                      width: width,
                      height: height,
                    )
                  : ShimmerWidget.rectangular(height: height);
            },
            errorWidget: (context, url, dynamic error) {
              debugPrint('エラー：$error, url: $imageURL');
              return Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/cinema.jpeg'),
                  ),
                  shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
                ),
              );
            },
          );
  }
}
