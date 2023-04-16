part of 'gallery_cubit.dart';

class GalleryState extends Equatable {
  const GalleryState({
    this.topimgMid = const [],
    this.recentImgMid = const [],
    this.imagesLexica = const [],
    this.imagesFav = const {},
  });

  //topimages midjurney
  final List<String> topimgMid;

  //recent images midjurney
  final List<String> recentImgMid;

  //images from lexiar
  final List<String> imagesLexica;

  //map from favorite images
  final Map<String, int> imagesFav;

  @override
  // TODO: implement props
  List<Object?> get props => [topimgMid, recentImgMid, imagesLexica, imagesFav];

  //copyWith
  GalleryState copyWith({
    List<String>? topimgMid,
    List<String>? recentImgMid,
    List<String>? imagesLexica,
    Map<String, int>? imagesFav,
  }) {
    return GalleryState(
        topimgMid: topimgMid ?? this.topimgMid,
        recentImgMid: recentImgMid ?? this.recentImgMid,
        imagesLexica: imagesLexica ?? this.imagesLexica,
        imagesFav: imagesFav ?? this.imagesFav,);
  }
}
