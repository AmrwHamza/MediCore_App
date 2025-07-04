import 'package:flutter/material.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/features/profile/presentation/view/widgets/profile_image.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final String email;
  final String? profileImageUrl;

  const ProfileHeader({
    Key? key,
    required this.name,
    required this.email,
    this.profileImageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        children: [
          ProfileImage(profileImageUrl: profileImageUrl),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(name, style: TextStyles.H2.copyWith(color: Colors.white)),
              Container(
                margin: const EdgeInsets.only(left: 4),
                width: 12,
                height: 12,
                decoration: const BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),

          const SizedBox(height: 4),
          Text(email, style: TextStyles.public.copyWith(color: Colors.white)),
        ],
      ),
    );
  }
}
