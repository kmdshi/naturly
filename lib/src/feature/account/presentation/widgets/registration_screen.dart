import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naturly/src/core/common/router/router.gr.dart';
import 'package:naturly/src/core/widget/root_screen.dart';
import 'package:naturly/src/feature/account/presentation/bloc/account_bloc.dart';
import 'package:naturly/src/feature/account/presentation/widgets/login_screen.dart';

@RoutePage()
class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

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
          } else if (state is AccountLoaded || state is AccountFailure) {
            Navigator.of(context, rootNavigator: true).pop();
          }
        },
        child: BlocBuilder<AccountBloc, AccountState>(
          builder: (context, state) {
            if (state is AccountInitial) {
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal:
                      MediaQuery.sizeOf(context).width > 600
                          ? MediaQuery.sizeOf(context).width * 0.3
                          : MediaQuery.sizeOf(context).width * 0.1,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Registration'),
                      TextField(controller: emailController),
                      SizedBox(height: 15),
                      TextField(controller: passwordController),
                      Row(
                        children: [
                          Text('Already have an account?'),
                          TextButton(
                            onPressed:
                                () => Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (
                                      context,
                                      animation,
                                      secondaryAnimation,
                                    ) {
                                      return LoginScreen();
                                    },
                                  ),
                                ),
                            child: Text('Log in'),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed:
                            () => context.read<AccountBloc>().add(
                              AccountRegistrationEvent(
                                email: emailController.text,
                                password: passwordController.text,
                              ),
                            ),
                        child: Text('Registration'),
                      ),
                    ],
                  ),
                ),
              );
            } else if (state is AccountLoaded) {
              Future.microtask(() {
                context.router.pushAndPopUntil(
                  HomeTab(),
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
