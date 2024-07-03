import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wall/widgets/like_button.dart';

class Comment extends StatefulWidget {
  final String user;
  final String? comment;
  final String commentID;
  final List<String> likes;
  final String profile;

  const Comment({
    super.key,
    required this.user,
    required this.likes,
    required this.profile,
    required this.commentID,
    this.comment,
  });

  @override
  State<Comment> createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  final user = FirebaseAuth.instance.currentUser!;
  late bool isLiked;

  @override
  void initState() {
    super.initState();
    isLiked = widget.likes.contains(user.email);
  }

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });

    DocumentReference commentRef = FirebaseFirestore.instance
        .collection('User Posts')
        .doc(widget.commentID);

    if (isLiked) {
      commentRef.update({
        'Likes': FieldValue.arrayUnion([user.email])
      });
    } else {
      commentRef.update({
        'Likes': FieldValue.arrayRemove([user.email])
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 65.0),
                      child: Text(widget.user,
                          textAlign: TextAlign.left,
                          style: GoogleFonts.roboto(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0,
                            color: const Color(0xff000000),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: Row(
                        children: [
                          Text(
                            '11h',
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.clip,
                            style: GoogleFonts.roboto(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0,
                              color: const Color(0xff999999),
                            ),
                          ),
                          const SizedBox(
                            width: 7,
                          ),
                          const Icon(
                            Icons.more_horiz,
                            size: 25,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 0),
                Padding(
                  padding: const EdgeInsets.only(left: 65.0),
                  child: SizedBox(
                    width: 310,
                    child: widget.comment != null
                        ? Text(
                            widget.comment!,
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
                  child: Row(
                    children: [
                      LikeButton(
                        isLiked: isLiked,
                        onTap: toggleLike,
                      ),
                      const SizedBox(width: 20),
                      GestureDetector(
                        onTap: () {},
                        child: const Icon(EneftyIcons.message_2_outline),
                      ),
                      const SizedBox(width: 20),
                      const Icon(EneftyIcons.repeat_outline),
                      const SizedBox(width: 20),
                      const Icon(EneftyIcons.send_2_outline),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const SizedBox(height: 15),
                Container(
                  height: 1,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: const Color(0xffd9d9d9),
                  ),
                ),
                const SizedBox(height: 15),
              ],
            ),
            Positioned(
              top: 5,
              left: 16,
              child: CircleAvatar(
                radius: 18,
                backgroundColor: Colors.black,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(
                    widget.profile,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 50,
              left: 30,
              height: 50,
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
      ),
    );
  }
}
