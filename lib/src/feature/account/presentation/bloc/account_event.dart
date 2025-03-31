part of 'account_bloc.dart';

sealed class AccountEvent extends Equatable {
  const AccountEvent();

  @override
  List<Object> get props => [];
}

class AccountRegistrationEvent extends AccountEvent {
  final String email;
  final String password;

  const AccountRegistrationEvent({
    required this.email,
    required this.password,
  });
  @override
  List<Object> get props => [email, password];
}

class AccountSingInEvent extends AccountEvent {
  final String email;
  final String password;

  const AccountSingInEvent({
    required this.email,
    required this.password,
  });
  @override
  List<Object> get props => [email, password];
}
