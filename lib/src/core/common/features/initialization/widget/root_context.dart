import 'package:flutter/material.dart';
import 'package:naturly/src/core/common/features/initialization/logic/composition_root.dart';
import 'package:naturly/src/core/common/features/initialization/widget/dependencies_scope.dart';
import 'package:naturly/src/core/common/features/initialization/widget/material_context.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:naturly/src/core/common/layout/window_size.dart';
import 'package:naturly/src/core/common/features/settings/widget/settings_scope.dart';


class RootContext extends StatelessWidget {
  const RootContext({required this.compositionResult, super.key});

  final CompositionResult compositionResult;

  @override
  Widget build(BuildContext context) {
    return DefaultAssetBundle(
      bundle: SentryAssetBundle(),
      child: DependenciesScope(
        dependencies: compositionResult.dependencies,
        child: const SettingsScope(child: WindowSizeScope(child: MaterialContext())),
      ),
    );
  }
}
