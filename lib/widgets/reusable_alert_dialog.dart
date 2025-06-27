import 'package:flutter/material.dart';
import 'package:news_app/widgets/reusable_snack_bar.dart';

import '../utils/api_helpers/api_status.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final String confirmText;
  final String cancelText;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final bool showCancelButton;
  final Color? confirmButtonColor;
  final Color? cancelButtonColor;
  final TextStyle? titleStyle;
  final TextStyle? contentStyle;
  final TextStyle? buttonTextStyle;

  const CustomAlertDialog({
    super.key,
    required this.title,
    required this.content,
    this.confirmText = 'Yes',
    this.cancelText = 'No',
    this.onConfirm,
    this.onCancel,
    this.showCancelButton = true,
    this.confirmButtonColor,
    this.cancelButtonColor,
    this.titleStyle,
    this.contentStyle,
    this.buttonTextStyle,
  });

  /// Shows a dialog and handles the confirm/reject actions
  static Future<void> showConfirmationDialog({
    required BuildContext context,
    required String title,
    required String content,
    required Future<void> Function() onConfirmed,
    String confirmText = 'Yes',
    String cancelText = 'No',
    VoidCallback? onCancelled,
    Color? confirmButtonColor,
    Color? cancelButtonColor,
    TextStyle? titleStyle,
    TextStyle? contentStyle,
    TextStyle? buttonTextStyle,
    Function(String)? onError,
  }) async {
    try {
      final confirmed = await showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => CustomAlertDialog(
          title: title,
          content: content,
          confirmText: confirmText,
          cancelText: cancelText,
          confirmButtonColor: confirmButtonColor,
          cancelButtonColor: cancelButtonColor,
          titleStyle: titleStyle,
          contentStyle: contentStyle,
          buttonTextStyle: buttonTextStyle,
        ),
      );

      if (confirmed == true) {
        await onConfirmed();
      } else {
        onCancelled?.call();
      }
    } catch(e) {
      Failure response = e as Failure;
      if (onError != null) {
        onError(response.response.toString());
      } else {
        // Default error handling
        if (context.mounted) {
          ReusableSnackBar.showErrSnackBar(context, 'Error: ${response.response}');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: titleStyle ?? Theme.of(context).textTheme.titleLarge,
      ),
      content: Text(
        content,
        style: contentStyle ?? Theme.of(context).textTheme.bodyLarge,
      ),
      actions: [
        if (showCancelButton)
          TextButton(
            onPressed: () {
              onCancel?.call();
              Navigator.of(context).pop(false);
            },
            style: TextButton.styleFrom(
              foregroundColor: cancelButtonColor,
            ),
            child: Text(
              cancelText,
              style: buttonTextStyle,
            ),
          ),
        TextButton(
          onPressed: () {
            onConfirm?.call();
            Navigator.of(context).pop(true);
          },
          style: TextButton.styleFrom(
            foregroundColor: confirmButtonColor,
          ),
          child: Text(
            confirmText,
            style: buttonTextStyle,
          ),
        ),
      ],
    );
  }
}
