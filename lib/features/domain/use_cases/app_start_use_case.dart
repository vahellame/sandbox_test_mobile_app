import 'package:flutter/cupertino.dart';

import '../../../core/dependency_injection/controllers_injection.dart';
import '../../../core/dependency_injection/persistent_injection.dart';
import '../../../core/dependency_injection/states_injection.dart';
import '../../../core/sql/sql.dart';

class AppStartUseCase {
  static Future<void> execute() async {
    WidgetsFlutterBinding.ensureInitialized();

    await SQL.init();

    PersistentInjection.inject();
    StatesInjection.inject();
    ControllersInjections.inject();
  }
}
