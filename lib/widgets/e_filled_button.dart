import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:petme/constants/color_const.dart';

// ignore: must_be_immutable
class EFilledButton extends StatelessWidget {
  EFilledButton({
    required this.child,
    this.isLoading = false,
    this.isShimmerRequired = false,
    this.enabledButtonTextColor,
    this.loaderWidget,
    this.enabledColor,
    this.disabledColor,
    this.onPressed,
    this.isExpaned = true,
  }) : height = 56;

  EFilledButton.text(
      {this.loaderWidget,
      // required this.onPressed,
      required String title,
      this.isLoading = false,
      this.enabledButtonTextColor,
      this.isShimmerRequired = true,
      this.enabledColor,
      this.disabledColor,
      this.isExpaned = true,
      this.onPressed})
      : child = Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.sp,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            height: 1.20,
            letterSpacing: 0.13,
          ),
          textAlign: TextAlign.center,
        ),
        height = 56;

  EFilledButton.smallText({
    this.loaderWidget,
    // required this.onPressed,
    required String title,
    this.isLoading = false,
    this.enabledButtonTextColor,
    this.isShimmerRequired = true,
    this.enabledColor,
    this.disabledColor,
    this.isExpaned = true,
    this.onPressed,
    Color? textColor,
  })  : child = Text(
          title,
          style: TextStyle(
            color: textColor ?? Colors.white,
            fontSize: 14.sp,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            height: 1.20,
            letterSpacing: 0.13,
          ),
          textAlign: TextAlign.center,
        ),
        height = 26;

  final Widget? child;

  final bool isLoading;

  final bool isShimmerRequired;

  final Color? enabledButtonTextColor;

  final Widget? loaderWidget;

  final Color? enabledColor;

  final Color? disabledColor;

  final VoidCallback? onPressed;

  final double? height;

  final bool isExpaned;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: isExpaned ? double.infinity : null,
      onPressed: !isLoading ? onPressed : null,
      color: enabledColor ?? ColorConst.primaryColor,
      disabledColor: isLoading ? ColorConst.primaryColor : Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.sp),
      ),
      elevation: 0,
      focusElevation: 0,
      hoverElevation: 0,
      disabledElevation: 0,
      highlightElevation: 0,
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onHighlightChanged: (value) => false,
      height: height,
      padding: EdgeInsets.zero,
      child: isExpaned
          ? SizedBox(
              height: height,
              width: isLoading ? height : null,
              child: isLoading
                  ? loaderWidget ??
                      Center(
                        child: SpinKitThreeBounce(
                          color: Colors.white,
                          size: 30,
                        ),
                      )
                  : Center(
                      child: child,
                    ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: child,
            ),
    );
  }
}
