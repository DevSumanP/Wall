import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wall/Onboarding/privacy.dart';
import 'package:wall/services/auth.dart';
import 'package:wall/widgets/button.dart';
import 'package:wall/widgets/textfield.dart';

class CreateID extends StatefulWidget {
  const CreateID({super.key});

  @override
  State<CreateID> createState() => _CreateIDState();
}

class _CreateIDState extends State<CreateID> {
  late Future<User?> _userFuture;

  @override
  void initState() {
    super.initState();
    _userFuture = _getUser();
  }

  Future<User?> _getUser() async {
    return FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
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
                'Profile',
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
                'Customize your Threads profile.',
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  letterSpacing: 0,
                  color: const Color(0xff999999),
                ),
              ),
              const SizedBox(
                height: 130,
              ),
              FutureBuilder<User?>(
                future: _userFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator(); // Loading indicator while fetching user data
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    final user = snapshot.data;
                    return Stack(
                      children: [
                        Container(
                          height: 215,
                          width: 360,
                          decoration: BoxDecoration(
                            color: const Color(0xffffffff),
                            border: Border.all(
                              color: const Color(0xffD9D9D9),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(11),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 16.0,
                                      top: 12,
                                    ),
                                    child: MyTextField(
                                      title: user?.displayName ?? 'Write name',
                                      label: 'Name',
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(
                                thickness: 0.5,
                                indent: 15,
                                endIndent: 100,
                                color: Color(0xffd9d9d9),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 16.0,
                                  top: 10,
                                ),
                                child: MyTextField(
                                  title: user?.email ?? 'Write bio',
                                  label: 'Bio',
                                ),
                              ),
                              const Divider(
                                thickness: 0.5,
                                indent: 15,
                                endIndent: 15,
                                color: Color(0xffd9d9d9),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 16.0,
                                  top: 10,
                                ),
                                child: MyTextField(
                                  title: user?.photoURL ?? 'Add link',
                                  label: 'Link',
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 16,
                          right: 16,
                          child: CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.black,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.network(
                                user!.photoURL.toString(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              MyButton(
                title: 'Import from Instagram',
                onPressed: () async {},
              ),
              const SizedBox(
                height: 180,
              ),
              MyButton(
                title: 'Continue',
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SetPrivacy())),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
