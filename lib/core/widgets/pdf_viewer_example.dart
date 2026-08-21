import 'package:flutter/material.dart';
import 'package:medicore_app/core/widgets/pdf_viewer_screen.dart';

class PdfViewerExample extends StatelessWidget {
  const PdfViewerExample({super.key});

  static const String examplePdfUrl =
      'http://10.0.2.2:8000/storage/uploads/Medical_analysis/90/979125843360c8eb5ed13bbeadfccd2e.pdf';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PDF Viewer Example')),
      body: Center(
        child: ElevatedButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PdfViewerScreen(
                  pdfUrl: examplePdfUrl,
                  title: 'Medical Analysis',
                ),
              ),
            );
          },
          icon: const Icon(Icons.picture_as_pdf),
          label: const Text('Open PDF'),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF32B2CF),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
        ),
      ),
    );
  }
}