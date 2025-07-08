import 'package:flutter/material.dart';

class LightBox extends StatelessWidget {
  const LightBox({
    super.key,
    required this.color,
    required this.icon,
    this.text,
    required this.textStyle,
  });

  final Color? color;
  final IconData? icon;
  final String? text;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height / 5,
      // width: MediaQuery.of(context).size.width / 3,
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
      decoration: BoxDecoration(
        border: BoxBorder.all(color: color!.withAlpha((0.7 * 255).round())),
        color: color!.withAlpha((0.08 * 255).round()),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: color!.withAlpha((0.1 * 255).round()),
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) Icon(icon, color: color),
          if (text != null) const SizedBox(width: 6),
          if (text != null)
            Text(text!, style: textStyle.copyWith(color: color, fontSize: 12)),
        ],
      ),
    );
  }
}
