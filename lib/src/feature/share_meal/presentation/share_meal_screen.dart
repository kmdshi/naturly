import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ShareMealScreen extends StatefulWidget {
  const ShareMealScreen({super.key});

  @override
  State<ShareMealScreen> createState() => _ShareMealScreenState();
}

class _ShareMealScreenState extends State<ShareMealScreen> {
  @override
  Widget build(BuildContext context) {
    final routeData = RouteData.of(context);
    final id = routeData.queryParams.get('id');

    return Scaffold(body: Center(child: Text('ок работает ${id}')));
  }
}
