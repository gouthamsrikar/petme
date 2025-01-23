import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EIconButton extends StatelessWidget {
  const EIconButton({super.key, this.onPressed, required this.icon});

  final VoidCallback? onPressed;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      radius: 8.sp,
      onTap: onPressed,
      child: Container(
        width: 32.h,
        height: 32.h,
        decoration: ShapeDecoration(
          color: Theme.of(context).cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.sp),
          ),
          shadows: [
            BoxShadow(
              color: const Color.fromARGB(28, 158, 158, 158),
              blurRadius: 10,
              spreadRadius: 5,
            ),
          ],
        ),
        alignment: Alignment.center,
        child: icon,
      ),
    );
  }
}
