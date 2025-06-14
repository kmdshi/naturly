import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naturly/src/core/common/layout/layout.dart';
import 'package:naturly/src/core/common/router/router.gr.dart';
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
      body: BlocListener<AccountBloc, AccountState>(
        listener: (context, state) {
          if (state is AccountLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => Center(child: CircularProgressIndicator()),
            );
          } else if (state is AccountRegistred || state is AccountFailure) {
            Navigator.of(context, rootNavigator: true).pop();
          }
        },
        child: BlocBuilder<AccountBloc, AccountState>(
          builder: (context, state) {
            if (state is AccountInitial) {
              return WindowSizeScope.of(context).isCompact ||
                      WindowSizeScope.of(context).isMedium
                  ? RegistrationScreenMobile()
                  : RegistrationScreenDesktop();
            } else if (state is AccountRegistred) {
              Future.microtask(() {
                context.router.pushAndPopUntil(
                  ProfileDataFillRoute(),
                  predicate: (route) => false,
                );
              });
              return SizedBox.shrink();
            } else {
              return SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
