import 'package:backgroundsai/gallery/gallery.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImageCard extends StatelessWidget {
  const ImageCard({super.key, this.url});
  final String? url;
  @override
  Widget build(BuildContext context) {
    final isfavorite = context.select(
      (GalleryCubit cubit) => cubit.isFavorite(url!),
    );
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              )
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    //navigate to fullscreen
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (context) => FullScreen(
                          url: url!,
                        ),
                      ),
                    );
                  },
                  child: CachedNetworkImage(
                    imageUrl: url!,
                    errorWidget: (context, url, error) {
                      if (error != null) {
                        return const SizedBox();
                      } else {
                        return const SizedBox();
                      }
                    },
                    placeholder: (context, url) => const Center(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    imageBuilder: (context, imageProvider) {
                      return Image(
                        image: imageProvider,
                      );
                    },
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: IconButton(
                    onPressed: () {
                      context.read<GalleryCubit>().addToFav(url!);
                    },
                    icon: Icon(
                      isfavorite ? Icons.favorite : Icons.favorite_border,
                      color: isfavorite ? Colors.red : Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
