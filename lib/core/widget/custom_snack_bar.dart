import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum SnackbarType { success, error, warning, info }

class CustomSnackbar {
  static void show(
    BuildContext context, {
    required String message,
    SnackbarType type = SnackbarType.info,
    Duration duration = const Duration(seconds: 4),
    double width = double.infinity,
    Alignment alignment = Alignment.topCenter,
  }) {
    final overlay = Overlay.of(context);

    final icon = _getIcon(type);
    final indicatorColor = _getIndicatorColor(type);

    late OverlayEntry entry;
    entry = OverlayEntry(
      builder:
          (_) => _SnackbarWidget(
            message: message,
            icon: icon,
            duration: duration,
            onClose: () => entry.remove(),
            alignment: alignment,
            width: width,
            indicatorColor: indicatorColor,
          ),
    );

    overlay.insert(entry);
  }

  static Color _getIndicatorColor(SnackbarType type) {
    switch (type) {
      case SnackbarType.success:
        return Colors.green;
      case SnackbarType.error:
        return Colors.redAccent;
      case SnackbarType.warning:
        return Colors.orange;
      case SnackbarType.info:
        return Colors.blue;
    }
  }

  static IconData _getIcon(SnackbarType type) {
    switch (type) {
      case SnackbarType.success:
        return FontAwesomeIcons.circleCheck;
      case SnackbarType.error:
        return FontAwesomeIcons.circleXmark;
      case SnackbarType.warning:
        return FontAwesomeIcons.triangleExclamation;
      case SnackbarType.info:
        return FontAwesomeIcons.circleInfo;
    }
  }
}

class _SnackbarWidget extends StatefulWidget {
  final String message;
  final IconData icon;
  final Duration duration;
  final VoidCallback onClose;
  final Alignment alignment;
  final double width;
  final Color indicatorColor;

  const _SnackbarWidget({
    required this.message,
    required this.icon,
    required this.duration,
    required this.onClose,
    required this.alignment,
    required this.width,
    required this.indicatorColor,
  });

  @override
  State<_SnackbarWidget> createState() => _SnackbarWidgetState();
}

class _SnackbarWidgetState extends State<_SnackbarWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slide;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _slide = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();
    Future.delayed(widget.duration, _dismiss);
  }

  void _dismiss() {
    if (mounted) {
      _controller.reverse().then((_) => widget.onClose());
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final cardColor =
        isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF4F4F4);
    final textColor = theme.canvasColor;

    return Positioned(
      top: MediaQuery.of(context).viewPadding.top + 20,
      left: 0,
      right: 0,
      child: Align(
        alignment: widget.alignment,
        child: Material(
          color: Colors.transparent,
          child: SlideTransition(
            position: _slide,
            child: FadeTransition(
              opacity: _fade,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  width:
                      widget.width == double.infinity
                          ? MediaQuery.of(context).size.width - 32
                          : widget.width,
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: widget.indicatorColor.withAlpha(
                          (0.3 * 255).round(),
                        ),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Indicator side strip
                      Container(
                        width: 5,
                        height: 64,
                        decoration: BoxDecoration(
                          color: widget.indicatorColor,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            bottomLeft: Radius.circular(12),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Icon(
                          widget.icon,
                          color: widget.indicatorColor,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          widget.message,
                          style: TextStyle(
                            color: textColor,
                            fontSize: 15.5,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.close,
                          color: textColor.withAlpha((0.7 * 255).round()),
                          size: 20,
                        ),
                        onPressed: _dismiss,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
