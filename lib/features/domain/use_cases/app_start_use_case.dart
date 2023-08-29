import 'package:flutter/cupertino.dart';

import '../../../core/sql/sql.dart';
import '../../../dependency_injection/controllers_injection.dart';
import '../../../dependency_injection/persistent_injections.dart';
import '../../../dependency_injection/states_injection.dart';

class AppStartUseCase {
  static Future<void> execute() async {
    WidgetsFlutterBinding.ensureInitialized();

    await SQL.init();

    PersistentInjections.inject();
    StatesInjections.inject();
    ControllersInjections.inject();
  }
}
