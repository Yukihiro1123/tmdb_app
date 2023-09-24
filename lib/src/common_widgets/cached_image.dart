import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tmdb_app/src/utils/cached_manager/cache_manager_provider.dart';

class CachedImage extends ConsumerWidget {
  final String imageURL;
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
  Widget build(BuildContext context, WidgetRef ref) {
    return imageURL
            .replaceFirst('https://image.tmdb.org/t/p/w500', '')
            .startsWith('assets/images')
        ? Image.asset(
            imageURL.replaceFirst('https://image.tmdb.org/t/p/w500', ''))
        : CachedNetworkImage(
            cacheManager: ref.read(cachedManagerProvider),
            imageUrl: imageURL,
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
                          Colors.transparent, BlendMode.srcATop),
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
              debugPrint("エラー：$error, url: $imageURL");
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
