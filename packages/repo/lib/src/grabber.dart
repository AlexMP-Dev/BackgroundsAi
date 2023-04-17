import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class Grabber {
  //recent and top images endpoint from midjurney
  static const String _recentImgMidjurney =
      'https://www.midjourney.com/showcase/recent/';
  static const String _topImgMidjurney =
      'https://www.midjourney.com/showcase/top/';
  static const String _matchmid = 'https://cdn.midjourney.com/.*?.png';
  //get images of lexica
  Future<List<String>> _fetchjImgLexica() async {
    try {
      final response = await http.get(
        Uri.parse('https://lexica.art/'),
      );
      //debugPrint(response.body);
      //id\":\"69eb5d51-3c79-46c0-ad47-d694e9ca46ef\"
      final sub1 = response.body.substring(29462, response.body.length - 10);
      final exp = RegExp(
        '([0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}).*?"',
      );
      final ids = exp.allMatches(sub1);
      final ids2 = ids.map((match) => match.group(0)).toList();
      final lista = <String>[];
      for (final element in ids2) {
        lista.add(element!.substring(0, element.length - 2));
      }
      final lista2 = <String>[];
      for (var i = 0; i < lista.length; i++) {
        if (i.isEven) {
          lista2.add('https://image.lexica.art/md2/${lista[i]}');
        }
      }
      debugPrint(lista2.length.toString());

      return lista2;
      //debugPrint(recorte);
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  //get images
  Future<List<String>> _getImages(String endpoint, String patter) async {
    try {
      final uri = Uri.parse(endpoint);
      final response = await http.get(uri);
      final reg = RegExp(patter);
      final matches = reg.allMatches(response.body);
      final imageUrls = matches.map((match) => match.group(0)).toList();
      final lista = <String>[];
      for (var i = 0; i < imageUrls.length; i++) {
        if (i.isEven) {
          lista.add(imageUrls[i]!);
        }
      }
      return List<String>.from(lista);
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  Future<List<String>> fetchjImgLexica() async {
    return _fetchjImgLexica();
  }

  Future<List<String>> fetchImgRecMid() {
    return _getImages(_recentImgMidjurney, _matchmid);
  }

  Future<List<String>> fetchImgTopMid() {
    return _getImages(_topImgMidjurney, _matchmid);
  }

  Future<void> _checkStatusCode(String url) async {
    var request = http.Request('GET', Uri.parse(url));
    request.followRedirects = false;
    var client = http.Client();

    try {
      var response = await client.send(request).timeout(Duration(seconds: 5));
      if (response.statusCode == 200) {
        print('La URL $url es válida.');
      } else {
        print(
            'La URL $url devuelve un código de estado ${response.statusCode}.');
      }
    } catch (e) {
      print('La URL $url no es válida.');
    } finally {
      client.close();
    }
  }
}
