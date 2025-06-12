part of 'account_bloc.dart';

sealed class AccountEvent extends Equatable {
  const AccountEvent();

  @override
  List<Object> get props => [];
}

class InitialEvent extends AccountEvent {}

class AccountRegistrationEvent extends AccountEvent {
  final String email;
  final String password;

  const AccountRegistrationEvent({required this.email, required this.password});
  @override
  List<Object> get props => [email, password];
}

class AccountLogInEvent extends AccountEvent {
  final String email;
  final String password;

  const AccountLogInEvent({required this.email, required this.password});
  @override
  List<Object> get props => [email, password];
}

class AccountFillEvent extends AccountEvent {
  final Human user;

  const AccountFillEvent({required this.user});
  @override
  List<Object> get props => [user];
}
