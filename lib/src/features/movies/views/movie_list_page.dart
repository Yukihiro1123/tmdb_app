import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tmdb_app/env.dart';

class MovieListPage extends HookConsumerWidget {
  const MovieListPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text(Env.apiKey),
        ],
      ),
    );
  }
}
