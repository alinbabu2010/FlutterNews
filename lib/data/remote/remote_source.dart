import 'dart:convert';
import 'dart:io';

import 'package:flutter_news/data/models/error_response.dart';
import 'package:flutter_news/data/models/news_exception.dart';
import 'package:http/http.dart';

import '../models/news_response.dart';

class NetworkDataSource {
  static const _authority = "newsapi.org";
  static const _path = "/v2/everything";

  Future<NewsResponse> fetchNews(int page) async {
    try {
      final queryParameters = {
        "q": "flutter",
        "pageSize": "15",
        "page": "$page"
      };
      final uri = Uri.https(_authority, _path, queryParameters);
      final response = await get(
        uri,
        headers: {"Authorization": "19b71eb781b0404b93feafc1badf4324"},
      );
      if (response.statusCode >= HttpStatus.badRequest) {
        final errorResponse = ErrorResponse.fromJson(jsonDecode(response.body));
        throw NewsException(errorResponse.message);
      } else {
        final newsResponse = NewsResponse.fromJson(jsonDecode(response.body));
        return Future.value(newsResponse);
      }
    } catch (error) {
      rethrow;
    }
  }
}
