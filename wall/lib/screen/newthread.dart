import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wall/screen/mainscreen.dart';
import 'package:wall/widgets/button_2.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';

class NewThread extends StatefulWidget {
  const NewThread({super.key});

  @override
  State<NewThread> createState() => _NewThreadState();
}

class _NewThreadState extends State<NewThread> {
  final messageController = TextEditingController();

  final user = FirebaseAuth.instance.currentUser;
  late DatabaseReference dbRef;
  late String imageUrl;
  File? selectedImage; // Variable to hold the selected image

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('User Posts');
  }

  Future<void> uploadImage() async {
    final file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file == null) return;

    String fileName = DateTime.now().microsecondsSinceEpoch.toString();

    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDireImages = referenceRoot.child('images');
    Reference referenceImageToUpload = referenceDireImages.child(fileName);

    try {
      // Convert PickedFile to File
      File pickedFile = File(file.path);

      // Put the file to Firebase Storage
      await referenceImageToUpload.putFile(pickedFile);

      // Get the download URL
      imageUrl = await referenceImageToUpload.getDownloadURL();

      // Update the selected image
      setState(() {
        selectedImage = pickedFile;
      });
    } catch (error) {
      // Handle the error
    }
  }

  void post() async {
    setState(() {
      isLoading = true;
    });

    try {
      // Check if an image is selected
      if (selectedImage != null) {
        // If an image is selected, upload it to Firebase Storage
        await uploadImage();
        // After uploading the image, check if there's also text content
        if (messageController.text.isNotEmpty) {
          // If both text content and image are available, post with both
          await FirebaseFirestore.instance.collection("User Posts").add({
            "UserName": user!.displayName.toString(),
            "Message": messageController.text,
            "Replies": [],
            "Likes": [],
            "TimeStamp": Timestamp.now(),
            "UserProfile": user!.photoURL.toString(),
            "PostURL": imageUrl, // Add image URL
          });
        } else {
          // If only an image is available, post with only the image
          await FirebaseFirestore.instance.collection("User Posts").add({
            "UserName": user!.displayName.toString(),
            "Replies": [],
            "Likes": [],
            "TimeStamp": Timestamp.now(),
            "UserProfile": user!.photoURL.toString(),
            "PostURL": imageUrl, // Add image URL
          });
        }
      } else {
        // If no image is selected, check if there's text content
        if (messageController.text.isNotEmpty) {
          // If only text content is available, post with only the text
          await FirebaseFirestore.instance.collection("User Posts").add({
            "UserName": user!.displayName.toString(),
            "Message": messageController.text,
            "Replies": 0,
            "Likes": [],
            "TimeStamp": Timestamp.now(),
            "UserProfile": user!.photoURL.toString(),
          });
        }
        // If neither text nor image is available, do nothing
      }

      ScaffoldMessenger.of(BuildContext as BuildContext).showSnackBar(
        const SnackBar(content: Text('Post created successfully')),
      );
      // Navigate to the MainScreen after posting
      Navigator.push(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (context) => const MainScreen()),
      );
    } catch (error) {
      // Handle the error
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(BuildContext as BuildContext).showSnackBar(
        SnackBar(content: Text('Error creating post: $error')),
      );
    } finally {
      // Clear text and image after posting
      messageController.clear();
      setState(() {
        selectedImage = null;
        imageUrl = '';
        isLoading = false;
      });
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
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MainScreen(),
                          )),
                      child: const Icon(EneftyIcons.close_outline, size: 30),
                    ),
                    const SizedBox(width: 15),
                    Text(
                      'New Thread',
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
                          user!.displayName.toString(),
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
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.fromLTRB(0, 0, 10, 10),
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              hintStyle: TextStyle(
                                color: Color(0xff9d9d9d),
                              ),
                              labelStyle: TextStyle(
                                color: Color(0xff1a1a1a),
                                overflow: TextOverflow.clip,
                              ),
                              hintText: "What's new?",
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.only(left: 70.0, bottom: 15),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: selectedImage != null
                              ? Image.file(
                                  selectedImage!,
                                  height: 200,
                                  width: 150,
                                )
                              : Container(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 70.0),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: uploadImage,
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
                          user!.photoURL.toString(),
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
                      child: PostButton(title: 'Post', onPressed: post),
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
