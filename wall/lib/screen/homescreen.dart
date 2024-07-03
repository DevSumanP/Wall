import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wall/widgets/skeleton.dart';
import 'package:wall/widgets/thread.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = true; // Add a boolean to track initial loading
  Map<String, int> _commentCounts = {}; // Map to store comment counts

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {},
              child: Image.asset(
                './assets/images/thread-logo.png',
                height: 30,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('User Posts')
                    .orderBy('TimeStamp', descending: true)
                    .snapshots(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting &&
                      _isLoading) {
                    // Show skeleton only at the beginning
                    return ListView.builder(
                      itemCount: 10, // Number of skeleton items to show
                      itemBuilder: (context, index) {
                        return const SkeletonThread();
                      },
                    );
                  } else if (snapshot.hasData) {
                    // Data is loaded, so set loading to false
                    _isLoading = false;

                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final post = snapshot.data!.docs[index];
                        final postUrl = post.data().containsKey('PostURL')
                            ? post['PostURL']
                            : null;
                        final postId = post.id;

                        // Check if comment count is already fetched
                        final commentCount = _commentCounts[postId];

                        // Fetch comment count if not fetched yet
                        if (commentCount == null) {
                          return FutureBuilder(
                            future: FirebaseFirestore.instance
                                .collection('User Posts')
                                .doc(postId)
                                .collection('Comments')
                                .get(),
                            builder: (context,
                                AsyncSnapshot<QuerySnapshot> commentSnapshot) {
                              if (commentSnapshot.connectionState ==
                                  ConnectionState.waiting) {
                                // Handle loading state if needed
                                return const SkeletonThread();
                              } else if (commentSnapshot.hasData) {
                                // Get the total number of comments for this post
                                final count = commentSnapshot.data!.docs.length;
                                _commentCounts[postId] = count;

                                // Return the Thread widget with updated replies count
                                return Thread(
                                  user: post['UserName'],
                                  post: post['Message'],
                                  timestamp: post['TimeStamp'],
                                  replies: count,
                                  likes: List<String>.from(post['Likes'] ?? []),
                                  profile: post['UserProfile'],
                                  postID: postId,
                                  postUrl: postUrl,
                                );
                              } else if (commentSnapshot.hasError) {
                                return Text('Error: ${commentSnapshot.error}');
                              }
                              return const Center(
                                  child: CircularProgressIndicator());
                            },
                          );
                        } else {
                          // Return the Thread widget with cached comment count
                          return Thread(
                            user: post['UserName'],
                            post: post['Message'],
                            timestamp: post['TimeStamp'],
                            replies: commentCount,
                            likes: List<String>.from(post['Likes'] ?? []),
                            profile: post['UserProfile'],
                            postID: postId,
                            postUrl: postUrl,
                          );
                        }
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  // Return a loading indicator when data is being fetched
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
