import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wall/widgets/comment.dart';
import 'package:wall/widgets/skeleton.dart';
import 'package:wall/widgets/thread.dart';

class ThreadScreen extends StatefulWidget {
  final String friendUserName;
  final String friendPostID;
  final String? friendPostUrl;
  final String? friendPost;
  final String friendProfile;
  final List<String> friendLikes;

  const ThreadScreen({
    super.key,
    required this.friendUserName,
    required this.friendPostID,
    this.friendPostUrl,
    this.friendPost,
    required this.friendProfile,
    required this.friendLikes,
  });

  @override
  State<ThreadScreen> createState() => _ThreadScreenState();
}

class _ThreadScreenState extends State<ThreadScreen> {
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
                      'Thread',
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
              Thread(
                user: widget.friendUserName,
                replies: 0,
                likes: widget.friendLikes,
                timestamp: Timestamp.now(), // Updated timestamp
                profile: widget.friendProfile,
                postID: widget.friendPostID,
                post: widget.friendPost,
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  'Replies',
                  textAlign: TextAlign.left,
                  style: GoogleFonts.roboto(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0,
                    color: const Color(0xff000000),
                  ),
                ),
              ),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('User Posts')
                    .doc(widget.friendPostID)
                    .collection('Comments')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 10, // Number of skeleton items to show
                      itemBuilder: (context, index) {
                        return const SkeletonThread();
                      },
                    );
                  } else if (snapshot.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final commentData = snapshot.data!.docs[index];
                        return Comment(
                          user: commentData['commentName'],
                          likes: const [],
                          profile: commentData['commentProfile'],
                          commentID: commentData.id,
                          comment: commentData['commentText'],
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
