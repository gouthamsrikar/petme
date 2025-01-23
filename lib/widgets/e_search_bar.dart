import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petme/constants/color_const.dart';

typedef OnChangedInterceptor = String Function(String value);

// ignore: must_be_immutable
class ESearchBar extends StatelessWidget {
  ESearchBar({
    super.key,
    this.controller,
    this.description,
    this.hintText = "Search...",
    this.labelText,
    this.leading,
    this.keyboardType,
    this.initialValue,
    this.onChanged,
    this.maxLength,
    this.inputFormatters,
    this.onChangedInterceptor,
    this.errorText,
    this.onFieldSubmitted,
    this.onTap,
    this.enabled,
    this.suffix,
    this.borderColor,
  });

  final Widget? suffix;

  final TextEditingController? controller;
  final String? description;
  final String? hintText;
  final String? labelText;
  final Widget? leading;
  final bool? enabled;
  final TextInputType? keyboardType;
  final String? initialValue;
  final ValueChanged<String>? onChanged;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  late OnChangedInterceptor? onChangedInterceptor;
  final String? errorText;
  final ValueChanged<String>? onFieldSubmitted;
  final GestureTapCallback? onTap;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    const border = InputBorder.none;

    final _leading = leading != null
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                leading!,
              ],
            ),
          )
        : null;

    final _suffix = suffix != null
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                suffix!,
              ],
            ),
          )
        : null;

    final textField = TextFormField(
      selectionHeightStyle: BoxHeightStyle.tight,
      onFieldSubmitted: onFieldSubmitted,
      controller: controller,
      initialValue: initialValue,
      keyboardType: keyboardType,
      style: TextStyle(
        color: ColorConst.primaryColor,
        fontSize: 11.29,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w400,
        height: 1,
      ),

      enabled: enabled,
      onTap: onTap,
      maxLength: maxLength,
      onChanged: onChangedInterceptor == null
          ? onChanged
          : (value) {
              onChanged?.call(onChangedInterceptor!(value));
            },
      // cursorHeight: 15,
      cursorWidth: 1,
      textAlignVertical: TextAlignVertical.center,
      textAlign: TextAlign.start,
      enableSuggestions: true,
      cursorColor: Colors.black54,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        prefixIcon: _leading,
        suffixIcon: _suffix,

        focusedErrorBorder: border,
        errorBorder: border,
        disabledBorder: border,
        contentPadding: labelText != null
            ? const EdgeInsets.only(
                // top: 10,
                // bottom: 10,
                left: 16,
                right: 16,
                // horizontal: 16,
              )
            : const EdgeInsets.symmetric(
                vertical: 19,
                horizontal: 16,
              ),

        counterText: '',
        labelText: labelText,
        hintText: hintText,
        filled: false,
        fillColor: Color(0xFFD8D8D8).withOpacity(0.2),
        hoverColor: Colors.transparent,
        hintStyle: TextStyle(
          color: Color(0xFFCAC9C9),
          fontSize: 11.29,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
          height: 1,
        ),

        floatingLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: Colors.black,
          height: 22 / 12,
        ),
        // alignLabelWithHint: true,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        border: border,
        enabledBorder: border,
        focusedBorder: border,
      ),
    );

    final wrappedTextField = Container(
      height: 42.sp,
      padding: const EdgeInsets.symmetric(
          // horizontal: 20,
          ),
      alignment: Alignment.center,
      decoration: ShapeDecoration(
        // default text field color
        color: Color(0xFFD8D8D8).withOpacity(0.2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.sp),
          side: errorText != null
              ? BorderSide(
                  color: ColorConst.errorColor,
                  width: 1,
                  strokeAlign: 1,
                )
              : BorderSide.none,
        ),
      ),
      child: Row(
        children: [
          Expanded(child: textField),
          _searchIcon(),
        ],
      ),
    );

    return Material(
      color: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          wrappedTextField,
          SizedBox(
            height: 32,
            child: (description != null || errorText != null)
                ? Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        errorText ?? description!,
                        style: TextStyle(
                          color: errorText != null
                              ? Color(0xFFD8D8D8)
                              : ColorConst.errorColor,
                        ),
                      ),
                    ),
                  )
                : null,
          )
        ],
      ),
    );
  }

  InkWell _searchIcon() {
    return InkWell(
      onTap: () {},
      child: Container(
        height: 42.sp,
        width: 42.sp,
        decoration: ShapeDecoration(
          color: ColorConst.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.sp),
          ),
          shadows: [
            BoxShadow(
              color: Color(0x0C152C4E),
              blurRadius: 16.94,
              offset: Offset(0, 3.76),
              spreadRadius: 0,
            )
          ],
        ),
        alignment: Alignment.center,
        child: Icon(
          Icons.search,
          color: Colors.white,
        ),
      ),
    );
  }
}

class GapInputFormatter extends TextInputFormatter {
  const GapInputFormatter(this.gap);
  final int gap;
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % gap == 0 && nonZeroIndex != text.length) {
        buffer.write(
            ' '); // Replace this with anything you want to put after each 4 numbers
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: TextSelection.collapsed(offset: string.length));
  }
}
