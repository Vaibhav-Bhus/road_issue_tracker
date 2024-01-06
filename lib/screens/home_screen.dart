import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_aqua_cart/constants/string_constants.dart';
import 'package:test_aqua_cart/screens/add_new_issue_screen.dart';
import 'package:test_aqua_cart/screens/issues_screen.dart';
import 'package:test_aqua_cart/screens/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<IconData> listOfIcons = [
    Icons.do_not_touch_outlined,
    Icons.add_location_alt_outlined,
    Icons.settings_rounded,
  ];

  final List<String> listOfStrings = [
    'Issues',
    'Add',
    'Setting',
  ];

  var currentIndex = 0;
  _getBody(int index) {
    switch (index) {
      case 0:
        return const IssuesScreen();
      case 1:
        return const AddNewIssueScreen();
      case 2:
        return const SettingsScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        centerTitle: true,
        title: Text(
          StringConstants.appName,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
          ),
        ),
      ),
      bottomNavigationBar: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.all(MediaQuery.of(context).size.width * .05),
        height: MediaQuery.of(context).size.width * .155,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.1),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
          borderRadius: BorderRadius.circular(50),
        ),
        child: ListView.builder(
          itemCount: 3,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * .02),
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              setState(() {
                currentIndex = index;
                HapticFeedback.lightImpact();
              });
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Stack(
              children: [
                AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  curve: Curves.fastLinearToSlowEaseIn,
                  width: index == currentIndex
                      ? MediaQuery.of(context).size.width * .32
                      : MediaQuery.of(context).size.width * .18,
                  alignment: Alignment.center,
                  child: AnimatedContainer(
                    duration: const Duration(seconds: 1),
                    curve: Curves.fastLinearToSlowEaseIn,
                    height: index == currentIndex
                        ? MediaQuery.of(context).size.width * .12
                        : 0,
                    width: index == currentIndex
                        ? MediaQuery.of(context).size.width * .32
                        : 0,
                    decoration: BoxDecoration(
                      color: index == currentIndex
                          ? Colors.blueAccent.withOpacity(.2)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  curve: Curves.fastLinearToSlowEaseIn,
                  width: index == currentIndex
                      ? MediaQuery.of(context).size.width * .30.sp
                      : MediaQuery.of(context).size.width * .30.sp,
                  alignment: Alignment.center,
                  child: Stack(
                    children: [
                      Row(
                        children: [
                          AnimatedContainer(
                            duration: const Duration(seconds: 1),
                            curve: Curves.fastLinearToSlowEaseIn,
                            width: index == currentIndex
                                ? MediaQuery.of(context).size.width * .13
                                : 0,
                          ),
                          AnimatedOpacity(
                            opacity: index == currentIndex ? 1 : 0,
                            duration: const Duration(seconds: 1),
                            curve: Curves.fastLinearToSlowEaseIn,
                            child: Text(
                              index == currentIndex ? listOfStrings[index] : '',
                              style: const TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          AnimatedContainer(
                            duration: const Duration(seconds: 1),
                            curve: Curves.fastLinearToSlowEaseIn,
                            width: index == currentIndex
                                ? MediaQuery.of(context).size.width * .03
                                : 20,
                          ),
                          Icon(
                            listOfIcons[index],
                            size: MediaQuery.of(context).size.width * .076,
                            color: index == currentIndex
                                ? Colors.blueAccent
                                : Colors.black26,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: _getBody(currentIndex),
    );
  }
}
