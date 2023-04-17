import 'package:backgroundsai/gallery/cubit/gallery_cubit.dart';
import 'package:backgroundsai/gallery/view/favorites.dart';
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
      backgroundColor: Colors.black,
      body: SizedBox.expand(
        child: SafeArea(
          child: SingleChildScrollView(
            primary: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: const [
                      Text(
                        'Lexica AI',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Ver mas',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                const LexicaImgs(),
                const Divider(color: Colors.white, indent: 80, endIndent: 80),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: const [
                      Text(
                        'Midjurney Top',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Ver mas',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                const MidjurneyTop(),
                const Divider(color: Colors.white, indent: 80, endIndent: 80),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: const [
                      Text(
                        'Midjourney Recent',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Ver mas',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                const MidjurneyRecent(),
              ],
            ),
          ),
        ),
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

    return ImageList(lista: imgsLexica);
  }
}

//steless widget midjurney
class MidjurneyRecent extends StatelessWidget {
  const MidjurneyRecent({super.key});

  @override
  Widget build(BuildContext context) {
    final imgmidrecent =
        context.select((GalleryCubit cubit) => cubit.state.recentImgMid);
    return ImageList(lista: imgmidrecent);
  }
}

//steless widget midjurney
class MidjurneyTop extends StatelessWidget {
  const MidjurneyTop({super.key});

  @override
  Widget build(BuildContext context) {
    final imgmidtop =
        context.select((GalleryCubit cubit) => cubit.state.topimgMid);
    return ImageList(lista: imgmidtop);
  }
}
