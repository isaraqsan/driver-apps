import 'package:gibas/core/utils/log.dart';
import 'package:gibas/data/database/brand_hive.dart';
import 'package:gibas/data/database/channel_hive.dart';
import 'package:gibas/data/database/display_type_hive.dart';
import 'package:gibas/data/database/regional_hive.dart';
import 'package:gibas/data/database/sub_area_hive.dart';
import 'package:gibas/data/database/sub_channel_hive.dart';
import 'package:gibas/data/repositories/brand_repository.dart';
import 'package:gibas/data/repositories/channel_repository.dart';
import 'package:gibas/data/repositories/display_type_repository.dart';
import 'package:gibas/data/repositories/regional_repository.dart';
import 'package:gibas/data/repositories/sub_area_repository.dart';
import 'package:gibas/data/repositories/sub_channel_repository.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
export 'package:gibas/core/app/database_key.dart';

class DatabaseService extends GetxService {
  late GetStorage getStorage;

  Future<DatabaseService> init() async {
    await GetStorage.init();
    getStorage = GetStorage();
    await registerAdapter();
    return this;
  }

  Future write(String key, dynamic value) => getStorage.write(key, value);

  Future<dynamic> read(String key) async => await getStorage.read(key);

  Future<void> remove(String key) async => getStorage.remove(key);

  bool hasData(String key) => getStorage.hasData(key);

  Future clear() async => getStorage.erase();

  Future registerAdapter() async {
    Log.v('Register Adapter', tag: runtimeType.toString());
    //* Database
    final appDocumentDirectory = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);
    // Hive.registerAdapter(AuthHiveAdapter());
    Hive.registerAdapter(BrandHiveAdapter());
    Hive.registerAdapter(DisplayTypeHiveAdapter());
    Hive.registerAdapter(RegionalHiveAdapter());
    Hive.registerAdapter(SubAreaHiveAdapter());
    Hive.registerAdapter(ChannelHiveAdapter());
    Hive.registerAdapter(SubChannelHiveAdapter());
  }

  Future<bool> clearDatasource() async {
    Log.v('Clear Datasource', tag: runtimeType.toString());
    try {
      await BrandRepository().removeAll();
      await DisplayTypeRepository().removeAll();
      await RegionalRepository().removeAll();
      await SubAreaRepository().removeAll();
      await ChannelRepository().removeAll();
      await SubChannelRepository().removeAll();
      await clear();
      return true;
    } catch (e) {
      Log.e('Clear Datasource Error => $e', tag: runtimeType.toString());
      return false;
    }
  }
}
