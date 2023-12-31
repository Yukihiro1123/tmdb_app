import 'package:flutter/material.dart';
import 'shimmer_widget.dart';

class ReviewCardShimmer extends StatelessWidget {
  const ReviewCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          ShimmerWidget.circular(
            width: 50,
            height: 50,
            shapeBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(36),
              ),
            ),
          ),
          SizedBox(width: 10),
          Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                ShimmerWidget.rectangular(
                  width: 150,
                  height: 10,
                ),
                SizedBox(height: 5),
                ShimmerWidget.rectangular(
                  width: 150,
                  height: 10,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
