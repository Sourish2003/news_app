import 'package:flutter/material.dart';

class ReusableBtn1 extends StatelessWidget {
  const ReusableBtn1(
      {super.key,
      required this.callBack,
      required this.btnTitle,
      this.textStyle,
      this.buttonStyle});

  final Function callBack;
  final String btnTitle;
  final TextStyle? textStyle;
  final ButtonStyle? buttonStyle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: buttonStyle,
        onPressed: () => callBack(),
        child: Text(
          btnTitle,
          style: textStyle ??
              Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
