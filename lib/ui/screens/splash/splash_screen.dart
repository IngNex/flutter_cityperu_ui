import 'package:flutter/material.dart';
import 'package:flutter_cityperu_ui/ui/screens/home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 5),
      () => Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, _) {
            return FadeTransition(
              opacity: animation,
              child: const HomeScreen(),
            );
          },
        ),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: size.height * 0.4,
            child: Column(
              children: [
                Container(
                  width: 180,
                  height: 180,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/peru.jpg'),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                RichText(
                  text: const TextSpan(
                    text: 'Tour',
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.red,
                        shadows: [
                          Shadow(blurRadius: 2, color: Colors.red),
                        ],
                        fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(
                        text: 'City',
                        style: TextStyle(
                          color: Colors.white,
                          shadows: [Shadow(blurRadius: 2, color: Colors.black)],
                        ),
                      ),
                      TextSpan(text: 'Perú'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Positioned(
            bottom: 15,
            child: Text(
              'byMaicolDev',
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
