import 'package:flutter/material.dart';
import 'package:gym/core/colors.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:gym/core/fonts.dart';

class PermissionService {
  static Future<bool> requestPhotoPermissions() async {
    try {
      final status = await Permission.photos.request();
      return status == PermissionStatus.granted;
    } catch (e) {
      return false;
    }
  }

  // Keep this method for cases where you want to explain first
  static Future<bool> showPhotoPermissionDialog(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1D1D1D),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Icon(
                Icons.photo_library,
                color: AppColors.primaryColor,
                size: 24,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Photo Access Required',
                  style: Fonts.title.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'To add custom images to your workout programs, please allow access to your photo gallery.',
                style: Fonts.text.copyWith(
                  fontSize: 14,
                  color: Colors.grey[300],
                  height: 1.4,
                ),
              ),
            ],
          ),
          actions: [
            Column(
              children: [
                const SizedBox(height: 8),
                Row(
                  children: [
                    // Cancel Button
                    Expanded(
                      child: TextButton(
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          side: BorderSide(color: Colors.grey[600]!, width: 1),
                          backgroundColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () => Navigator.of(context).pop(false),
                        child: Text(
                          'Cancel',
                          style: Fonts.text.copyWith(
                            color: Colors.grey[300],
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Allow Button
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          backgroundColor: AppColors.primaryColor,
                          foregroundColor: Colors.black,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () => Navigator.of(context).pop(true),

                        child: Text(
                          'Allow Access',
                          style: Fonts.text.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
          actionsPadding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
          contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 8),
          titlePadding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
        );
      },
    );

    if (result == true) {
      return await requestPhotoPermissions();
    }

    return false;
  }
}
