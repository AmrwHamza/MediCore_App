import 'package:flutter/material.dart';

class ProfileHeaderCard extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String email;

  const ProfileHeaderCard({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    final String firstLetter =
        firstName.isNotEmpty ? firstName[0].toUpperCase() : 'U';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(  
        gradient: LinearGradient(
          colors: [
            Colors.white.withValues(alpha: 0.15),
            Colors.white.withValues(alpha: 0.02),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            height: 90,
            width: 90,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [Colors.cyanAccent, Colors.blueAccent],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.cyanAccent.withValues(alpha: 0.4),
                  blurRadius: 15,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Center(
              child: Text(
                firstLetter,
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            '$firstName $lastName',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            email,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.6),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
