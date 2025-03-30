import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:naturly/src/core/router/routes.gr.dart';
import 'package:naturly/src/features/account/data/data_source/remote/supabase_account_ds.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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

  void auth() async {
    final res = await rep.signInWithEmailPassword(
        emailController.text, passwordController.text);
    if (res.session == null) {
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
              Text('Log in'),
              TextField(
                controller: emailController,
              ),
              SizedBox(height: 15),
              TextField(
                controller: passwordController,
              ),
              Row(
                children: [
                  Text('Don\'t have an account?'),
                  TextButton(
                    onPressed: () => context.router.pushAndPopUntil(
                      RegistrationRoute(),
                      predicate: (route) => false,
                    ),
                    child: Text('Register'),
                  )
                ],
              ),
              ElevatedButton(
                onPressed: () => auth(),
                child: Text('Log in'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
