import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:test_aqua_cart/constants/string_constants.dart';
import 'package:test_aqua_cart/services/auth_services.dart';
import 'package:test_aqua_cart/widgets/custom_toast.dart';
import 'package:test_aqua_cart/widgets/login_painter.dart';
import 'package:test_aqua_cart/widgets/vb_login_button.dart';
import 'package:test_aqua_cart/widgets/vb_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  late AnimationController controller1;
  late AnimationController controller2;
  late Animation<double> animation1;
  late Animation<double>? animation2;
  late Animation<double>? animation3;
  late Animation<double> animation4;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  bool isLogin = true;

  @override
  void initState() {
    super.initState();

    controller1 = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 5,
      ),
    );
    animation1 = Tween<double>(begin: .1, end: .15).animate(
      CurvedAnimation(
        parent: controller1,
        curve: Curves.easeInOut,
      ),
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller1.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller1.forward();
        }
      });
    animation2 = Tween<double>(begin: .02, end: .04).animate(
      CurvedAnimation(
        parent: controller1,
        curve: Curves.easeInOut,
      ),
    )..addListener(() {
        setState(() {});
      });

    controller2 = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 5,
      ),
    );
    animation3 = Tween<double>(begin: .41, end: .38).animate(CurvedAnimation(
      parent: controller2,
      curve: Curves.easeInOut,
    ))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller2.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller2.forward();
        }
      });
    animation4 = Tween<double>(begin: 170, end: 190).animate(
      CurvedAnimation(
        parent: controller2,
        curve: Curves.easeInOut,
      ),
    )..addListener(() {
        setState(() {});
      });

    Timer(const Duration(milliseconds: 2500), () {
      controller1.forward();
    });

    controller2.forward();
  }

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
          child: SizedBox(
            height: size.height,
            child: Stack(
              children: [
                Positioned(
                  top: size.height * (animation2!.value + .58),
                  left: size.width * .21,
                  child: CustomPaint(
                    painter: MyPainter(50),
                  ),
                ),
                Positioned(
                  top: size.height * .98,
                  left: size.width * .1,
                  child: CustomPaint(
                    painter: MyPainter(animation4.value - 30),
                  ),
                ),
                Positioned(
                  top: size.height * .5,
                  left: size.width * (animation2!.value + .8),
                  child: CustomPaint(
                    painter: MyPainter(30),
                  ),
                ),
                Positioned(
                  top: size.height * animation3!.value,
                  left: size.width * (animation1.value + .1),
                  child: CustomPaint(
                    painter: MyPainter(60),
                  ),
                ),
                Positioned(
                  top: size.height * .1,
                  left: size.width * .8,
                  child: CustomPaint(
                    painter: MyPainter(animation4.value),
                  ),
                ),
                Column(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: EdgeInsets.only(top: size.height * .1),
                        child: Text(
                          StringConstants.appName,
                          style: TextStyle(
                            color: Colors.white.withOpacity(.7),
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                            wordSpacing: 4,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          if (!isLogin)
                            VBTextField(
                                controller: _usernameController,
                                hintText: 'User name...',
                                icon: Icons.account_circle_outlined,
                                isEmail: false,
                                isPassword: false),
                          VBTextField(
                              controller: _emailController,
                              hintText: 'Email...',
                              icon: Icons.email_outlined,
                              isEmail: true,
                              isPassword: false),
                          VBTextField(
                              controller: _passwordController,
                              hintText: 'Password...',
                              icon: Icons.lock_outline,
                              isEmail: false,
                              isPassword: true),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              VBLoginButton(
                                title: isLogin ? 'SIGN IN' : "SIGN UP",
                                width: 2.58,
                                voidCallback: () {
                                  if (_emailController.text.isNotEmpty &&
                                      _passwordController.text.isNotEmpty &&
                                      (isLogin ||
                                          _usernameController
                                              .text.isNotEmpty)) {
                                    if (isLogin) {
                                      context
                                          .read<AuthService>()
                                          .signInWithEmailAndPassword(
                                            _emailController.text.trim(),
                                            _passwordController.text.trim(),
                                          )
                                          .then((value) {
                                        log(value);
                                        value == 'success'
                                            ? context.go('/homescreen')
                                            : customToast(value);
                                      });
                                    } else {
                                      context
                                          .read<AuthService>()
                                          .signUpWithEmailAndPassword(
                                            _emailController.text.trim(),
                                            _passwordController.text.trim(),
                                          )
                                          .then((value) {
                                        value == 'success'
                                            ? context.go('/homescreen')
                                            : customToast(value);
                                      });
                                    }
                                  } else {
                                    customToast("Please fill all the fields");
                                  }
                                },
                              ),
                              // SizedBox(width: size.width / 20),
                              // VBLoginButton(
                              //   title: 'Forgotten password!',
                              //   width: 2.58,
                              //   voidCallback: () {
                              //     HapticFeedback.lightImpact();
                              //     customToast(
                              //         'Forgotten password button pressed');
                              //   },
                              // ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          VBLoginButton(
                            title: isLogin
                                ? 'Create a new Account'
                                : "Already have an account",
                            width: 2,
                            voidCallback: () {
                              setState(() {
                                isLogin = !isLogin;
                              });
                              HapticFeedback.lightImpact();
                            },
                          ),
                          SizedBox(height: size.height * .05),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
