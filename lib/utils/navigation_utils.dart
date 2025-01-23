import 'package:flutter/material.dart';


showEqBottomSheet(
  BuildContext context,
  Widget child, {
  ValueChanged<dynamic>? onThen,
}) {
  return showModalBottomSheet(
    context: context,
    builder: (context) => Wrap(
      children: [
        child,
      ],
    ),
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
  ).then((value) {
    onThen?.call(value);
  });
}

showEqDialog(
  BuildContext context,
  Widget child, {
  ValueChanged<dynamic>? onThen,
}) async {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        child,
      ],
    ),
    // backgroundColor: Colors.transparent,
    // isScrollControlled: true,
  ).then((value) {
    onThen?.call(value);
  });
}

pushView(BuildContext context, Widget child, {ValueChanged<dynamic>? onThen}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => child,
    ),
  ).then(
    (value) {
      onThen?.call(value);
    },
  );
}

pushReplacementView(BuildContext context, Widget child) {
  return Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => child,
    ),
  );
}

popView(BuildContext context) {
  return Navigator.pop(context);
  // return Navigator.pop(context);
}
