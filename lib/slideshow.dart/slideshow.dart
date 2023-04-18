import 'package:backgroundsai/slideshow.dart/ticker.dart';
import 'package:backgroundsai/widgets/image_card.dart';
import 'package:flutter/material.dart';

class SlideShow extends StatefulWidget {
  const SlideShow({super.key, required this.urls});
  final List<String> urls;

  @override
  State<SlideShow> createState() => _SlideShowState();
}

class _SlideShowState extends State<SlideShow> {
  final controller = PageController(
    viewportFraction: 0.8,
  );

  final hidecontrolsafterseconds = 1;

  DateTime lasInteraction = DateTime.now();

  bool hidecontrols = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    MyTicker().tick().listen((event) {
      if (DateTime.now().difference(lasInteraction).inSeconds >
          hidecontrolsafterseconds) {
        setState(() {
          hidecontrols = true;
        });
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 18, 18, 18),
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),

      //body with pageview and imagecards from list
      body: GestureDetector(
        onTap: () {
          setState(() {
            hidecontrols = false;
            lasInteraction = DateTime.now();
          });
        },
        child: Stack(
          children: [
            PageView.builder(
              controller: controller,
              itemBuilder: (context, index) {
                return ImageCard(url: widget.urls[index % widget.urls.length]);
              },
              onPageChanged: (value) {
                debugPrint(value.toString());
              },
            ),
            Positioned(
              bottom: 0,
              top: 0,
              child: AnimatedOpacity(
                opacity: hidecontrols ? 0 : 1,
                duration: const Duration(seconds: 1),
                child: FloatingActionButton.small(
                  heroTag: 'back',
                  backgroundColor: Colors.black.withOpacity(0.5),
                  onPressed: () {
                    controller.previousPage(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.bounceInOut,
                    );
                  },
                  child: const Icon(Icons.arrow_back_outlined,
                      color: Colors.white),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              top: 0,
              right: 0,
              child: AnimatedOpacity(
                opacity: hidecontrols ? 0 : 1,
                duration: const Duration(seconds: 1),
                child: FloatingActionButton.small(
                  heroTag: 'prev',
                  backgroundColor: Colors.black.withOpacity(0.5),
                  onPressed: () {
                    controller.nextPage(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.bounceInOut,
                    );
                  },
                  child: const Icon(
                    Icons.arrow_forward_outlined,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
