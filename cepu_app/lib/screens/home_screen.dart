import 'package:cepu_app/screens/sign_in_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cepu_app/screens/add_post_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // #TODO: implement initstate
    super.initState();
    //testSetUser();
  }

  Future<void> signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => SignInScreen()),
      (route) => false, // Hapus semua route sebelumnya
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cepu App"),
        actions: [
          IconButton(
            onPressed: () {
              signOut(context);
            },
            icon: const Icon(Icons.logout),
            tooltip: "Sign Out",
          ),
        ],
      ),
      body: Column(
        children: [
          Center(
            child: Text(
              "Halo ${FirebaseAuth.instance.currentUser?.displayName}",
            ),
          ),
          const Center(child: Text("You Have Been Signed In!")),  
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:() {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const AddPostScreen()),
          );
        },
        child: const Icon(Icons.add), 
      ),
    );
  }
}


  // String? _idToken = "";
  // String? _uid = "";
  // String? _email = "";
  // Future<void> getFirebaseAuthUser() async {
  //   User? user = FirebaseAuth.instance.currentUser;
  //   if(user != null) {
  //     _uid = user.uid;
  //     _email = user.email;
  //     await user
  //       .getIdToken(true)
  //       .then(
  //         (v) => {
  //           setState(() {
  //             _idToken = v;
  //           }),
  //         },
  //       );  
  //   }
  // }