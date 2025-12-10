import 'package:gibas/core/app/app_config.dart';
import 'package:gibas/core/utils/log.dart';
import 'package:gibas/domain/models/data_result.dart';
import 'package:hive/hive.dart';

export 'package:hive/hive.dart';

abstract class HiveRepository<T extends HiveObject> {
  final String boxName;

  HiveRepository(this.boxName);

  static const tag = 'Hive Repository';

  Future<Box<T>> openBox() async => await Hive.openBox<T>(boxName);

  Future<DataResult<int>> add(T item) async {
    logProcess('Add Box $boxName');
    try {
      final box = await openBox();
      final key = await box.add(item);
      logInfo('Sucess => Key: $key');
      return DataResult.fromHive(dataValue: key);
    } catch (e) {
      logError('Add Box $boxName Error => $e');
      return DataResult.fromHiveFailure(dataValue: -1, messageValue: e.toString());
    }
  }

  Future<DataResult<List<int>>> addAll(List<T>? items) async {
    logProcess('Add All Box $boxName : ${items?.length} Items');
    try {
      final box = await openBox();
      final keys = await box.addAll(items ?? []);
      logInfo('Sucess => Keys: ${keys.toList()}');
      return DataResult.fromHive(dataValue: keys.toList());
    } catch (e) {
      logError('Add All Box $boxName Error => $e');
      return DataResult.fromHiveFailure(dataValue: [], messageValue: e.toString());
    }
  }

  Future<DataResult<T?>> getById(int? id) async {
    logProcess('Get By Id Box $boxName Id: $id');
    try {
      final box = await openBox();
      final item = box.get(id);
      if (item != null) {
        logInfo('Sucess => Item: $item');
        return DataResult.fromHive(dataValue: item);
      } else {
        logInfo('Empty => Key: $id');
        return DataResult.fromHiveNotFound();
      }
    } catch (e) {
      logError('Get By Id Box $boxName Error => $e');
      return DataResult.fromHiveFailure(messageValue: e.toString());
    }
  }

  Future<DataResult<T>> getAll({
    int? page = 1,
    int? limit = AppConfig.limitQuery,
    bool isSend = false,
    String? sortBy = AppConfig.sortByAscending,
  }) async {
    logProcess('Get All Box $boxName Page: $page Limit: $limit Sort By: $sortBy');
    try {
      final box = await openBox();
      final List<T> items = [];

      final currentPage = page ?? 1;
      final itemsPerPage = limit ?? AppConfig.limitQuery;
      final start = (currentPage - 1) * itemsPerPage;
      final end = start + itemsPerPage;

      final allKeys = box.keys.toList();

      if (allKeys.isEmpty) {
        logInfo('Empty => Keys: []');
        return DataResult.fromHiveEmpty();
      }

      final paginatedKeys = allKeys.sublist(
        start.clamp(0, allKeys.length),
        end.clamp(0, allKeys.length),
      );

      logProcess('Result Box $boxName Keys: ${paginatedKeys.toList()}');

      for (final key in paginatedKeys) {
        final item = box.get(key) as T;
        // Log.print('$item');
        items.add(item);
      }
      return DataResult.fromHiveList(
        dataValue: sortBy == AppConfig.sortByDescending ? items.reversed.toList() : items,
      );
    } catch (e) {
      logError('Get All Box $boxName Error => $e');
      return DataResult.fromHiveFailure(messageValue: e.toString());
    }
  }

  Future<DataResult<bool>> hasData() async {
    logProcess('Has Data Box $boxName');
    try {
      final box = await openBox();
      final hasData = box.isNotEmpty;
      logInfo('Sucess => Box $boxName Has Data: $hasData');
      return DataResult.fromHive(dataValue: hasData);
    } catch (e) {
      logError('Has Data Box $boxName Error => $e');
      return DataResult.fromHiveFailure(dataValue: false, messageValue: e.toString());
    }
  }

  Future<DataResult<int>> length() async {
    logProcess('Length Box $boxName');
    try {
      final box = await openBox();
      final length = box.length;
      logInfo('Sucess => Box $boxName Length: $length');
      return DataResult.fromHive(dataValue: length);
    } catch (e) {
      logError('Remove Box $boxName Error => $e');
      return DataResult.fromHiveFailure(dataValue: -1, messageValue: e.toString());
    }
  }

  Future<DataResult<bool>> remove(dynamic key) async {
    logProcess('Remove Box $boxName Key: $key');
    try {
      final box = await openBox();
      await box.delete(key);
      logInfo('Sucess => Key: $key');
      return DataResult.fromHive(dataValue: true);
    } catch (e) {
      logError('Remove Box $boxName Error => $e');
      return DataResult.fromHiveFailure(dataValue: false, messageValue: e.toString());
    }
  }

  Future<DataResult<bool>> removeAll() async {
    logProcess('Remove All Box $boxName');
    try {
      final box = await openBox();
      await box.clear();
      logInfo('Sucess => Box $boxName');
      return DataResult.fromHive(dataValue: true);
    } catch (e) {
      logError('Remove All Box $boxName Error => $e');
      return DataResult.fromHiveFailure(dataValue: false, messageValue: e.toString());
    }
  }

  Future<DataResult<bool>> update(T? item) async {
    logProcess('Update Box $boxName Item: $item');
    if (item == null) {
      logError('Update Box $boxName Error => Item Null');
      return DataResult.fromHiveFailure(dataValue: false, messageValue: 'Item Null');
    }
    try {
      final box = await openBox();
      await box.put(item.key, item);
      logInfo('Sucess => Key: ${item.key}');
      return DataResult.fromHive(dataValue: true);
    } catch (e) {
      logError('Update Box $boxName Error => $e');
      return DataResult.fromHiveFailure(dataValue: false, messageValue: e.toString());
    }
  }

  Future<DataResult<bool>> updateAll(Map<dynamic, T> items) async {
    logProcess('Update Box $boxName Item: $items');
    try {
      final box = await openBox();
      await box.putAll(items);
      logInfo('Sucess => Keys: ${items.keys.toList()}');
      return DataResult.fromHive(dataValue: true);
    } catch (e) {
      logError('Update Box $boxName Error => $e');
      return DataResult.fromHiveFailure(dataValue: false, messageValue: e.toString());
    }
  }

  Future<DataResult<bool>> addOrUpdate(T? item) async {
    logProcess('Update Or Add Box $boxName Item: $item');
    if (item == null) {
      logError('Update Box $boxName Error => Item Null');
      return DataResult.fromHiveFailure(dataValue: false, messageValue: 'Item Null');
    }
    try {
      final box = await openBox();
      if (item.isInBox) {
        await box.put(item.key, item);
        logInfo('Sucess Update => Key: ${item.key}');
        return DataResult.fromHive(dataValue: true, messageValue: 'Pembaharuan berhasil disimpan');
      } else {
        await box.add(item);
        logInfo('Sucess Add => Key: ${item.key}');
        return DataResult.fromHive(dataValue: true, messageValue: 'Berhasil menyimpan data');
      }
    } catch (e) {
      logError('Update Box $boxName Error => $e');
      return DataResult.fromHiveFailure(dataValue: false, messageValue: e.toString());
    }
  }

  void logProcess(dynamic value, {String? vTag = tag}) {
    Log.v(value, tag: vTag);
  }

  void logInfo(dynamic value, {String? vTag = tag}) {
    Log.i(value, tag: vTag == 'x' ? null : vTag);
  }

  void logError(dynamic value, {String? vTag = tag}) {
    Log.e(value, tag: vTag);
  }
}
