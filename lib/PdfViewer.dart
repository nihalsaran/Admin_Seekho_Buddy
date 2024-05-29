import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

class PdfViewer extends StatelessWidget {
  final String keyValue; // Value to display in the app bar
  final String value; // URL to the PDF file

  PdfViewer({required this.keyValue, required this.value});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          // Add a back button
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          keyValue, // Display keyValue in the app bar
          style: TextStyle(color: Colors.white), // Set text color to white
        ), // Display keyValue in the app bar
      ),
      body: PDF().cachedFromUrl(
        value,
        placeholder: (progress) =>
            Center(child: CircularProgressIndicator(value: progress)),
        errorWidget: (error) =>
            Center(child: Text("Error loading PDF: $error")),
      ),
    );
  }
}
