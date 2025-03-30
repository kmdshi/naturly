import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:naturly/src/core/router/routes.gr.dart';
import 'package:naturly/src/features/account/data/data_source/remote/supabase_account_ds.dart';
import 'package:naturly/src/features/account/data/repository/account_init_repository.dart';

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

  final rep = SupabaseRemoteAccountDS();
  void reg() async {
    final res = await rep.signUpWithEmailPassword(
        emailController.text, passwordController.text);
    if (res.user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration failed. Please try again.')),
      );
    } else {
      context.router.pushAndPopUntil(
        HomeRoute(),
        predicate: (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.sizeOf(context).width > 600
              ? MediaQuery.sizeOf(context).width * 0.3
              : MediaQuery.sizeOf(context).width * 0.1,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Registration'),
              TextField(
                controller: emailController,
              ),
              SizedBox(height: 15),
              TextField(
                controller: passwordController,
              ),
              Row(
                children: [
                  Text('Already have an account?'),
                  TextButton(
                    onPressed: () => context.router.pushAndPopUntil(
                      LoginRoute(),
                      predicate: (route) => false,
                    ),
                    child: Text('Log in'),
                  )
                ],
              ),
              ElevatedButton(
                onPressed: () => reg(),
                child: Text('Registration'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
