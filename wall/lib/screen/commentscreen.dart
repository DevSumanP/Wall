import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wall/screen/mainscreen.dart';
import 'package:wall/widgets/button_2.dart';
import 'package:firebase_database/firebase_database.dart';

class CommentScreen extends StatefulWidget {
  final String friendUserName;
  final String friendPostID;
  final String? friendPostUrl;
  final String? friendPost;
  final String friendProfile;

  const CommentScreen({
    super.key,
    required this.friendUserName,
    this.friendPostUrl,
    this.friendPost,
    required this.friendProfile,
    required this.friendPostID,
  });

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final messageController = TextEditingController();

  final user = FirebaseAuth.instance.currentUser;
  late DatabaseReference dbRef;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('User Posts');
  }

  void _addComment(String commentText) async {
    try {
      await FirebaseFirestore.instance
          .collection('User Posts')
          .doc(widget.friendPostID)
          .collection('Comments')
          .add({
        'commentText': commentText,
        'commentName': user?.displayName,
        'commentProfile': user?.photoURL,
      });

      // Show a success message
      ScaffoldMessenger.of(BuildContext as BuildContext).showSnackBar(
        const SnackBar(content: Text('Comment added successfully')),
      );

      // Navigate back to the previous screen
      Navigator.push(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (context) => const MainScreen()),
      );
    } catch (error) {
      // Handle the error
      ScaffoldMessenger.of(BuildContext as BuildContext).showSnackBar(
        SnackBar(content: Text('Error adding comment: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(EneftyIcons.close_outline, size: 30),
                    ),
                    const SizedBox(width: 15),
                    Text(
                      'Reply',
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.clip,
                      style: GoogleFonts.roboto(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0,
                        color: const Color(0xff1a1a1a),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                height: 1,
                thickness: 1,
                color: Color(0xffd9d9d9),
              ),
              const SizedBox(height: 10),
              Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.only(left: 70.0),
                        child: Text(
                          widget.friendUserName,
                          textAlign: TextAlign.left,
                          style: GoogleFonts.roboto(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0,
                            color: const Color(0xff000000),
                          ),
                        ),
                      ),
                      const SizedBox(height: 0),
                      Padding(
                        padding: const EdgeInsets.only(left: 70),
                        child: SizedBox(
                          width: 310,
                          child: widget.friendPost != null
                              ? Text(
                                  widget.friendPost!,
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.clip,
                                  style: GoogleFonts.roboto(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0,
                                    color: const Color(0xff1a1a1a),
                                  ),
                                )
                              : const SizedBox(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 65.0),
                        child: SizedBox(
                          child: widget.friendPostUrl != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    widget.friendPostUrl!,
                                    height: 200,
                                  ),
                                )
                              : const SizedBox(),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 5,
                    left: 16,
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.black,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.network(
                          widget.friendProfile,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 60,
                    left: 35,
                    height: 70,
                    width: 2,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color(0xffd9d9d9),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.only(left: 70.0),
                        child: Text(
                          user?.displayName ?? 'Unknown User',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.roboto(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0,
                            color: const Color(0xff000000),
                          ),
                        ),
                      ),
                      const SizedBox(height: 0),
                      Padding(
                        padding: const EdgeInsets.only(left: 70.0, top: 0.0),
                        child: SizedBox(
                          height: 30,
                          width: 300,
                          child: TextField(
                            controller: messageController,
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.fromLTRB(0, 0, 10, 15),
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              hintStyle: const TextStyle(
                                  color: Color(0xff9d9d9d),
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal),
                              labelStyle: const TextStyle(
                                color: Color(0xff1a1a1a),
                                overflow: TextOverflow.clip,
                              ),
                              hintText: "Reply to ${widget.friendUserName}",
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.only(left: 70.0),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: const Icon(
                                EneftyIcons.gallery_outline,
                                color: Color(0xff9d9d9d),
                              ),
                            ),
                            const SizedBox(width: 15),
                            const Icon(
                              EneftyIcons.camera_outline,
                              color: Color(0xff9d9d9d),
                            ),
                            const SizedBox(width: 15),
                            const Icon(
                              EneftyIcons.sticker_outline,
                              color: Color(0xff9d9d9d),
                            ),
                            const SizedBox(width: 15),
                            const Icon(
                              EneftyIcons.microphone_outline,
                              color: Color(0xff9d9d9d),
                            ),
                            const SizedBox(width: 15),
                            const Icon(
                              EneftyIcons.hashtag_2_outline,
                              color: Color(0xff9d9d9d),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 70.0, top: 15),
                        child: Text(
                          "Add to thread",
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.clip,
                          style: GoogleFonts.roboto(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0,
                            color: const Color(0xffE0E0E0),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 5,
                    left: 16,
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.black,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.network(
                          user?.photoURL ??
                              'https://via.placeholder.com/150', // Default image if photoURL is null
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 60,
                    left: 35,
                    height: 70,
                    width: 2,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color(0xffd9d9d9),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 460),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Anyone can reply and quote",
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.clip,
                      style: GoogleFonts.roboto(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0,
                        color: const Color(0xff9d9d9d),
                      ),
                    ),
                    SizedBox(
                      width: 80,
                      height: 40,
                      child: PostButton(
                        title: 'Post',
                        onPressed: () {
                          if (messageController.text.isNotEmpty) {
                            _addComment(messageController.text);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
