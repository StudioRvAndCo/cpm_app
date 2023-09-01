import 'package:collection/collection.dart';

import '../../models/base_model.dart';
import '../service.dart';

abstract class SelectService extends Service {
  Future<List<Model>> select<Model extends BaseModel>(
    List data,
    Model Function(Map<String, dynamic>) constructor,
  ) async {
    List<Model> result = [];
    for (var element in data) {
      result.add(constructor(element));
    }

    return result;
  }

  Future<List<Model>> selectAndNumber<Model extends BaseModel>(
    List data,
    Model Function(Map<String, dynamic>) constructor,
  ) async {
    List<Model> result = [];
    data.forEachIndexed((index, element) {
      element.addAll({'number': ++index});
      result.add(constructor(element));
    });

    return result;
  }

  Future<Model> selectSingle<Model extends BaseModel>(
    data,
    Model Function(Map<String, dynamic>) constructor, {
    addPlaceholderNumber = false,
  }) async {
    if (addPlaceholderNumber) {
      data.addAll({'number': -1});
    }

    return constructor(data);
  }
}
