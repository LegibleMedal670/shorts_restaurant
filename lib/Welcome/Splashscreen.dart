import 'package:flutter/material.dart';
import 'package:shorts_restaurant/Shorts/pages/video_page.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  ///스플래시스크린에서 로그인 여부 등 확인하고 다음 페이지로 이동
  ///현재는 파이어베이스를 통한 로그인만 감지
  ///이후 소셜 로그인 관련 추가한 뒤에 업데이트 필요
  void _navigateToNextScreen() async {
    await Future.delayed(const Duration(milliseconds: 1500));
      Navigator.pushReplacement(
        context,
        _buildPageRoute(const VideoPage()),
      );
  }

  ///부드러운전환을위한??? 설명필요
  PageRouteBuilder _buildPageRoute(Widget screen) {
    return PageRouteBuilder(
      pageBuilder: (context, animation1, animation2) => screen,
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
    );
  }

  ///현재는 단순한 텍스트만 있음 추후 애니메이션 혹은 아이콘 추가 업데이트
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          'Shorts',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Jua',
            fontSize: MediaQuery.of(context).size.height * (50 / 812),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
