import 'package:backgroundsai/widgets/image_card.dart';
import 'package:flutter/material.dart';

class SlideShow extends StatelessWidget {
  SlideShow({super.key, required this.urls});
  final List<String> urls;
  final controller = PageController(
    viewportFraction: 0.8,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 18, 18, 18),
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),

      //body with pageview and imagecards from list
      body: Stack(
        children: [
          PageView.builder(
            controller: controller,
            itemBuilder: (context, index) {
              return ImageCard(url: urls[index % urls.length]);
            },
            onPageChanged: (value) {
              debugPrint(value.toString());
            },
          ),
          Positioned(
            bottom: 0,
            top: 0,
            child: FloatingActionButton.small(
              heroTag: 'back',
              backgroundColor: Colors.black.withOpacity(0.5),
              onPressed: () {
                controller.previousPage(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.bounceInOut,
                );
              },
              child: const Icon(Icons.arrow_back_outlined, color: Colors.white),
            ),
          ),
          Positioned(
            bottom: 0,
            top: 0,
            right: 0,
            child: FloatingActionButton.small(
              heroTag: 'prev',
              backgroundColor: Colors.black.withOpacity(0.5),
              onPressed: () {
                controller.nextPage(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.bounceInOut,
                );
              },
              child:
                  const Icon(Icons.arrow_forward_outlined, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
