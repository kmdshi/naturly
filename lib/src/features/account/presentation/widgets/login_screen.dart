import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:naturly/src/core/router/routes.gr.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Root Screen')),
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
              TextField(),
              SizedBox(height: 15),
              TextField(),
              Row(
                children: [
                  Text('Don\'t have an account?'),
                  TextButton(
                    onPressed: () {},
                    child: Text('Register'),
                  )
                ],
              ),
              ElevatedButton(
                onPressed: () => context.router.pushAndPopUntil(
                  ProfileDataFillRoute(),
                  predicate: (route) {
                    return false;
                  },
                ),
                child: Text('Log in'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
