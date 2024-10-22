import 'package:caretutors_test/model/response_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constant.dart';

class Controller extends Notifier<AsyncValue<ResponseModel>> {
  @override
  build() {
    return const AsyncValue.loading();
  }

  void fetchData(String date) async {
    state = const AsyncValue.loading();
    Dio dio = Dio();
    dio.options.queryParameters = {
      'api_key': apiKey,
      'date': date,
    };
    try {
      final response = await dio.get(baseUrl);
      final data = response.data;
      print(data);
      final responseModel = ResponseModel.fromJson(data);
      state = AsyncValue.data(responseModel);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}

final controllerProvider = NotifierProvider<Controller, AsyncValue<ResponseModel>>(Controller.new);
