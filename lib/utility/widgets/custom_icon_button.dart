import 'package:flutter/material.dart';
import 'package:mm_properties/utility/common/app_colors.dart';

class CustomIconButton extends StatelessWidget {
  final String iconPath;
  final VoidCallback onPressed;
  final double size;
  final Color? iconColor;
  final Color? backgroundColor;
  final BoxBorder? border;

  const CustomIconButton({
    super.key,
    required this.iconPath,
    required this.onPressed,
    this.size = 24,
    this.iconColor,
    this.backgroundColor = AppColors.white,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: size + 20,
        height: size + 20,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
          border:
              border ??
              Border.all(color: AppColors.chineseWhite.withValues(alpha: 0.5)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.1),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Image.asset(
            iconPath,
            width: size,
            height: size,
            color: iconColor ?? AppColors.black,
          ),
        ),
      ),
    );
  }
}
