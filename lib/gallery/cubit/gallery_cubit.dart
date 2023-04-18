import 'package:cross_file/cross_file.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:repo/repo.dart';
import 'package:share_plus/share_plus.dart';

part 'gallery_state.dart';

class GalleryCubit extends HydratedCubit<GalleryState> {
  GalleryCubit({required this.grabber}) : super(const GalleryState());
  final Grabber grabber;

  //fet images from grabber
  Future<void> fetch() async {
    final images = await grabber.fetchjImgLexica();
    final imgtopMid = await grabber.fetchImgTopMid();
    final imgrecentMid = await grabber.fetchImgRecMid();
    emit(
      state.copyWith(
        topimgMid: imgtopMid,
        recentImgMid: imgrecentMid,
        imagesLexica: images,
      ),
    );
  }

  //add images to fav
  Future<void> addToFav(String img) async {
    //clone fav images map
    final fav = {...state.imagesFav};
    if (fav.containsKey(img)) {
      //remove
      fav.remove(img);
    } else {
      //add
      fav[img] = DateTime.now().millisecondsSinceEpoch;
    }
    emit(state.copyWith(imagesFav: fav));
  }

  //is faborite
  bool isFavorite(String img) {
    return state.imagesFav.containsKey(img);
  }

  @override
  GalleryState? fromJson(Map<String, dynamic> json) {
    //hydrated favoritos
    return GalleryState(
      imagesFav: Map<String, int>.from(json['imagesFav'] as Map),
    );
  }

  @override
  Map<String, dynamic>? toJson(GalleryState state) {
    return {
      'imagesFav': state.imagesFav,
    };
  }

  Future<void> shareImage(String img, int index) async {
    //share link if index = 0
    if (index == 0) {
      await Share.share(img);
    }
    if (index == 1) {
      final byteData = await NetworkAssetBundle(Uri.parse(img)).load(img);
      final bytes = byteData.buffer.asUint8List();
      final name = img.split('/').last;
      final file = XFile.fromData(bytes, name: name, mimeType: 'image/png');
      await Share.shareXFiles([file]);
    }
  }
}
