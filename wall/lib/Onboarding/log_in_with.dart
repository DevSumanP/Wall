import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wall/Onboarding/create_id.dart';
import 'package:wall/services/auth.dart';

class LogInWith extends StatefulWidget {
  const LogInWith({super.key});

  @override
  State<LogInWith> createState() => _LogInWithState();
}

class _LogInWithState extends State<LogInWith> {
  bool _isLoading = false;

  void _startLoading() {
    setState(() {
      _isLoading = true;
    });
    Timer(const Duration(seconds: 5), _stopLoading);
  }

  void _stopLoading() {
    setState(() {
      _isLoading = false;
    });
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const CreateID()));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color(0xffFAFAFA),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "./assets/images/banner.png",
              height: 600,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 110,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GestureDetector(
                onTap: () async {
                  await AuthService().signInWithGoogle();
                  _startLoading();
                },
                child: Container(
                  height: 80,
                  width: 360,
                  decoration: BoxDecoration(
                    color: const Color(0xffFFFFFF),
                    border:
                        Border.all(color: const Color(0xffd9d9d9), width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 16.0, bottom: 0.0),
                            child: Text(
                              'Log in with Instagram',
                              style: GoogleFonts.roboto(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 0,
                                  color: const Color(0xff979797)),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 16.0, bottom: 0.0),
                            child: Text(
                              'joshuasmithmobbin',
                              style: GoogleFonts.roboto(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 0,
                                  color: const Color(0xff000000)),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Image.asset(
                          './assets/images/instagram.png',
                          height: 60,
                          width: 60,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
