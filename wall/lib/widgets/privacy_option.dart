import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class PrivacyOption extends StatefulWidget {
  const PrivacyOption({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PrivacyOptionState createState() => _PrivacyOptionState();
}

class _PrivacyOptionState extends State<PrivacyOption> {
  bool isPublicSelected = true;
  Color selectdColor = const Color(0xff1a1a1a);
  Color unSelectdColor = const Color(0xff999999);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              isPublicSelected = true;
            });
          },
          child: Container(
            height: 115,
            width: MediaQuery.of(context).size.width - 20,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(11),
                border: Border.all(
                  color: isPublicSelected ? selectdColor : unSelectdColor,
                )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Public Profile',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0,
                          color:
                              isPublicSelected ? selectdColor : unSelectdColor,
                        ),
                      ),
                      Visibility(
                        visible: isPublicSelected ? true : false,
                        child: Icon(
                          Icons.check_circle,
                          size: 18,
                          color:
                              isPublicSelected ? selectdColor : unSelectdColor,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                    'Anyone on or off Threads can see, share and with\ninteraction with your content',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      letterSpacing: 0,
                      color: isPublicSelected ? selectdColor : unSelectdColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        InkWell(
          onTap: () {
            setState(() {
              isPublicSelected = false;
            });
          },
          child: Container(
              height: 115,
              width: MediaQuery.of(context).size.width - 20,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(11),
                  border: Border.all(
                    color: isPublicSelected ? unSelectdColor : selectdColor,
                  )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Private Profile',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0,
                            color: isPublicSelected
                                ? unSelectdColor
                                : selectdColor,
                          ),
                        ),
                        Visibility(
                          visible: isPublicSelected ? false : true,
                          child: Icon(
                            Icons.check_circle,
                            size: 18,
                            color: isPublicSelected
                                ? unSelectdColor
                                : selectdColor,
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      'Anyone on or off Threads can see, share and with\ninteraction with your content',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.roboto(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        letterSpacing: 0,
                        color: isPublicSelected ? unSelectdColor : selectdColor,
                      ),
                    ),
                  ),
                ],
              )),
        )
      ],
    );
  }
}
