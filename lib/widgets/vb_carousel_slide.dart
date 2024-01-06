import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VBImageSlider extends StatefulWidget {
  final List<String> imageUrls;

  const VBImageSlider({super.key, required this.imageUrls});

  @override
  State<VBImageSlider> createState() => _VBImageSliderState();
}

class _VBImageSliderState extends State<VBImageSlider> {
  int _currentIndex = 0;
  final CarouselController _carouselController = CarouselController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: widget.imageUrls.map((imageUrl) {
            return Container(
              margin: const EdgeInsets.all(25.0),
              child: Image.network(imageUrl, fit: BoxFit.cover),
            );
          }).toList(),
          carouselController: _carouselController,
          options: CarouselOptions(
            height: 200.0.h,
            enlargeCenterPage: true,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.imageUrls.length,
            (index) => buildDot(index: index),
          ),
        ),
      ],
    );
  }

  Widget buildDot({
    required int index,
  }) {
    return Padding(
      padding: EdgeInsets.all(8.0.sp),
      child: Container(
        width: 8.0.w,
        height: 8.0.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _currentIndex == index ? Colors.blue : Colors.grey,
        ),
      ),
    );
  }
}
