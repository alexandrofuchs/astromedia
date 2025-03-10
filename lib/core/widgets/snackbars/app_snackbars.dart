import 'package:astromedia/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

abstract class AppSnackbars {
  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
      showErrorSnackbar(BuildContext context, String message,
              {Duration duration = const Duration(seconds: 2)}) =>
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            margin: const EdgeInsets.only(left: 8, right: 8, bottom: 30),
            backgroundColor: AppColors.orangeColor,
            duration: duration,
            shape:
                const BeveledRectangleBorder(borderRadius: BorderRadius.zero),
            behavior: SnackBarBehavior.floating,
            content: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
              child: Row(
                children: [
                  const Icon(
                    Icons.cancel_rounded,
                    color: AppColors.secundaryColor,
                    size: 24,
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        message,
                        softWrap: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ));

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
      showSuccessSnackbar(
    BuildContext context,
    String message,
  ) =>
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            margin: const EdgeInsets.only(left: 8, right: 8, bottom: 30),
            backgroundColor: AppColors.greenColor,
            shape:
                const BeveledRectangleBorder(borderRadius: BorderRadius.zero),
            behavior: SnackBarBehavior.floating,
            content: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
              child: Row(
                children: [
                  const Icon(
                    Icons.check_circle,
                    color: AppColors.secundaryColor,
                    size: 24,
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        message,
                        softWrap: true,
                        maxLines: 3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ));
}
