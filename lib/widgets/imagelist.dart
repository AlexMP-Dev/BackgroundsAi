import 'package:backgroundsai/widgets/image_card.dart';
import 'package:flutter/material.dart';

class ImageList extends StatelessWidget {
  const ImageList({super.key, this.lista});
  final List<String>? lista;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: lista!.length,
        itemBuilder: (context, index) {
          return ImageCard(url: lista![index]);
        },
      ),
    );
  }
}
