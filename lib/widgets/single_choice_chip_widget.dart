import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petme/constants/color_const.dart';

class SingleChoice {
  final String option;
  final Widget? icon;
  const SingleChoice({required this.option, this.icon});
}

class SingleChoiceChipWidget extends StatefulWidget {
  final List<SingleChoice> options;
  final Function(String) onSelectionChanged;
  final String? initialValue;

  const SingleChoiceChipWidget({
    Key? key,
    required this.options,
    required this.onSelectionChanged,
    this.initialValue,
  }) : super(key: key);

  @override
  _SingleChoiceChipWidgetState createState() => _SingleChoiceChipWidgetState();
}

class _SingleChoiceChipWidgetState extends State<SingleChoiceChipWidget> {
  String? _selectedOption;

  @override
  void initState() {
    _selectedOption = widget.initialValue;
    super.initState();
  }

  void _onChipTapped(String option) {
    setState(() {
      _selectedOption = option;
      widget.onSelectionChanged(option);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Wrap(
        spacing: 14.w,
        runSpacing: 14.w,
        children: widget.options.map((option) {
          final isSelected = _selectedOption == option.option;
          return GestureDetector(
            onTap: () {
              _onChipTapped(option.option);
            },
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.w),
                decoration: BoxDecoration(
                  color: isSelected
                      ? ColorConst.primaryColor
                      : Color.fromARGB(41, 107, 107, 107),
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(26, 64, 71, 83),
                      blurRadius: 18.82,
                      offset: Offset(0, 3.76),
                      spreadRadius: 10,
                    )
                  ],
                ),
                child: SizedBox(
                  height: 22.h,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (option.icon != null) ...[widget],
                      Text(
                        option.option,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Color(0xFF5E5B5B),
                          fontSize: 12.w,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                )),
          );
        }).toList(),
      ),
    );
  }
}
