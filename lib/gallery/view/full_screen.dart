import 'package:backgroundsai/widgets/image_card.dart';
import 'package:flutter/material.dart';

class FullScreen extends StatelessWidget {
  const FullScreen({super.key, required this.url});
  final String url;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 18, 18, 18),
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: ImageCard(url: url),
    );
  }
}
