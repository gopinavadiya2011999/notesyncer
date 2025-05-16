import 'package:flutter/material.dart';

import '../../infrastructure/constant/color_constant.dart';

class CommonButton extends StatelessWidget {
  const CommonButton({
    super.key,
    required this.buttonText,
    this.onTap,

    this.isLoading = false,
    this.isFilled = false,
  });

  final String buttonText;
  final bool isFilled;
  final bool isLoading;
  final GestureTapCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      radius: 0,
      child: Container(
        padding:
            isLoading
                ? EdgeInsets.symmetric(horizontal: 15)
                : EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color:
              isFilled ? ColorConstant.black.withAlpha(80) : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color:
                isFilled
                    ? Colors.transparent
                    : ColorConstant.black.withAlpha(50),
          ),
        ),
        child:
            isLoading
                ? SizedBox(
                  height: 32,
                  child: Transform.scale(
                    scale: 0.4,
                    child: CircularProgressIndicator(
                      color: ColorConstant.white,
                    ),
                  ),
                )
                : Text(
                  buttonText,
                  style: TextStyle(
                    color: isFilled ? ColorConstant.white : ColorConstant.black,
                  ),
                ),
      ),
    );
  }
}
