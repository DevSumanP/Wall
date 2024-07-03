// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LikeButton extends StatelessWidget {
  final bool isLiked;
  void Function()? onTap;
  LikeButton({
    super.key,
    required this.isLiked,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        isLiked ? EneftyIcons.heart_bold : EneftyIcons.heart_outline,
        color: isLiked ? const Color(0xFFFF0000) : const Color(0xff1a1a1a),
      ),
    );
  }
}
