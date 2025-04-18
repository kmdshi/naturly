part of 'settings_bloc.dart';

sealed class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object> get props => [];
}

final class SettingsInitial extends SettingsState {}

final class SettingsLoading extends SettingsState {}

final class SettingsLoaded extends SettingsState {}

final class SettingsFailure extends SettingsState {
  final String message;

  const SettingsFailure({required this.message});
  @override
  List<Object> get props => [message];
}
