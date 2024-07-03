import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Follower extends StatefulWidget {
  const Follower({super.key});

  @override
  State<Follower> createState() => _FollowerState();
}

class _FollowerState extends State<Follower> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 100,
      child: Row(
        children: [
          CircleAvatar(
            radius: 10,
            backgroundColor: Colors.black,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.network(
                'https://images.unsplash.com/photo-1633332755192-727a05c4013d?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8YXZhdGFyfGVufDB8fDB8fHww',
              ),
            ),
          ),
          const SizedBox(width: 5),
          Text(
            '1 follower',
            textAlign: TextAlign.left,
            overflow: TextOverflow.clip,
            style: GoogleFonts.roboto(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                letterSpacing: 0,
                color: const Color(0xFF8a8a8a)),
          ),
        ],
      ),
    );
  }
}
