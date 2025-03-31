import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naturly/src/core/common/features/initialization/widget/dependencies_scope.dart';
import 'package:naturly/src/core/common/features/settings/bloc/app_settings_bloc.dart';
import 'package:naturly/src/core/common/features/settings/model/app_settings.dart';


class SettingsScope extends StatefulWidget {
  const SettingsScope({required this.child, super.key});

  final Widget child;

  static AppSettingsBloc of(BuildContext context, {bool listen = true}) {
    final settingsScope =
        listen
            ? context.dependOnInheritedWidgetOfExactType<_InheritedSettings>()
            : context.getInheritedWidgetOfExactType<_InheritedSettings>();
    return settingsScope!.state._appSettingsBloc;
  }

  static AppSettings settingsOf(BuildContext context, {bool listen = true}) {
    final settingsScope =
        listen
            ? context.dependOnInheritedWidgetOfExactType<_InheritedSettings>()
            : context.getInheritedWidgetOfExactType<_InheritedSettings>();
    return settingsScope!.settings ?? const AppSettings();
  }

  @override
  State<SettingsScope> createState() => _SettingsScopeState();
}

class _SettingsScopeState extends State<SettingsScope> {
  late final AppSettingsBloc _appSettingsBloc;

  @override
  void initState() {
    super.initState();
    _appSettingsBloc = DependenciesScope.of(context).appSettingsBloc;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppSettingsBloc, AppSettingsState>(
      bloc: _appSettingsBloc,
      builder:
          (context, state) =>
              _InheritedSettings(settings: state.appSettings, state: this, child: widget.child),
    );
  }
}


class _InheritedSettings extends InheritedWidget {
  const _InheritedSettings({required super.child, required this.state, required this.settings});

  final _SettingsScopeState state;
  final AppSettings? settings;

  @override
  bool updateShouldNotify(covariant _InheritedSettings oldWidget) => settings != oldWidget.settings;
}
