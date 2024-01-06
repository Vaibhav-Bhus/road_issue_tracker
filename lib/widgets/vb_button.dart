import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class VBButton extends StatelessWidget {
  final String? text;
  final void Function()? onTap;
  final bool isLoading;
  final bool outlined;
  final bool dense;
  final double? width;
  const VBButton({
    super.key,
    this.onTap,
    this.text,
    this.isLoading = false,
    this.outlined = false,
    this.dense = false,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: outlined ? Colors.white : Colors.blueAccent,
      borderRadius: BorderRadius.circular(360.r),
      child: InkWell(
        onTap: isLoading ? null : onTap,
        borderRadius: BorderRadius.circular(360.r),
        child: Container(
          width: width??double.maxFinite,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 20.sp),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(360.r),
            color: Colors.transparent,
            border: outlined
                ? Border.all(color: Colors.lightBlue, width: 2.sp)
                : null,
          ),
          child: isLoading
              ? SpinKitThreeBounce(
                  size: 15.sp,
                  color: outlined ? Colors.lightBlue : Colors.white,
                )
              : Text(
                  text ?? "Button",
                  style: TextStyle(
                    color: outlined ? Colors.lightBlue : Colors.white,
                    fontSize: dense ? 16.sp : 20.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
        ),
      ),
    );
  }
}
