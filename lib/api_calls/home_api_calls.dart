import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/api_response.dart';
import '../models/stock_model.dart';

class HomeApiCalls {
  Future<ApiResponse<List<StockModel>>> getStockCriteria() async {
    return http
        .get(Uri.parse("https://mobile-app-challenge.herokuapp.com/data"))
        .then((response) {
      if (response.statusCode == 200) {
        List<StockModel> criteriaModelList = [];
        for (var data in (json.decode(response.body) as List)) {
          criteriaModelList.add(StockModel.fromJson(data));
        }
        return ApiResponse(
            statusCode: response.statusCode, body: criteriaModelList);
      } else {
        return ApiResponse(statusCode: response.statusCode, error: true);
      }
    });
  }
}
