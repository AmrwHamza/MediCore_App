import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/helper/shared_pref.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';

class BmiCard extends StatefulWidget {
  const BmiCard({super.key});

  @override
  State<BmiCard> createState() => _BmiCardState();
}

class _BmiCardState extends State<BmiCard> with SingleTickerProviderStateMixin {
  double _height = 170;
  double _weight = 70;
  double? _bmi;
  _BmiCategory? _category;
  bool _showResult = false;
  late AnimationController _animController;
  late Animation<double> _fadeAnim;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnim = CurvedAnimation(parent: _animController, curve: Curves.easeOut);
    _scaleAnim = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animController, curve: Curves.elasticOut),
    );
    _loadSaved();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  Future<void> _loadSaved() async {
    final height = await SharedPrefHelper.getData(SharedPrefKeys.bmiHeight);
    final weight = await SharedPrefHelper.getData(SharedPrefKeys.bmiWeight);
    if (!mounted) return;
    setState(() {
      if (height is double) _height = height;
      if (weight is double) _weight = weight;
    });
  }

  Future<void> _saveHeight(double value) async {
    await SharedPrefHelper.setData(SharedPrefKeys.bmiHeight, value);
  }

  Future<void> _saveWeight(double value) async {
    await SharedPrefHelper.setData(SharedPrefKeys.bmiWeight, value);
  }

  void _calculate() {
    final bmi = _weight / ((_height / 100) * (_height / 100));
    final category = _categorize(bmi);
    setState(() {
      _bmi = bmi;
      _category = category;
      _showResult = true;
    });
    _animController.forward(from: 0);
  }

  _BmiCategory _categorize(double bmi) {
    if (bmi < 18.5) {
      return const _BmiCategory(
        labelKey: 'bmi_underweight',
        tipKey: 'bmi_tip_underweight',
        color: KInfo,
      );
    }
    if (bmi < 25) {
      return const _BmiCategory(
        labelKey: 'bmi_normal',
        tipKey: 'bmi_tip_normal',
        color: KSuccess,
      );
    }
    if (bmi < 30) {
      return const _BmiCategory(
        labelKey: 'bmi_overweight',
        tipKey: 'bmi_tip_overweight',
        color: KWarning,
      );
    }
    return const _BmiCategory(
      labelKey: 'bmi_obese',
      tipKey: 'bmi_tip_obese',
      color: KError,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>().themeData;
    final isDark = theme.brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : KBlack;
    final mutedColor =
        isDark ? Colors.white.withValues(alpha: 0.6) : Colors.grey[600];
    final surfaceColor = isDark ? KCardDark : Colors.white;

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
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: KPrimaryColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.monitor_weight_outlined,
                  color: KPrimaryColor,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'bmi_title'.tr(),
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildSliders(isDark, textColor, mutedColor!),
          const SizedBox(height: 18),
          _buildCalculateButton(),
          const SizedBox(height: 22),
          if (_showResult && _bmi != null && _category != null)
            _buildResultSection(isDark, textColor, mutedColor),
        ],
      ),
    );
  }

  Widget _buildSliders(bool isDark, Color textColor, Color mutedColor) {
    return Column(
      children: [
        _SliderRow(
          icon: Icons.height_rounded,
          labelKey: 'bmi_height',
          value: _height,
          min: 120,
          max: 220,
          divisions: 100,
          suffix: 'cm',
          onChanged: (value) {
            setState(() => _height = value);
            _saveHeight(value);
          },
        ),
        const SizedBox(height: 14),
        _SliderRow(
          icon: Icons.fitness_center_rounded,
          labelKey: 'bmi_weight',
          value: _weight,
          min: 30,
          max: 200,
          divisions: 170,
          suffix: 'kg',
          onChanged: (value) {
            setState(() => _weight = value);
            _saveWeight(value);
          },
        ),
      ],
    );
  }

  Widget _buildCalculateButton() {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: _calculate,
        style: ElevatedButton.styleFrom(
          backgroundColor: KPrimaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          elevation: 0,
        ),
        child: Text(
          'calculate'.tr(),
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3,
          ),
        ),
      ),
    );
  }

  Widget _buildResultSection(bool isDark, Color textColor, Color mutedColor) {
    return FadeTransition(
      opacity: _fadeAnim,
      child: ScaleTransition(
        scale: _scaleAnim,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _category!.color.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _category!.color.withValues(alpha: 0.2)),
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    _bmi!.toStringAsFixed(1),
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: _category!.color,
                      height: 1,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _category!.labelKey.tr(),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: _category!.color,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: LinearProgressIndicator(
                  value: (_bmi! / 40).clamp(0.0, 1.0),
                  minHeight: 8,
                  backgroundColor: _category!.color.withValues(alpha: 0.12),
                  valueColor: AlwaysStoppedAnimation(_category!.color),
                ),
              ),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _category!.color.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.lightbulb_outline_rounded,
                      color: KPrimaryColor,
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _category!.tipKey.tr(),
                        style: TextStyle(
                          fontSize: 11,
                          height: 1.4,
                          color: textColor.withValues(alpha: 0.85),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SliderRow extends StatelessWidget {
  final IconData icon;
  final String labelKey;
  final double value;
  final double min;
  final double max;
  final int divisions;
  final String suffix;
  final ValueChanged<double> onChanged;

  const _SliderRow({
    required this.icon,
    required this.labelKey,
    required this.value,
    required this.min,
    required this.max,
    required this.divisions,
    required this.suffix,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>().themeData;
    final isDark = theme.brightness == Brightness.dark;
    final mutedColor =
        isDark ? Colors.white.withValues(alpha: 0.6) : Colors.grey[600];

    return Row(
      children: [
        Icon(icon, color: KPrimaryColor, size: 20),
        const SizedBox(width: 10),
        SizedBox(
          width: 96,
          child: Text(
            labelKey.tr(),
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: mutedColor,
            ),
          ),
        ),
        Expanded(
          child: Slider(
            value: value,
            min: min,
            max: max,
            divisions: divisions,
            activeColor: KPrimaryColor,
            inactiveColor: KPrimaryColor.withValues(alpha: 0.15),
            onChanged: onChanged,
          ),
        ),
        SizedBox(
          width: 52,
          child: Text(
            '${value.toInt()} $suffix',
            textAlign: TextAlign.end,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : KDarkBlue,
            ),
          ),
        ),
      ],
    );
  }
}

class _BmiCategory {
  final String labelKey;
  final String tipKey;
  final Color color;

  const _BmiCategory({
    required this.labelKey,
    required this.tipKey,
    required this.color,
  });
}
