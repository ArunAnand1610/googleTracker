

import 'dart:convert';

import 'package:http/http.dart';

import '../model/entrydetailmodel.dart';

class UserRepository {
  String userUrl = 'https://dummyjson.com/products';

  Future<List<MovieDetails>> getUsers() async {
    Response response = await get(Uri.parse(userUrl));

    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body)['entry'];
     
      print("The value length is ${result.length}");
      return result.map((e) => MovieDetails.fromJson(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
  }