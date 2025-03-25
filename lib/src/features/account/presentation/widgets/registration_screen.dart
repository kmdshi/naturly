import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:naturly/src/core/router/routes.gr.dart';

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
              TextField(),
              SizedBox(height: 15),
              TextField(),
              Row(
                children: [
                  Text('Already have an account?'),
                  TextButton(
                    onPressed: () {},
                    child: Text('Log in'),
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
                child: Text('Registration'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
