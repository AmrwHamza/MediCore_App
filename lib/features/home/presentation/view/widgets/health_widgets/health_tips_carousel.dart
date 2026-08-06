import 'dart:async';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';

class HealthTipsCarousel extends StatefulWidget {
  const HealthTipsCarousel({super.key});

  @override
  State<HealthTipsCarousel> createState() => _HealthTipsCarouselState();
}

class _HealthTipsCarouselState extends State<HealthTipsCarousel> {
  final PageController _controller = PageController(viewportFraction: 0.94);
  Timer? _timer;
  int _current = 0;

  static const List<_TipData> _tips = [
    _TipData(
      icon: Icons.local_drink_rounded,
      keyPrefix: 'tip_drink_water',
      color: KInfo,
      colorLight: KInfoLight,
    ),
    _TipData(
      icon: Icons.self_improvement_rounded,
      keyPrefix: 'tip_sleep',
      color: KPurple,
      colorLight: KPurpleLight,
    ),
    _TipData(
      icon: Icons.directions_walk_rounded,
      keyPrefix: 'tip_walk',
      color: KSuccess,
      colorLight: KSuccessLight,
    ),
    _TipData(
      icon: Icons.restaurant_rounded,
      keyPrefix: 'tip_balanced',
      color: KOrange,
      colorLight: KOrangeLight,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 5), (_) {
      if (!mounted || !_controller.hasClients) return;
      final next = (_current + 1) % _tips.length;
      _controller.animateToPage(
        next,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>().themeData;
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      children: [
        SizedBox(
          height: 122,
          child: PageView.builder(
            controller: _controller,
            itemCount: _tips.length,
            physics: const BouncingScrollPhysics(),
            onPageChanged: (index) => setState(() => _current = index),
            itemBuilder: (context, index) {
              final tip = _tips[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        tip.color.withValues(alpha: isDark ? 0.35 : 0.28),
                        KPrimaryColor.withValues(alpha: isDark ? 0.18 : 0.1),
                      ],
                    ),
                    border: Border.all(
                      color: tip.color.withValues(
                        alpha: isDark ? 0.35 : 0.2,
                      ),
                      width: 1.2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: tip.color.withValues(alpha: isDark ? 0.15 : 0.12),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [tip.color, tip.color.withValues(alpha: 0.7)],
                            ),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: tip.color.withValues(alpha: 0.35),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Icon(tip.icon, color: Colors.white, size: 24),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${tip.keyPrefix}_title'.tr(),
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: isDark ? Colors.white : KDarkBlue,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${tip.keyPrefix}_body'.tr(),
                                style: TextStyle(
                                  fontSize: 12,
                                  height: 1.35,
                                  color: isDark
                                      ? Colors.white.withValues(alpha: 0.7)
                                      : Colors.grey[600],
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        DotsIndicator(
          dotsCount: _tips.length,
          position: _current.toDouble(),
          decorator: DotsDecorator(
            activeColor: KPrimaryColor,
            color: KPrimaryColor.withValues(alpha: 0.22),
            size: const Size.square(7),
            activeSize: const Size(22.0, 7.0),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            spacing: const EdgeInsets.symmetric(horizontal: 3),
          ),
        ),
      ],
    );
  }
}

class _TipData {
  final IconData icon;
  final String keyPrefix;
  final Color color;
  final Color colorLight;

  const _TipData({
    required this.icon,
    required this.keyPrefix,
    required this.color,
    required this.colorLight,
  });
}