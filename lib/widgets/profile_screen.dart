import 'package:flutter/material.dart';
import 'package:prj_wisatacandisi51/widgets/profile_info_item.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // TODO : 1. Deklarasikan variabel yang dibutuhkan
  bool isSignedin = true;
  String fullname = '';
  String username = '';
  int favoriteCandiCount = 10;

  // TODO : 5. Implementasi fungsi Signin
  void signIn() {
    setState(() {
      isSignedin = !isSignedin;
    });
  }

  // TODO : 6. Implementasi fungsi Signout
  void signOut() {
    setState(() {
      isSignedin = !isSignedin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            color: Colors.deepPurple,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                // TODO : 2. Buat bagian ProfileHeader yang berisi gambar profil
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 200 - 50),
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.deepPurple, width: 2),
                            shape: BoxShape.circle,
                          ),
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage:
                                AssetImage('images/placeholder_image.png'),
                          ),
                        ),
                        if (isSignedin)
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.camera_alt,
                              color: Colors.red,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                // TODO : 3. Buat bagian Profileinfo yang berisi info profil
                SizedBox(
                  height: 20,
                ),
                Divider(
                  color: Colors.deepPurple[100],
                ),
                SizedBox(
                  height: 4,
                ),
                ProfileInfoItem(
                    icon: Icons.lock,
                    label: 'Pengguna',
                    value: username,
                    iconColor: Colors.amber),
                SizedBox(
                  height: 4,
                ),
                Divider(
                  color: Colors.deepPurple[100],
                ),
                SizedBox(
                  height: 4,
                ),
                ProfileInfoItem(
                    icon: Icons.person,
                    label: 'Nama',
                    value: fullname,
                    showEditIcon: isSignedin,
                    onEditPressed: () {
                      debugPrint('Icon edit ditekan ...');
                    },
                    iconColor: Colors.blue),
                SizedBox(
                  height: 4,
                ),
                Divider(
                  color: Colors.deepPurple[100],
                ),
                SizedBox(
                  height: 4,
                ),
                ProfileInfoItem(
                    icon: Icons.favorite,
                    label: 'Favorit',
                    value: favoriteCandiCount > 0 ? '$favoriteCandiCount' : '',
                    iconColor: Colors
                        .red), // TODO : 4. Buat ProfileActions yang berisi TextButton sign in/out
                SizedBox(
                  height: 4,
                ),
                Divider(
                  color: Colors.deepPurple[100],
                ),
                SizedBox(
                  height: 20,
                ),
                isSignedin
                    ? TextButton(onPressed: signOut, child: Text('Sign out'))
                    : TextButton(onPressed: signIn, child: Text('Sign In')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
