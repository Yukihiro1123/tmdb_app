import 'package:flutter/material.dart';
import 'package:tmdb_app/src/common_widgets/shimmer_widget.dart';

class MovieDetailShimmer extends StatelessWidget {
  const MovieDetailShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
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
            )),
          ),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: ShimmerWidget.rectangular(
              width: 150,
              height: 20,
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerWidget.rectangular(
                  width: 300,
                  height: 18,
                ),
                SizedBox(height: 5),
                ShimmerWidget.rectangular(
                  width: 275,
                  height: 18,
                ),
                SizedBox(height: 5),
                ShimmerWidget.rectangular(
                  width: 250,
                  height: 18,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
