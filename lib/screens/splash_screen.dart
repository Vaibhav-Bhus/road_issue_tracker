import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:particles_flutter/particles_flutter.dart';
import 'package:test_aqua_cart/constants/image_constants.dart';
import 'package:test_aqua_cart/constants/string_constants.dart';
import 'package:test_aqua_cart/constants/text_style_constants.dart';

class CustomSplashScreen extends StatefulWidget {
  const CustomSplashScreen({Key? key}) : super(key: key);

  @override
  State<CustomSplashScreen> createState() => _CustomSplashScreenState();
}

class _CustomSplashScreenState extends State<CustomSplashScreen>
    with TickerProviderStateMixin {
  double _fontSize = 2.sp;
  double _containerSize = 1.5;
  double _textOpacity = 0.0;
  double _containerOpacity = 0.0;

  late AnimationController _controller;
  late Animation<double> animation1;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));

    animation1 = Tween<double>(begin: 40, end: 20).animate(CurvedAnimation(
        parent: _controller, curve: Curves.fastLinearToSlowEaseIn))
      ..addListener(() {
        setState(() {
          _textOpacity = 1.0;
        });
      });

    _controller.forward();

    Timer(const Duration(seconds: 2), () {
      setState(() {
        _fontSize = 1.06;
      });
    });

    Timer(const Duration(seconds: 2), () {
      setState(() {
        _containerSize = 2;
        _containerOpacity = 1;
      });
    });

    Timer(const Duration(seconds: 4), () {
      setState(() {
        context.go("/login");
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          CircularParticle(
            width: 428.w,
            height: 926.h,
            numberOfParticles: 150,
            speedOfParticles: 1.5,
            maxParticleSize: 7,
            awayRadius: 0,
            onTapAnimation: false,
            isRandSize: true,
            isRandomColor: true,
            randColorList: [
              const Color(0xffFD5E3D),
              const Color(0xffC43990),
              Colors.white.withOpacity(.6)
            ],
            connectDots: false,
            enableHover: false,
          ),
          Column(
            children: [
              AnimatedContainer(
                  duration: const Duration(milliseconds: 2000),
                  curve: Curves.fastLinearToSlowEaseIn,
                  height: height / _fontSize - 25.sp),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 1000),
                opacity: _textOpacity,
                child: AnimatedTextKit(
                  animatedTexts: [
                    TyperAnimatedText(
                      StringConstants.appName,
                      textStyle: splashScreenNameStyle,
                      speed: const Duration(milliseconds: 90),
                    ),
                  ],
                  totalRepeatCount: 1,
                  displayFullTextOnTap: true,
                  stopPauseOnTap: true,
                ),
              ),
            ],
          ),
          Center(
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 2000),
              curve: Curves.fastLinearToSlowEaseIn,
              opacity: _containerOpacity,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 2000),
                curve: Curves.fastLinearToSlowEaseIn,
                height: width / _containerSize,
                width: width / _containerSize,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: Image.asset(ImageConstants.appLogo),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
