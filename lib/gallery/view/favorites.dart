import 'package:backgroundsai/gallery/gallery.dart';
import 'package:backgroundsai/widgets/image_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    final favorites = context.select(
      (GalleryCubit cubit) => cubit.state.imagesFav,
    );
    final sorted = favorites.entries.toList()
      ..sort(
        (a, b) => b.key.compareTo(a.key),
      );
    final body = sorted.isEmpty
        ? const Center(
            child: Text(
              'No Favorites',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          )
        : ListView.builder(
            itemCount: sorted.length,
            itemBuilder: (context, index) {
              return ImageCard(url: sorted[index].key);
            },
          );
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 18, 18, 18),
      body: body,
    );
  }
}
