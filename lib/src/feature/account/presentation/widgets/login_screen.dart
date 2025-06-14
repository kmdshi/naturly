import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naturly/src/core/common/layout/layout.dart';
import 'package:naturly/src/core/common/router/router.gr.dart';
import 'package:naturly/src/core/widget/alert_snackbar.dart';
import 'package:naturly/src/feature/account/presentation/bloc/account_bloc.dart';
import 'package:naturly/src/feature/account/presentation/widgets/login_screen_desktop.dart';
import 'package:naturly/src/feature/account/presentation/widgets/login_screen_mobile.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AccountBloc, AccountState>(
      listener: (context, state) {
        if (state is AccountFailure) {
          showCustomSnackBar(context, state.message);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: BlocBuilder<AccountBloc, AccountState>(
          builder: (context, state) {
            if (state is AccountAuthorized) {
              Future.microtask(() {
                context.router.pushAndPopUntil(
                  HomeTab(),
                  predicate: (route) => false,
                );
              });
              return SizedBox.shrink();
            } else {
              return WindowSizeScope.of(context).isCompact ||
                      WindowSizeScope.of(context).isMedium
                  ? LoginScreenMobile()
                  : LoginScreenDesktop();
            }
          },
        ),
      ),
    );
  }
}
