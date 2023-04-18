import 'package:backgroundsai/gallery/cubit/gallery_cubit.dart';
import 'package:backgroundsai/gallery/view/favorites.dart';
import 'package:backgroundsai/slideshow.dart/slideshow.dart';
import 'package:backgroundsai/widgets/imagelist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (context) => const FavoritePage(),
            ),
          );
        },
        child: const Icon(Icons.favorite_border, color: Colors.white),
      ),
      backgroundColor: const Color.fromARGB(255, 18, 18, 18),
      body: SizedBox.expand(
        child: SafeArea(
          child: SingleChildScrollView(
            primary: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                LexicaImgs(),
                Divider(color: Colors.white, indent: 80, endIndent: 80),
                MidjurneyTop(),
                Divider(color: Colors.white, indent: 80, endIndent: 80),
                MidjurneyRecent(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LeyendaSection extends StatelessWidget {
  const LeyendaSection({super.key, required this.title, required this.urls});
  final String title;
  final List<String> urls;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (context) => SlideShow(
                    urls: urls,
                  ),
                ),
              );
            },
            child: const Text(
              'Ver mas',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class LexicaImgs extends StatelessWidget {
  const LexicaImgs({super.key});

  @override
  Widget build(BuildContext context) {
    final imgsLexica =
        context.select((GalleryCubit cubit) => cubit.state.imagesLexica);

    return Column(
      children: [
        LeyendaSection(title: 'Lexica Ai', urls: imgsLexica),
        ImageList(lista: imgsLexica),
      ],
    );
  }
}

//steless widget midjurney
class MidjurneyRecent extends StatelessWidget {
  const MidjurneyRecent({super.key});

  @override
  Widget build(BuildContext context) {
    final imgmidrecent =
        context.select((GalleryCubit cubit) => cubit.state.recentImgMid);
    return Column(
      children: [
        LeyendaSection(title: 'Midjourney Recent', urls: imgmidrecent),
        ImageList(lista: imgmidrecent),
      ],
    );
  }
}

//steless widget midjurney
class MidjurneyTop extends StatelessWidget {
  const MidjurneyTop({super.key});

  @override
  Widget build(BuildContext context) {
    final imgmidtop =
        context.select((GalleryCubit cubit) => cubit.state.topimgMid);
    return Column(
      children: [
        LeyendaSection(title: 'Midjourney Top', urls: imgmidtop),
        ImageList(lista: imgmidtop),
      ],
    );
  }
}
