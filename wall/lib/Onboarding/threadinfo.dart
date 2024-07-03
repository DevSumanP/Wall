import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wall/screen/mainscreen.dart';
import 'package:wall/widgets/button.dart';

class ThreadInfo extends StatelessWidget {
  const ThreadInfo({super.key});

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
                  'How Thread Works',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0,
                  ),
                ),
                const SizedBox(
                  height: 80,
                ),
                Stack(children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 65,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Powered by Instagram',
                              textAlign: TextAlign.left,
                              style: GoogleFonts.roboto(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0,
                                color: const Color(0xff000000),
                              ),
                            ),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text:
                                        'Thread is a part of Instagram platform. We\nwill use your Threads and Instagram\ninformation to personalize ads and other\nexperience across Threads and Instagram.\n',
                                    style: GoogleFonts.roboto(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      letterSpacing: 0,
                                      color: const Color(0xff999999),
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Learn more.',
                                    style: GoogleFonts.roboto(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Positioned(
                      top: 0,
                      left: 20,
                      child: Icon(
                        Icons.all_inclusive,
                        color: Colors.black,
                      ))
                ]),
                const SizedBox(
                  height: 30,
                ),
                Stack(children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 65,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'The fediverse',
                              textAlign: TextAlign.left,
                              style: GoogleFonts.roboto(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0,
                                color: const Color(0xff000000),
                              ),
                            ),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text:
                                        'Thread is a part of Instagram platform. We\nwill use your Threads and Instagram\ninformation to personalize ads and other\ninformation to personalize ads and other\nexperience across Threads and Instagram.\n',
                                    style: GoogleFonts.roboto(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      letterSpacing: 0,
                                      color: const Color(0xff999999),
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Learn more.',
                                    style: GoogleFonts.roboto(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Positioned(
                      top: 0,
                      left: 20,
                      child: Icon(
                        Icons.auto_awesome_rounded,
                        color: Colors.black,
                      ))
                ]),
                const SizedBox(
                  height: 30,
                ),
                Stack(children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 65,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Your data',
                              textAlign: TextAlign.left,
                              style: GoogleFonts.roboto(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0,
                                color: const Color(0xff000000),
                              ),
                            ),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text:
                                        'Thread is a part of Instagram platform. We\nwill use your Threads and Instagram\ninformation to personalize ads and other\nexperience across Threads and Instagram.\n',
                                    style: GoogleFonts.roboto(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      letterSpacing: 0,
                                      color: const Color(0xff999999),
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Learn more.',
                                    style: GoogleFonts.roboto(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Positioned(
                      top: 0,
                      left: 20,
                      child: Icon(
                        Icons.android,
                        color: Colors.black,
                      ))
                ]),
                const SizedBox(
                  height: 100,
                ),
                MyButton(
                    title: 'Join Threads',
                    onPressed: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MainScreen()))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
