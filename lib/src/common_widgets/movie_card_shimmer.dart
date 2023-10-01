import 'package:flutter/material.dart';
import 'shimmer_widget.dart';

class MovieCardShimmer extends StatelessWidget {
  const MovieCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShimmerWidget.circular(
            width: 450,
            height: 200,
            shapeBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(36 / 2),
                topRight: Radius.circular(36 / 2),
              ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                ShimmerWidget.rectangular(
                  width: 150,
                  height: 20,
                ),
                SizedBox(height: 5),
                ShimmerWidget.rectangular(
                  width: 150,
                  height: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
