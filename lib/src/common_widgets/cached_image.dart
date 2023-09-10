import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedImage extends StatelessWidget {
  final String? imageURL;
  final double width;
  final double height;
  final bool isCircle;
  const CachedImage({
    super.key,
    required this.imageURL,
    required this.width,
    required this.height,
    required this.isCircle,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageURL ??
          'https://www.google.com/url?sa=i&url=https%3A%2F%2Funsplash.com%2Fs%2Fphotos%2Fmovie&psig=AOvVaw0bx0ln6dk7Zx_aNI95U_C8&ust=1694396662475000&source=images&cd=vfe&opi=89978449&ved=0CBAQjRxqFwoTCOic4sr1noEDFQAAAAAdAAAAABAE',
      imageBuilder: (context, imageProvider) => Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
          image: DecorationImage(
            fit: BoxFit.fill,
            image: imageProvider,
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
        print(error);
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
