import 'package:flutter/material.dart';
import 'package:image_compressor/themes/constants/theme_constants.dart';

class StartCompressionButton extends StatelessWidget {
  final double height;
  final double width;
  final VoidCallback onPressed;
  const StartCompressionButton({
    super.key,
    required this.height,
    required this.width,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height / 17,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          splashFactory: InkRipple.splashFactory,
          overlayColor: ThemeConstants.accentColor,
          backgroundColor: Colors.transparent,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          side: BorderSide(
            color: ThemeConstants.primaryColor.withOpacity(0.8),
            width: 1,
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Start Compression",
              style: TextStyle(
                color: ThemeConstants.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: width / 20,
              ),
            ),
            const SizedBox(width: 10),
            const Icon(
              Icons.arrow_forward_ios,
              color: ThemeConstants.primaryColor,
            )
          ],
        ),
      ),
    );
  }
}
