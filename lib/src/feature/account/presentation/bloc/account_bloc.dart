import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naturly/src/feature/account/domain/repository/account_init_repository.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final AccountInitRepository accountInitRepository;
  AccountBloc({required this.accountInitRepository}) : super(AccountInitial()) {
    on<AccountRegistrationEvent>(_accountReg);
    on<AccountSingInEvent>(_accountSignIn);
  }

  Future<void> _accountReg(
    AccountRegistrationEvent event,
    Emitter<AccountState> emit,
  ) async {
    try {
      emit(AccountLoading());
      await accountInitRepository.signUp(
        event.email,
        event.password,
      );
      emit(AccountLoaded());
    } catch (e) {
      emit(AccountFailure(message: e.toString()));
    }
  }

  Future<void> _accountSignIn(
    AccountSingInEvent event,
    Emitter<AccountState> emit,
  ) async {
    try {
      emit(AccountLoading());
      await accountInitRepository.signIn(event.email, event.password);
      emit(AccountLoaded());
    } catch (e) {
      emit(AccountFailure(message: e.toString()));
    }
  }
}
