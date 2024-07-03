import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileButton extends StatefulWidget {
  final String title;
  const ProfileButton({super.key, required this.title});

  @override
  State<ProfileButton> createState() => _ProfileButtonState();
}

class _ProfileButtonState extends State<ProfileButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      width: 170,
      child: ElevatedButton(
        onPressed: () {
          // Action for Edit profile button
        },
        style: ElevatedButton.styleFrom(
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 0.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: const BorderSide(color: Color(0xffd9d9d9)),
          ),
        ),
        child: Text(
          widget.title,
          style: GoogleFonts.poppins(
              fontSize: 13.0,
              fontWeight: FontWeight.w500,
              color: const Color(0xff1a1a1a)),
        ),
      ),
    );
  }
}
