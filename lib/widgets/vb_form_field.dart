import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VBFormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? hint;
  final EdgeInsets? margin;
  final bool obscure;
  final Widget? suffixIcon;
  final TextInputType? inputType;
  final TextInputAction? inputAction;
  final bool enabled;
  final bool showError;
  final String errorMessage;
  final int minLines;
  final int maxLines;
  final void Function(String)? onChanged;
  const VBFormField({
    super.key,
    required this.controller,
    required this.label,
    this.hint,
    this.margin,
    this.obscure = false,
    this.suffixIcon,
    this.inputType,
    this.inputAction,
    this.minLines = 1,
    this.maxLines = 1,
    this.enabled = true,
    this.showError = false,
    this.onChanged,
    this.errorMessage = "Error: Invalid Input!",
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black45,
            ),
          ),
          SizedBox(
            height: 8.sp,
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(
                  20.r,
                ),
                border: Border.all(color: Colors.black)),
            child: TextFormField(
              enabled: enabled,
              keyboardType: inputType,
              textInputAction: inputAction,
              obscureText: obscure,
              controller: controller,
              style: TextStyle(fontSize: 17.sp),
              maxLines: maxLines,
              onChanged: onChanged == null
                  ? null
                  : (value) {
                      onChanged!(value.trim());
                    },
              minLines: minLines,
              decoration: InputDecoration(
                hintStyle: TextStyle(fontSize: 17.sp),
                hintText: hint ?? 'Enter here',
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(20.sp),
                suffixIcon: suffixIcon,
              ),
            ),
          ),
          if (showError)
            Text(
              errorMessage,
              style: TextStyle(
                color: Colors.red,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            )
        ],
      ),
    );
  }
}

class PasswordVisibility extends StatelessWidget {
  final bool obscure;
  final void Function()? onTap;
  const PasswordVisibility({super.key, required this.obscure, this.onTap});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: Icon(
        obscure ? Icons.visibility : Icons.visibility_off,
        color: Colors.blueGrey,
      ),
    );
  }
}
