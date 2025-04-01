import 'package:naturly/src/core/common/models/human_profile.dart';

abstract class AccountInitRepository {
  Future<void> signUp(final String email, final String password);
  Future<void> signIn(final String email, final String password);
  Future<void> accountFill(final Human user);
}
