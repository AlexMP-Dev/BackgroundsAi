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
        child: Stack(
          children: [
            ///
            CachedNetworkImage(
              imageUrl: url!,
              placeholder: (context, url) => const Center(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              ),
              imageBuilder: (context, imageProvider) {
                return DecoratedBox(
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
                    child: Image(
                      image: imageProvider,
                    ),
                  ),
                );
              },
            ),

            Positioned(
              bottom: 0,
              right: 0,
              child: Column(
                children: [
                  PopMenu(url: url!),
                  IconButton(
                    onPressed: () {
                      context.read<GalleryCubit>().addToFav(url!);
                    },
                    icon: Icon(
                      isfavorite ? Icons.favorite : Icons.favorite_border,
                      color: isfavorite ? Colors.red : Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PopMenu extends StatelessWidget {
  const PopMenu({super.key, required this.url});
  final String url;
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      elevation: 5,
      shadowColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(
          color: Colors.white.withOpacity(0.5),
        ),
      ),
      splashRadius: 2,
      color: Colors.black,
      itemBuilder: (context) {
        return [
          // ignore: inference_failure_on_instance_creation
          PopupMenuItem(
            onTap: () {
              context.read<GalleryCubit>().shareImage(url, 0);
            },
            child: const Text(
              'Share Link',
              style: TextStyle(color: Colors.white),
            ),
          ),
          // ignore: inference_failure_on_instance_creation
          PopupMenuItem(
            onTap: () {
              context.read<GalleryCubit>().shareImage(url, 1);
            },
            child: const Text(
              'Share Image',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ];
      },
      icon: const Icon(
        Icons.share,
        color: Colors.white,
      ),
    );
  }
}
