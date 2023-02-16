import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RenderSvg extends StatelessWidget {
  final String svgPath;
  final Color? color;
  const RenderSvg({super.key, required this.svgPath, this.color});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      svgPath,
      color: color ?? Colors.white,
    );
  }
}
