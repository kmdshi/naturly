import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naturly/src/core/common/layout/layout.dart';
import 'package:naturly/src/core/common/router/router.gr.dart';
import 'package:naturly/src/core/widget/alert_snackbar.dart';
import 'package:naturly/src/feature/account/presentation/bloc/account_bloc.dart';
import 'package:naturly/src/feature/account/presentation/widgets/registration_screen_desktop.dart';
import 'package:naturly/src/feature/account/presentation/widgets/registration_screen_mobile.dart';

@RoutePage()
class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<AccountBloc, AccountState>(
        listener: (context, state) {
          if (state is AccountLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => Center(child: CircularProgressIndicator()),
            );
          } else if (state is AccountRegistred) {
            Navigator.of(context, rootNavigator: true).pop();
          } else if (state is AccountFailure) {
            Navigator.of(context, rootNavigator: true).pop();
            showCustomSnackBar(context, state.message);
          }
        },
        child: BlocBuilder<AccountBloc, AccountState>(
          buildWhen: (previous, current) => current is! AccountFailure,
          builder: (context, state) {
            if (state is AccountRegistred) {
              Future.microtask(() {
                context.router.pushAndPopUntil(
                  ProfileDataFillRoute(),
                  predicate: (route) => false,
                );
              });
              return SizedBox.shrink();
            } else {
              return WindowSizeScope.of(context).isCompact ||
                      WindowSizeScope.of(context).isMedium
                  ? RegistrationScreenMobile()
                  : RegistrationScreenDesktop();
            }
          },
        ),
      ),
    );
  }
}
