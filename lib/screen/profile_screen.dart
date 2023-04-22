import 'package:fake_store/data/response/user_response.dart';
import 'package:fake_store/screen/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../helper/firebase_service.dart';

class ProfileScreen extends StatefulWidget {
  final UserResponse? user;

  const ProfileScreen({Key? key, this.user}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  FirebaseService service = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 80,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox.shrink(),
                Text(
                  'Profile',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    if (FirebaseAuth.instance.currentUser != null) {
                      await service.signOutFromGoogle();
                      await FirebaseAuth.instance.signOut();
                    } else {
                      isLoggedIn.add(false);
                    }
                  },
                  icon: Icon(Icons.exit_to_app),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            ClipOval(
              child: FirebaseAuth.instance.currentUser?.photoURL != null
                  ? Image.network(
                      FirebaseAuth.instance.currentUser!.photoURL!,
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover,
                    )
                  : Icon(
                      Icons.person_outline,
                      size: 100,
                    ),
            ),
            Divider(
              indent: 15,
              endIndent: 15,
              thickness: 2,
              color: Theme.of(context).primaryColor,
            ),
            Row(
              children: [
                Text(
                  'Name ',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  width: 30,
                ),
                Text(
                  FirebaseAuth.instance.currentUser?.displayName ?? widget.user!.userName ?? '',
                  style: TextStyle(fontSize: 20),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  'Email ',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  width: 30,
                ),
                Text(
                  FirebaseAuth.instance.currentUser?.email ?? widget.user!.email ?? '',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  'Phone ',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  width: 30,
                ),
                Text(
                  FirebaseAuth.instance.currentUser?.phoneNumber ?? widget.user?.phone ?? '- - -',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
