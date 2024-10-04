import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  void Function()? onPressed;
  final String title;

  CustomButton({
    super.key,
    required this.onPressed,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: MediaQuery.sizeOf(context).width * .4,
        height: MediaQuery.sizeOf(context).width * .4,
        decoration: BoxDecoration(
          color: Color(0xffD9D9D9),
          boxShadow: [
            BoxShadow(
              blurRadius: 2,
              color: Color(0x56000000),
              offset: Offset(
                0,
                4,
              ),
            )
          ],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
            child: SizedBox(
                width: MediaQuery.sizeOf(context).width * .25,
                child: Center(
                    child: Text(
                  title,
                  textAlign: TextAlign.center,
                )))),
      ),
    );
  }
}
