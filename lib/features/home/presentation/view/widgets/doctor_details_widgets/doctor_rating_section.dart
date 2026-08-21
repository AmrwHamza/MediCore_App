import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/core/widget/custom_button.dart';
import 'package:medicore_app/core/widget/custom_snack_bar.dart';
import 'package:medicore_app/features/home/presentation/view_model/doctor_rate_cubit/doctor_rate_cubit.dart';
import 'package:medicore_app/features/home/presentation/view_model/doctor_rate_cubit/doctor_rate_state.dart';

class DoctorRatingSection extends StatelessWidget {
  final int doctorId;
  final bool? canRateOverride;
  final bool forceReadOnly;

  const DoctorRatingSection({
    super.key,
    required this.doctorId,
    this.canRateOverride,
    this.forceReadOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.select(
      (ThemeProvider provider) => provider.themeData,
    );
    final isDark = theme.brightness == Brightness.dark;

    return BlocProvider(
      create: (context) => DoctorRateCubit()..load(
        doctorId: doctorId,
        canRateOverride: forceReadOnly ? false : (canRateOverride ?? false),
      ),
      child: BlocBuilder<DoctorRateCubit, DoctorRateState>(
        builder: (context, state) {
          if (state is DoctorRateLoading) {

            return const SizedBox.shrink();
          } else if (state is DoctorRateLoaded) {
            final effectiveCanRate =
                forceReadOnly ? false : (canRateOverride ?? state.canRate);
            final feedback = state.successMessage ?? state.error;
            final isError = state.error != null;
            if (feedback != null) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (context.mounted) {
                  CustomSnackbar.show(
                    context,
                    message: feedback,
                    type: isError
                        ? SnackbarType.error
                        : SnackbarType.success,
                  );
                  context.read<DoctorRateCubit>().clearFeedback();
                }
              });
            }
            return _RatingContent(
              doctorId: doctorId,
              state: state,
              isDark: isDark,
              canRate: effectiveCanRate,
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _RatingContent extends StatefulWidget {
  final int doctorId;
  final DoctorRateLoaded state;
  final bool isDark;
  final bool canRate;

  const _RatingContent({
    required this.doctorId,
    required this.state,
    required this.isDark,
    required this.canRate,
  });

  @override
  State<_RatingContent> createState() => _RatingContentState();
}

class _RatingContentState extends State<_RatingContent> {
  double _selected = 0;

  @override
  void initState() {
    super.initState();
    _selected = widget.state.userRate ?? 0;
  }

  Color get _textColor => widget.isDark ? Colors.white : KBlack;
  Color get _mutedColor =>
      widget.isDark ? Colors.white.withValues(alpha: 0.6) : KGrey;

  @override
  Widget build(BuildContext context) {
    final state = widget.state;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'rating'.tr(),
          style: TextStyles.H2.copyWith(
            color: _textColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        _AverageRatingRow(
          averageRate: state.averageRate,
          isDark: widget.isDark,
        ),
        const SizedBox(height: 16),
        if (widget.canRate) ...[
          if (state.hasRated)
            Row(
              children: [
                Text(
                  'your_rating'.tr(),
                  style: TextStyles.notes.copyWith(
                    color: _mutedColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: state.isSubmitting
                      ? null
                      : () => context
                            .read<DoctorRateCubit>()
                            .deleteRate(doctorId: widget.doctorId),
                  icon: const Icon(
                    Icons.delete_outline_rounded,
                    color: KError,
                    size: 20,
                  ),
                  tooltip: 'delete_rating'.tr(),
                ),
              ],
            ),
          RatingBar(
            initialRating: _selected,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: false,
            itemCount: 5,
            itemSize: 32,
            itemPadding: const EdgeInsets.symmetric(horizontal: 2),
            ratingWidget: RatingWidget(
              full: const Icon(Icons.star_rounded, color: Colors.amber),
              half: const Icon(Icons.star_half_rounded, color: Colors.amber),
              empty: Icon(
                Icons.star_outline_rounded,
                color: widget.isDark
                    ? Colors.white.withValues(alpha: 0.3)
                    : KGrey.withValues(alpha: 0.5),
              ),
            ),
            onRatingUpdate: (value) => setState(() => _selected = value),
          ),
          const SizedBox(height: 12),
          CustomButton(
            title: state.hasRated
                ? 'update_rating'.tr()
                : 'submit_rating'.tr(),
            color: KPrimaryColor,
            onTap: state.isSubmitting || _selected == 0
                ? null
                : () => context
                      .read<DoctorRateCubit>()
                      .rate(
                        doctorId: widget.doctorId,
                        stars: _selected.round(),
                      ),
          ),
        ] else ...[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: KPrimaryExtraLight.withValues(
                alpha: widget.isDark ? 0.12 : 0.6,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.info_outline_rounded,
                  color: KPrimaryColor,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'rating_after_diagnosis'.tr(),
                    style: TextStyles.notes.copyWith(
                      color: widget.isDark
                          ? Colors.white.withValues(alpha: 0.7)
                          : KDarkBlue,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

class _AverageRatingRow extends StatelessWidget {
  final double? averageRate;
  final bool isDark;

  const _AverageRatingRow({required this.averageRate, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final rate = averageRate ?? 0;
    return Row(
      children: [
        RatingBarIndicator(
          rating: rate,
          itemBuilder:
              (context, _) => const Icon(
                Icons.star_rounded,
                color: Colors.amber,
              ),
          itemCount: 5,
          itemSize: 22,
          direction: Axis.horizontal,
        ),
        const SizedBox(width: 10),
        Text(
          rate == 0 ? '--' : rate.toStringAsFixed(1),
          style: TextStyles.H2.copyWith(
            color: isDark ? Colors.white : KBlack,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          'average_rating'.tr(),
          style: TextStyles.notes.copyWith(
            color: isDark ? Colors.white.withValues(alpha: 0.6) : KGrey,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
