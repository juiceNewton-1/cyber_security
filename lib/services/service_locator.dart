import 'package:get_it/get_it.dart';
import 'package:cyber_security/services/articles_api_service.dart';
import 'package:cyber_security/services/database/database_service.dart';
import 'package:cyber_security/services/remote_config_service.dart';

class ServiceLocator {
  static Future<void> setup() async {
    GetIt.I.registerSingletonAsync(() => DatabaseService().init());
    await GetIt.I.isReady<DatabaseService>();
    GetIt.I.registerSingletonAsync(() => RemoteConfigService().init());
    await GetIt.I.isReady<RemoteConfigService>();
    GetIt.I.registerSingleton<ArticlesApiService>(ArticlesApiService());
  }
}
