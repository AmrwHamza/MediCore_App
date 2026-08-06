import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/helper/shared_pref.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';

class WaterTrackerCard extends StatefulWidget {
  const WaterTrackerCard({super.key});

  @override
  State<WaterTrackerCard> createState() => _WaterTrackerCardState();
}

class _WaterTrackerCardState extends State<WaterTrackerCard> {
  static const int _goalGlasses = 8;
  static const int _goalMl = 2000;
  static const int _glassMl = 250;

  int _glasses = 0;

  @override
  void initState() {
    super.initState();
    _load();
  }

  String _todayKey() {
    final now = DateTime.now();
    return '${now.year}-${now.month}-${now.day}';
  }

  Future<void> _load() async {
    final savedDate = await SharedPrefHelper.getData(
      SharedPrefKeys.waterTrackerDate,
    );
    final savedGlasses = await SharedPrefHelper.getData(
      SharedPrefKeys.waterTrackerGlasses,
    );
    if (!mounted) return;
    if (savedDate == _todayKey() && savedGlasses is int) {
      setState(() => _glasses = savedGlasses.clamp(0, _goalGlasses));
    } else {
      await _save(0);
    }
  }

  Future<void> _save(int glasses) async {
    await SharedPrefHelper.setData(
      SharedPrefKeys.waterTrackerDate,
      _todayKey(),
    );
    await SharedPrefHelper.setData(
      SharedPrefKeys.waterTrackerGlasses,
      glasses,
    );
    if (mounted) {
      setState(() => _glasses = glasses.clamp(0, _goalGlasses));
    }
  }

  void _addGlasses(int count) {
    _save(_glasses + count);
  }

  void _onGlassTap(int index) {
    if (index < _glasses) {
      _save(index);
    } else {
      _save(index + 1);
    }
  }

  String _insightText() {
    final progress = _glasses / _goalGlasses;
    if (progress == 0) return 'water_tip_start'.tr();
    if (progress < 0.25) return 'water_tip_quarter'.tr();
    if (progress < 0.5) return 'water_tip_half'.tr();
    if (progress < 0.75) return 'water_tip_three_quarter'.tr();
    return 'water_tip_complete'.tr();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>().themeData;
    final isDark = theme.brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : KBlack;
    final mutedColor = isDark
        ? Colors.white.withValues(alpha: 0.6)
        : Colors.grey[600] ?? Colors.grey;
    final surfaceColor = isDark ? KCardDark : Colors.white;
    final progress = _glasses / _goalGlasses;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isDark ? KBorderDark : Colors.grey.withValues(alpha: 0.1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.03),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(isDark, textColor),
          const SizedBox(height: 20),
          _buildCircularProgress(progress, isDark, textColor, mutedColor),
          const SizedBox(height: 20),
          _buildQuickActions(isDark),
          const SizedBox(height: 16),
          _buildGlassGrid(isDark),
          const SizedBox(height: 16),
          _buildInsightsBar(isDark),
        ],
      ),
    );
  }

  Widget _buildHeader(bool isDark, Color textColor) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xFF2E9BFA).withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.water_drop_outlined,
            color: Color(0xFF2E9BFA),
            size: 22,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            'water_title'.tr(),
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ),
        Text(
          '$_glasses/$_goalGlasses',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2E9BFA),
          ),
        ),
      ],
    );
  }

  Widget _buildCircularProgress(
    double progress,
    bool isDark,
    Color textColor,
    Color mutedColor,
  ) {
    return Center(
      child: SizedBox(
        width: 140,
        height: 140,
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
                width: 140,
                height: 140,
                child: CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 10,
                  backgroundColor: const Color(0xFF2E9BFA).withValues(alpha: 0.1),
                  valueColor: const AlwaysStoppedAnimation(Color(0xFF2E9BFA)),
                ),
              ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${(_glasses * _glassMl).toString()} ml',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'of $_goalMl ml',
                  style: TextStyle(
                    fontSize: 11,
                    color: mutedColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions(bool isDark) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _QuickActionButton(
          icon: Icons.local_bar_rounded,
          label: '+250',
          color: const Color(0xFF2E9BFA),
          onTap: () => _addGlasses(1),
        ),
        _QuickActionButton(
          icon: Icons.local_drink_rounded,
          label: '+500',
          color: const Color(0xFF1E88E5),
          onTap: () => _addGlasses(2),
        ),
        _QuickActionButton(
          icon: Icons.opacity_rounded,
          label: '+750',
          color: const Color(0xFF1565C0),
          onTap: () => _addGlasses(3),
        ),
      ],
    );
  }

  Widget _buildGlassGrid(bool isDark) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(_goalGlasses, (index) {
        final isFilled = index < _glasses;
        return GestureDetector(
          onTap: () => _onGlassTap(index),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 26,
            height: 40,
            decoration: BoxDecoration(
              color: isFilled
                  ? const Color(0xFF2E9BFA)
                  : const Color(0xFF2E9BFA).withValues(alpha: 0.1),
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(8),
                top: Radius.circular(4),
              ),
              border: Border.all(
                color: const Color(0xFF2E9BFA).withValues(
                  alpha: isFilled ? 1 : 0.3,
                ),
              ),
            ),
            child: isFilled
                ? const Icon(
                    Icons.water_drop_rounded,
                    color: Colors.white,
                    size: 12,
                  )
                : null,
          ),
        );
      }),
    );
  }

  Widget _buildInsightsBar(bool isDark) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: const Color(0xFF2E9BFA).withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF2E9BFA).withValues(alpha: 0.15),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.lightbulb_outline_rounded,
            color: const Color(0xFF2E9BFA),
            size: 16,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              _insightText(),
              style: TextStyle(
                fontSize: 11,
                height: 1.3,
                color: isDark
                    ? Colors.white.withValues(alpha: 0.7)
                    : Colors.grey[700],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}