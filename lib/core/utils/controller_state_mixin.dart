import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../features/domain/controllers/controller.dart';

mixin ControllerStateMixin<CurrentStatefulWidget extends StatefulWidget,
    CurrentController extends Controller> on State<CurrentStatefulWidget> {
  CurrentController get cr => context.read<CurrentController>();

  CurrentController get cw => context.watch<CurrentController>();
}
