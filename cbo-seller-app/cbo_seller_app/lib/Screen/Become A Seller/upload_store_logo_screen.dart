// ignore_for_file: empty_catches, library_private_types_in_public_api

import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import '../../Utils/Theme/constant_colors.dart';
import '../../Widget/Pdf File/single_page_pdf_file_widget.dart';
import '../../Widget/Zooming Image/zoomable_image_widget.dart';
import '../../Widget/page_navigation_animation_widget.dart';

class UploadStoreLogoScreen extends StatefulWidget {
  final String buttonTitle;
  final void Function(String?) onFileSelected;
  final String? filePath; // Added filePath parameter

  const UploadStoreLogoScreen({
    Key? key,
    required this.buttonTitle,
    required this.onFileSelected,
    this.filePath, // Initialized as optional parameter
  }) : super(key: key);

  @override
  _UploadStoreLogoScreenState createState() => _UploadStoreLogoScreenState();
}

class _UploadStoreLogoScreenState extends State<UploadStoreLogoScreen> {
  String? _filePath;

  @override
  void initState() {
    super.initState();
    _filePath = widget.filePath;
  }

  // Function to handle file selection
  void _selectFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false, // Allow only one file to be picked
        type: FileType.custom,
        allowedExtensions: ['jpg', 'pdf', 'doc'], // Add allowed file extensions
      );

      if (result != null) {
        setState(() {
          _filePath = result.files.first.path;
          widget.onFileSelected(_filePath);
        });
      } else {
        // User canceled the picker
      }
    } catch (e) {}
  }

  // Function to remove the uploaded file
  void _removeFile() {
    setState(() {
      _filePath = null;
      widget.onFileSelected(null); // Notify the parent widget
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;

    Widget buildFileWidget(String? filePath) {
      String? displayFilePath = _filePath ?? filePath;
      if (displayFilePath != null) {
        if (displayFilePath.toLowerCase().endsWith('.jpg') ||
            displayFilePath.toLowerCase().endsWith('.jpeg') ||
            displayFilePath.toLowerCase().endsWith('.png') ||
            displayFilePath.toLowerCase().endsWith('.gif')) {
          // Display local image file
          return   GestureDetector(
            onTap: () async {
              await Navigator.of(context).push(pageAnimationWidget(begin: const Offset(0.0, -1.0),  InteractiveViewerScreen(
                imageUrl: displayFilePath,
              )));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child:(displayFilePath.startsWith('http://') ||
                      displayFilePath.startsWith('https://')) ?
                  CachedNetworkImage(imageUrl: displayFilePath)
                      : Image.file(File(displayFilePath)),
                ),
                IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: _removeFile,
                ),
              ],
            ),
          );
        }
        else if (displayFilePath.toLowerCase().endsWith('.pdf')) {
          // Display PDF file
          return GestureDetector(
            onTap: () async {
              await Navigator.of(context).push(pageAnimationWidget(begin: const Offset(0.0, -1.0),  SinglePdfFileScreen(fileUrl: displayFilePath,
              )));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child:Container(
                    decoration: BoxDecoration(border: Border.all(color: ConstantColor.primaryBlackColor)),
                    child: AbsorbPointer(
                        absorbing: true,
                        child: PDFView(filePath: displayFilePath, autoSpacing: false, enableSwipe: false)),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: _removeFile,
                ),
              ],
            ),
          );
        } else {
          // Display other file types by showing their path or name
          return ListTile(
            title: Text(displayFilePath), // Display file path or name
            trailing: IconButton(
              icon: const Icon(Icons.clear),
              onPressed: _removeFile,
            ),
          );
        }
      } else {
        return Container(); // Return an empty container if no file is selected
      }
    }



    return Container(
      height: screenHeight / 14.0,
      margin: EdgeInsets.only(left: screenHeight / 200.0),
      decoration: BoxDecoration(
        border: Border.all(color: ConstantColor.primaryGreyColor, width: 0.5),
        color: ConstantColor.primaryBackgroundMainColor,
      ),
      child: _filePath != null && _filePath!.isNotEmpty
          ? buildFileWidget(_filePath)
          : Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: _selectFile,
          child: Text(widget.buttonTitle),
        ),
      ),
    );
  }
}