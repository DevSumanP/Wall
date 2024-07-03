import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wall/services/auth.dart';
import 'package:wall/widgets/follower.dart';
import 'package:wall/widgets/profile_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Your existing profile content
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Icon(
                          Icons.account_circle_outlined,
                          size: 25,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          AuthService().signOut();
                        },
                        child: const Align(
                          alignment: Alignment.topRight,
                          child: Icon(
                            Icons.menu_outlined,
                            size: 25,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user!.displayName.toString(),
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.clip,
                            style: GoogleFonts.roboto(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0,
                              color: const Color(0xff1a1a1a),
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                user!.email.toString(),
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.roboto(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 0,
                                  color: const Color(0xff1a1a1a),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Container(
                                height: 18,
                                width: 60,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: const Color.fromARGB(
                                        255, 236, 236, 236)),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 2.0),
                                  child: Text(
                                    'thread.net',
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.clip,
                                    style: GoogleFonts.roboto(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 0,
                                        color: const Color(0xFF8A8A8A)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.black,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.network(
                            user!.photoURL.toString(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'I love to travel, and hope to see more of the world each day.',
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.clip,
                    style: GoogleFonts.roboto(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0,
                        color: const Color(0xFF1a1a1a)),
                  ),
                  const Follower(),
                  const SizedBox(
                    height: 15,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ProfileButton(title: 'Edit Profile'),
                      ProfileButton(title: 'Share Profile'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  const TabBar(
                    indicatorColor: Color(0xff1a1a1a),
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorWeight: 1,
                    labelColor: Color(0xff1a1a1a),
                    unselectedLabelColor: Color(0xff9d9d9d),
                    tabs: [
                      Tab(text: 'Threads'),
                      Tab(text: 'Replies'),
                    ],
                  ),
                  SingleChildScrollView(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height - 420,
                      child: const TabBarView(
                        children: [
                          Center(child: Text('Tab 1 Content')),
                          Center(child: Text('Tab 2 Content')),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
