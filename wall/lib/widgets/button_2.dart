import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PostButton extends StatefulWidget {
  final String title;
  final Function() onPressed;
  const PostButton({super.key, required this.title, required this.onPressed});

  @override
  // ignore: library_private_types_in_public_api
  _PostButtonState createState() => _PostButtonState();
}

class _PostButtonState extends State<PostButton> {
  bool _isLoading = false;

  void _startLoading() {
    setState(() {
      _isLoading = true;
    });
    Timer(Duration(seconds: 3),
        _stopLoading); // Set loading duration to 5 seconds
  }

  void _stopLoading() {
    setState(() {
      _isLoading = false;
    });
    widget.onPressed(); // Execute the button action after loading
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _startLoading(); // Start loading when button is pressed
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xff1a1a1a),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), // Button border radius
          side: const BorderSide(
            color: Color(0xff1a1a1a), // Border color
            width: 2, // Border width
          ),
        ),
        fixedSize: const Size(360, 50), // Width and height of the button
        // Text color of the button
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (!_isLoading) // Show button text only when not loading
            Text(
              widget.title,
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: const Color(0xffffffff),
              ),
            ),
          if (_isLoading) // Show loading indicator when loading
            const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
        ],
      ),
    );
  }
}
