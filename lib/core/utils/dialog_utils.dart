import 'package:flutter/material.dart';
import 'app_res_code.dart';

class DialogUtils {
  static void showErrorDialog(
    BuildContext context, {
    required String title,
    required String message,
    VoidCallback? onOk,
  }) {
    print(
      'DialogUtils: showErrorDialog called - Title: $title, Message: $message',
    );
    print('DialogUtils: Context mounted: ${context.mounted}');

    if (!context.mounted) {
      print('DialogUtils: Context not mounted, cannot show dialog');
      return;
    }

    try {
      showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext dialogContext) {
              print('DialogUtils: Building error dialog');
              return AlertDialog(
                title: Row(
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 24,
                    ),
                    const SizedBox(width: 8),
                    Expanded(child: Text(title)),
                  ],
                ),
                content: Text(message),
                actions: [
                  TextButton(
                    onPressed: () {
                      print('DialogUtils: Error dialog OK button pressed');
                      Navigator.of(dialogContext).pop();
                      onOk?.call();
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          )
          .then((_) {
            print('DialogUtils: Dialog closed successfully');
          })
          .catchError((error) {
            print('DialogUtils: Error showing dialog: $error');
          });
    } catch (e) {
      print('DialogUtils: Exception in showErrorDialog: $e');
      rethrow;
    }
  }

  static void showResponseCodeDialog(
    BuildContext context, {
    required String resCode,
    VoidCallback? onOk,
  }) {
    debugPrint(
      '====DialogUtils: showResponseCodeDialog called with resCode: $resCode=====',
    );
    debugPrint('DialogUtils: Context mounted: ${context.mounted}');

    if (!context.mounted) {
      debugPrint(
        'DialogUtils: Context not mounted, cannot show response code dialog',
      );
      return;
    }

    final title = AppResCode.resCode(resCode);
    final message = AppResCode.getErrorMessage(resCode);

    // final title = "Warning";
    // final message = AppResCode.resCode(resCode);

    debugPrint('DialogUtils: Title: $title, Message: $message');

    // ถ้า match ไม่ได้ → ใช้ข้อความ resCode เป็น message แทน
    if (title == 'Unknown Warning' &&
        message == 'Unknown error occurred. Please try again.') {
      showErrorDialog(
        context,
        title: 'Warning',
        message: resCode, // ใช้ resCode เป็นข้อความโดยตรง
        onOk: onOk,
      );
    } else {
      showErrorDialog(context, title: "Warning", message: title, onOk: onOk);
    }
  }

  static void showLoadingDialog(BuildContext context, {String? message}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            children: [
              const CircularProgressIndicator(),
              const SizedBox(width: 16),
              Text(message ?? 'Loading...'),
            ],
          ),
        );
      },
    );
  }

  static void hideLoadingDialog(BuildContext context) {
    Navigator.of(context).pop();
  }

  static void showSuccessDialog(
    BuildContext context, {
    required String title,
    required String message,
    VoidCallback? onOk,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              const Icon(
                Icons.check_circle_outline,
                color: Colors.green,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(title),
            ],
          ),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                onOk?.call();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  static void showConfirmationDialog(
    BuildContext context, {
    required String title,
    required String message,
    required VoidCallback onConfirm,
    VoidCallback? onCancel,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                onCancel?.call();
              },
              child: Text(cancelText),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                onConfirm();
              },
              child: Text(confirmText),
            ),
          ],
        );
      },
    );
  }
}
