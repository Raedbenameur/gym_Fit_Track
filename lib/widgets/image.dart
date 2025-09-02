import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gym/core/colors.dart';
import 'package:gym/core/fonts.dart';
import 'package:gym/core/utils/image_picker_helper.dart';

class BuildImage extends StatefulWidget {
  final Function(File?)? onImageSelected;

  const BuildImage({super.key, this.onImageSelected});

  @override
  State<BuildImage> createState() => _BuildImageState();
}

class _BuildImageState extends State<BuildImage> {
  File? _selectedImage;

  Future<void> _pickImage() async {
    final file = await ImagePickerHelper.showImageSourceBottomSheet(context);
    if (file != null) {
      setState(() {
        _selectedImage = file;
      });
      // Notify parent widget about the selected image
      if (widget.onImageSelected != null) {
        widget.onImageSelected!(file);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Program Image',
          style: Fonts.text.copyWith(
            color: AppColors.primaryColor,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Add a cover image for your program (optional):',
          style: Fonts.text.copyWith(color: Colors.grey[400], fontSize: 14),
        ),
        const SizedBox(height: 12),

        GestureDetector(
          onTap: _pickImage,
          child: Container(
            width: double.infinity,
            height: 160,
            decoration: BoxDecoration(
              color: const Color(0xFF2A2A2A),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: _selectedImage != null
                    ? AppColors.primaryColor
                    : Colors.grey[700]!,
                width: 1,
              ),
            ),
            child: _selectedImage != null
                ? Stack(
                    children: [
                      // Selected Image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(11),
                        child: Image.file(
                          _selectedImage!,
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),

                      // Overlay with edit and remove buttons
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(11),
                          gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.center,
                            colors: [
                              Colors.black.withOpacity(0.8),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),

                      // Action buttons
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Row(
                          children: [
                            // Edit button
                            GestureDetector(
                              onTap: _pickImage,
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(
                                  Icons.edit,
                                  color: AppColors.primaryColor,
                                  size: 18,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            // Remove button
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedImage = null;
                                });
                                // Notify parent widget about image removal
                                if (widget.onImageSelected != null) {
                                  widget.onImageSelected!(null);
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                  size: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_photo_alternate,
                        color: Colors.grey[400],
                        size: 40,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Tap to add image',
                        style: Fonts.text.copyWith(
                          color: Colors.grey[400],
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Camera or Gallery',
                        style: Fonts.text.copyWith(
                          color: Colors.grey[500],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ],
    );
  }
}
