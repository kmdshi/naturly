import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:naturly/src/feature/settings/domain/repository/settings_repository.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsRepository settingsRepository;
  SettingsBloc({required this.settingsRepository}) : super(SettingsInitial()) {
    on<SettingsLogOutEvent>(_logOut);
  }

  Future<void> _logOut(
    SettingsLogOutEvent event,
    Emitter<SettingsState> emit,
  ) async {
    try {
      emit(SettingsLoading());
      await settingsRepository.logOut();
      emit(SettingsLoaded());
    } catch (e) {
      emit(SettingsFailure(message: e.toString()));
    }
  }
}
