import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wall/Onboarding/threadinfo.dart';
import 'package:wall/widgets/button.dart';
import 'package:wall/widgets/privacy_option.dart';

class SetPrivacy extends StatefulWidget {
  const SetPrivacy({super.key});

  @override
  State<SetPrivacy> createState() => _SetPrivacyState();
}

class _SetPrivacyState extends State<SetPrivacy> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                ),
                const SizedBox(
                  height: 30,
                ),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Icon(
                    Icons.arrow_back,
                    size: 25,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Privacy',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'Your privacy can be different on Threads and \nInstagram.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                    letterSpacing: 0,
                    color: const Color(0xff999999),
                  ),
                ),
                const SizedBox(
                  height: 160,
                ),
                const PrivacyOption(),
                const SizedBox(
                  height: 180,
                ),
                MyButton(
                  title: 'Continue',
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ThreadInfo())),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
