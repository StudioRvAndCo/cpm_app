import 'package:collection/collection.dart';
import 'package:cpm/models/base_model.dart';
import 'package:cpm/services/service.dart';

abstract class SelectService extends Service {
  Future<List<Model>> select<Model extends BaseModel>(
    List data,
    Model Function(Map<String, dynamic>) constructor,
  ) async {
    final List<Model> result = [];
    for (final element in data) {
      result.add(constructor(element as Map<String, dynamic>));
    }

    return result;
  }

  Future<List<Model>> selectAndNumber<Model extends BaseModel>(
    List data,
    Model Function(Map<String, dynamic>) constructor,
  ) async {
    final List<Model> result = [];
    data.forEachIndexed((index, element) {
      (element as Map<String, dynamic>).addAll({'number': ++index});
      result.add(constructor(element));
    });

    return result;
  }

  Future<Model> selectSingle<Model extends BaseModel>(
    Map<String, dynamic> data,
    Model Function(Map<String, dynamic>) constructor, {
    bool addPlaceholderNumber = false,
  }) async {
    if (addPlaceholderNumber) {
      data.addAll({'number': -1});
    }

    return constructor(data);
  }
}
