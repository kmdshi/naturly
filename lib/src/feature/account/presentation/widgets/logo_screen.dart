import 'package:flutter/material.dart';

class LogoScreen extends StatelessWidget {
  const LogoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          stops: [0.0, 0.5, 1.0],
          colors: [Color(0xFF2C3E50), Color(0xFF223144), Color(0xFF1E2A38)],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/icons/star.png',
              width: 72,
              height: 72,
            ), // TODO: перенести в константы
            SizedBox(height: 15),
            Text(
              'Start changing your diet\neasily with naturly.',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 60,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              'Forget the hassle — eating can be easy.',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 18,
                color: Colors.grey.shade200,
                fontWeight: FontWeight.w500,
              ),
            ),
            // TODO:  Image.asset('assets/images/peoples.png'),
          ],
        ),
      ),
    );
  }
}
