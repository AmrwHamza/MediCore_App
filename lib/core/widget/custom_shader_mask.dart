// import 'package:flutter/material.dart';

// class CustomShaderMask extends StatelessWidget {
//   const CustomShaderMask({super.key, required this.child});

//   final Widget child;

//   @override
//   Widget build(BuildContext context) {
//     return ShaderMask(
//       shaderCallback: (Rect bounds) {
//         return const LinearGradient(
//           begin: Alignment.topCenter,
//           end: Alignment.bottomCenter,
//           colors: [Colors.red, Colors.amber, Colors.black, Colors.green],
//           stops: [0.0, 0.5, 0.95, 1.0],
//         ).createShader(bounds);
//       },
//       blendMode: BlendMode.dstIn,
//       child: child,
//     );
//   }
// }
