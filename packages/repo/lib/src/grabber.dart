import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// class to colect images from lexica.art
class Grabber {
  //top images endpoint
  static const String _imgslexica = 'https://lexica.art/';
  static const String _matchlexica = 'https://image.lexica.art/sm2/.*?';

  //recent and top images endpoint from midjurney
  static const String _recentImgMidjurney =
      'https://www.midjourney.com/showcase/recent/';
  static const String _topImgMidjurney =
      'https://www.midjourney.com/showcase/top/';
  static const String _matchmid = 'https://www.midjurney.com/.*?/.*?.png';

  //get images
  Future<List<String>> _getImages(String endpoint, String patter) async {
    try {
      final uri = Uri.parse(endpoint);
      final response = await http.get(uri);
      //parse lexica response
      final Pattern pattern = RegExp(patter);
      final matches = pattern.allMatches(response.body);
      //map matches to list
      final images = matches.map((match) => match.group(0)).toList();
      return List<String>.from(images);
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  Future<List<String>> getImagesLexica() {
    return _getImages(_imgslexica, _matchlexica);
  }

  Future<List<String>> getImgRecentMidjurney() {
    return _getImages(_recentImgMidjurney, _matchmid);
  }

  Future<List<String>> getImgTopMidjurney() {
    return _getImages(_topImgMidjurney, _matchmid);
  }
}
