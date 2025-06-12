import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naturly/src/core/common/models/human_profile.dart';
import 'package:naturly/src/feature/account/domain/repository/account_init_repository.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final AccountInitRepository accountInitRepository;
  AccountBloc({required this.accountInitRepository}) : super(AccountInitial()) {
    on<InitialEvent>(_init);
    on<AccountRegistrationEvent>(_accountReg);
    on<AccountLogInEvent>(_accountSignIn);
    on<AccountFillEvent>(_accountFill);
  }

  Future<void> _accountFill(
    AccountFillEvent event,
    Emitter<AccountState> emit,
  ) async {
    try {
      emit(AccountLoading());
      await accountInitRepository.accountFill(event.user);
      emit(AccountAuthorized());
    } catch (e) {
      emit(AccountFailure(message: e.toString()));
    }
  }

  Future<void> _init(InitialEvent event, Emitter<AccountState> emit) async {
    try {
      emit(AccountInitial());
    } catch (e) {
      emit(AccountFailure(message: e.toString()));
    }
  }

  Future<void> _accountReg(
    AccountRegistrationEvent event,
    Emitter<AccountState> emit,
  ) async {
    try {
      emit(AccountLoading());
      await accountInitRepository.signUp(event.email, event.password);
      emit(AccountRegistred());
    } catch (e) {
      emit(AccountFailure(message: e.toString()));
    }
  }

  Future<void> _accountSignIn(
    AccountLogInEvent event,
    Emitter<AccountState> emit,
  ) async {
    try {
      emit(AccountLoading());
      await accountInitRepository.signIn(event.email, event.password);
      emit(AccountAuthorized());
    } catch (e) {
      emit(AccountFailure(message: e.toString()));
    }
  }
}
