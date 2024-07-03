import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wall/widgets/profile_button.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Friends',
          style: GoogleFonts.roboto(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('Users').snapshots(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final user = snapshot.data!.docs[index];

                        return SearchItem(
                            avatarUrl: user['photo'],
                            userName: user['name'],
                            displayName: user['bio']);
                      });
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SearchItem extends StatelessWidget {
  final String avatarUrl;
  final String userName;
  final String displayName;

  const SearchItem({
    super.key,
    required this.avatarUrl,
    required this.userName,
    required this.displayName,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Padding(
        padding: const EdgeInsets.only(top: 6.0),
        child: CircleAvatar(
          backgroundImage: NetworkImage(avatarUrl),
        ),
      ),
      title: Text(
        userName,
        style: GoogleFonts.roboto(fontSize: 15, fontWeight: FontWeight.w500),
      ),
      subtitle: Text(
        '$displayName\n26.6K followers',
        style: GoogleFonts.roboto(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF8E8E8E)),
      ),
      isThreeLine: true,
      trailing: const SizedBox(
        width: 130,
        child: ProfileButton(
          title: 'Follow',
        ),
      ),
    );
  }
}
