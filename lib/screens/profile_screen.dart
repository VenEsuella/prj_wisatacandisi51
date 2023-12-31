import 'package:flutter/material.dart';
import 'package:prj_wisatacandisi51/widgets/profile_info_item.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // TODO : 1. Deklarasikan variabel yang dibutuhkan
  bool isSignedin = false;
  String fullname = "";
  String username = "";
  int favoriteCandiCount = 0;
  Future<void> _retrieveAndDecryptDataFromPrefs() async {
    final Future<SharedPreferences> prefsFuture =
        SharedPreferences.getInstance();
    final SharedPreferences sharedPreferences = await prefsFuture;

    final encryptedUsername = sharedPreferences.getString('username') ?? '';
    final encryptedFullname = sharedPreferences.getString('fullname') ?? '';
    final keyString = sharedPreferences.getString('key') ?? '';
    final ivString = sharedPreferences.getString('iv') ?? '';

    final encrypt.Key key = encrypt.Key.fromBase64(keyString);
    final iv = encrypt.IV.fromBase64(ivString);

    final encrypter = encrypt.Encrypter(encrypt.AES(key));

    if (encryptedFullname != "") {
      final decryptedUsername = encrypter.decrypt64(encryptedUsername, iv: iv);
      final decryptedFullname = encrypter.decrypt64(encryptedFullname, iv: iv);

      setState(() {
        username = decryptedUsername;
        fullname = decryptedFullname;
        isSignedin = true;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _retrieveAndDecryptDataFromPrefs();
  }

  void _signOutLocalStorage() async {
    try {
      final Future<SharedPreferences> prefsFuture =
          SharedPreferences.getInstance();

      final SharedPreferences prefs = await prefsFuture;
      prefs.setBool('isSignedIn', false);
      prefs.setString('fullname', "");
      prefs.setString('username', "");
      prefs.setString('password', "");
      prefs.setString('key', "");
      prefs.setString('iv', "");

      setState(() {
        fullname = "";
        username = "";
        isSignedin = false;
      });
    } catch (e) {
      print('An error occurred: $e');
    }
  }

  // TODO : 5. Implementasi fungsi Signin
  void signIn() {
    setState(() {
      // isSignedin = !isSignedin;
      Navigator.pushNamed(context, '/signin');
      isSignedin = !isSignedin;
    });
  }

  // TODO : 6. Implementasi fungsi Signout
  void signOut() {
    setState(() {
      _signOutLocalStorage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wisata Candi'),
      ),
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
                          child: const CircleAvatar(
                            radius: 50,
                            backgroundImage:
                                AssetImage('images/placeholder_image.png'),
                          ),
                        ),
                        if (isSignedin)
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.camera_alt,
                              color: Colors.red,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                // TODO : 3. Buat bagian Profileinfo yang berisi info profil
                const SizedBox(
                  height: 20,
                ),
                Divider(
                  color: Colors.deepPurple[100],
                ),
                const SizedBox(
                  height: 4,
                ),
                ProfileInfoItem(
                    icon: Icons.lock,
                    label: 'Pengguna',
                    value: username,
                    iconColor: Colors.amber),
                const SizedBox(
                  height: 4,
                ),
                Divider(
                  color: Colors.deepPurple[100],
                ),
                const SizedBox(
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
                const SizedBox(
                  height: 4,
                ),
                Divider(
                  color: Colors.deepPurple[100],
                ),
                const SizedBox(
                  height: 4,
                ),
                ProfileInfoItem(
                    icon: Icons.favorite,
                    label: 'Favorit',
                    value: favoriteCandiCount > 0 ? '$favoriteCandiCount' : '',
                    iconColor: Colors
                        .red), // TODO : 4. Buat ProfileActions yang berisi TextButton sign in/out
                const SizedBox(
                  height: 4,
                ),
                Divider(
                  color: Colors.deepPurple[100],
                ),
                const SizedBox(
                  height: 20,
                ),
                isSignedin
                    ? TextButton(
                        onPressed: signOut, child: const Text('Sign out'))
                    : TextButton(
                        onPressed: signIn, child: const Text('Sign In')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
