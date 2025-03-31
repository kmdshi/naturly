part of 'account_bloc.dart';

sealed class AccountState extends Equatable {
  const AccountState();

  @override
  List<Object> get props => [];
}

final class AccountInitial extends AccountState {}

final class AccountLoading extends AccountState {}

final class AccountLoaded extends AccountState {}

class AccountFailure extends AccountState {
  final String message;
  const AccountFailure({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
