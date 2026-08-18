import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';

class PdfViewerScreen extends StatefulWidget {
  final String pdfUrl;
  final String? title;

  const PdfViewerScreen({
    super.key,
    required this.pdfUrl,
    this.title,
  });

  @override
  State<PdfViewerScreen> createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  String? _localPdfPath;
  double _downloadProgress = 0.0;
  String? _errorMessage;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _downloadPdf();
  }

  Future<void> _downloadPdf() async {
    setState(() {
      _isLoading = true;
      _downloadProgress = 0.0;
      _errorMessage = null;
    });

    try {
      final tempDir = await getTemporaryDirectory();
      final fileName = widget.pdfUrl.split('/').last;
      final localPath = '${tempDir.path}/$fileName';

      final dio = Dio();

      await dio.download(
        widget.pdfUrl,
        localPath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            setState(() {
              _downloadProgress = received / total;
            });
          }
        },
      );

      if (mounted) {
        setState(() {
          _localPdfPath = localPath;
          _isLoading = false;
        });
      }
    } on DioException catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _errorMessage = e.message ?? 'Failed to download PDF';
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Unexpected error: $e';
        });
      }
    }
  }

  void _retry() {
    _downloadPdf();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final appBarTitle = widget.title ?? 'Document';

    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
        backgroundColor: isDark ? const Color(0xFF1E1E2C) : Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: isDark ? Colors.white : Colors.black87),
        titleTextStyle: TextStyle(
          color: isDark ? Colors.white : Colors.black87,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      backgroundColor: isDark ? const Color(0xFF1E1E2C) : Colors.white,
      body: _buildBody(isDark),
    );
  }

  Widget _buildBody(bool isDark) {
    if (_isLoading) {
      return _buildLoadingState(isDark);
    }

    if (_errorMessage != null) {
      return _buildErrorState(isDark);
    }

    if (_localPdfPath == null || !File(_localPdfPath!).existsSync()) {
      return _buildErrorState(isDark, customMessage: 'PDF file not found');
    }

    return _buildPdfView();
  }

  Widget _buildLoadingState(bool isDark) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 60,
            height: 60,
            child: CircularProgressIndicator(
              value: _downloadProgress > 0 ? _downloadProgress : null,
              strokeWidth: 4,
              backgroundColor: isDark
                  ? Colors.white.withValues(alpha: 0.1)
                  : Colors.grey[300],
              valueColor: const AlwaysStoppedAnimation(Color(0xFF32B2CF)),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            _downloadProgress > 0
                ? 'Downloading... ${(_downloadProgress * 100).toInt()}%'
                : 'Preparing download...',
            style: TextStyle(
              fontSize: 16,
              color: isDark ? Colors.white70 : Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(bool isDark, {String? customMessage}) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: 64,
              color: isDark ? Colors.red[300] : Colors.red[400],
            ),
            const SizedBox(height: 16),
            Text(
              'Unable to load PDF',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              customMessage ?? _errorMessage ?? 'unknown_error_occurred'.tr(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: isDark ? Colors.white54 : Colors.grey[600],
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _retry,
              icon: const Icon(Icons.refresh_rounded),
              label: Text('retry'.tr()),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF32B2CF),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPdfView() {
    return PDFView(
      filePath: _localPdfPath!,
      enableSwipe: true,
      swipeHorizontal: false,
      autoSpacing: true,
      pageFling: true,
      pageSnap: true,
      fitPolicy: FitPolicy.BOTH,
      backgroundColor: const Color(0xFF1E1E2C),
      onError: (error) {
        if (mounted) {
          setState(() {
            _errorMessage = 'Error rendering PDF: $error';
            _localPdfPath = null;
          });
        }
      },
      onRender: (pages) {
        // PDF rendered successfully
      },
      onViewCreated: (controller) {
        // PDFViewController available if needed
      },
    );
  }
}