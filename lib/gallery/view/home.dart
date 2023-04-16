import 'package:backgroundsai/gallery/cubit/gallery_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: SingleChildScrollView(
          primary: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('Lexica AI'),
              LexicaImgs(),
              Text('Midjurney Top'),
              MidjurneyTop(),
              Text('Midjurney Recent'),
              MidjurneyRecent(),
            ],
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
    return Container();
  }
}

//steless widget midjurney
class MidjurneyRecent extends StatelessWidget {
  const MidjurneyRecent({super.key});

  @override
  Widget build(BuildContext context) {
    final imgmidrecent =
        context.select((GalleryCubit cubit) => cubit.state.recentImgMid);
    throw UnimplementedError();
  }
}

//steless widget midjurney
class MidjurneyTop extends StatelessWidget {
  const MidjurneyTop({super.key});

  @override
  Widget build(BuildContext context) {
    final imgmidtop =
        context.select((GalleryCubit cubit) => cubit.state.topimgMid);
    throw UnimplementedError();
  }
}
