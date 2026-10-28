import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gym/services/permission.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ImagePickerHelper {
  static final ImagePicker _picker = ImagePicker();

  /// Pick image from gallery
  static Future<File?> pickImageFromGallery(BuildContext context) async {
    try {
      // Check current permission status first
      final currentStatus = await Permission.photos.status;

      bool hasPermission = false;

      if (currentStatus == PermissionStatus.granted) {
        hasPermission = true;
      } else if (currentStatus == PermissionStatus.denied) {
        // Show dialog and request permission
        if (context.mounted) {
          hasPermission = await PermissionService.showPhotoPermissionDialog(
            context,
          );
        }
      } else if (currentStatus == PermissionStatus.permanentlyDenied) {
        // Show dialog to go to settings
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Please enable photo access in Settings'),
              backgroundColor: Colors.orange,
              action: SnackBarAction(
                label: 'Settings',
                onPressed: () => openAppSettings(),
              ),
            ),
          );
        }
        return null;
      }

      if (!hasPermission) {
        return null;
      }

      // Pick image from gallery
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (image != null) {
        return File(image.path);
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error selecting image: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
    return null;
  }

  /// Pick image from camera
  static Future<File?> pickImageFromCamera(BuildContext context) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (image != null) {
        return File(image.path);
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error taking photo: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
    return null;
  }

  /// Show bottom sheet to select image source
  static Future<File?> showImageSourceBottomSheet(BuildContext context) async {
    final result = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: const Color(0xFF1D1D1D),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[600],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),

            Text(
              'Add Program Image',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),

            Row(
              children: [
                // Gallery Option
                Expanded(
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context, 'gallery'),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2A2A2A),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.yellow.withValues(alpha: 0.3),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.photo_library,
                            color: Colors.yellow,
                            size: 32,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Gallery',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 16),

                // Camera Option
                Expanded(
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context, 'camera'),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2A2A2A),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey[700]!, width: 1),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.camera_alt,
                            color: Colors.grey[400],
                            size: 32,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Camera',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Cancel button
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.grey[400], fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );

    // Handle the selected option
    if (result == 'gallery') {
      final file = await pickImageFromGallery(context);
      if (file != null && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Image added successfully!'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
      }
      return file;
    } else if (result == 'camera') {
      final file = await pickImageFromCamera(context);
      if (file != null && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Photo captured successfully!'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
      }
      return file;
    }

    return null;
  }
}
