// import 'package:cepu_app/screens/sign_in_screen.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:cepu_app/screens/add_post_screen.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   void initState() {
//     // #TODO: implement initstate
//     super.initState();
//     //testSetUser();
//   }

//   Future<void> signOut(BuildContext context) async {
//     await FirebaseAuth.instance.signOut();
//     Navigator.pushAndRemoveUntil(
//       context,
//       MaterialPageRoute(builder: (context) => SignInScreen()),
//       (route) => false, // Hapus semua route sebelumnya
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Cepu App"),
//         actions: [
//           IconButton(
//             onPressed: () {
//               signOut(context);
//             },
//             icon: const Icon(Icons.logout),
//             tooltip: "Sign Out",
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Center(
//             child: Text(
//               "Halo ${FirebaseAuth.instance.currentUser?.displayName}",
//             ),
//           ),
//           const Center(child: Text("You Have Been Signed In!")),  
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed:() {
//           Navigator.of(context).push(
//             MaterialPageRoute(builder: (context) => const AddPostScreen()),
//           );
//         },
//         child: const Icon(Icons.add), 
//       ),
//     );
//   }
// }


//   // String? _idToken = "";
//   // String? _uid = "";
//   // String? _email = "";
//   // Future<void> getFirebaseAuthUser() async {
//   //   User? user = FirebaseAuth.instance.currentUser;
//   //   if(user != null) {
//   //     _uid = user.uid;
//   //     _email = user.email;
//   //     await user
//   //       .getIdToken(true)
//   //       .then(
//   //         (v) => {
//   //           setState(() {
//   //             _idToken = v;
//   //           }),
//   //         },
//   //       );  
//   //   }
//   // }

import 'package:cepu_app/screens/sign_in_screen.dart';
import 'package:cepu_app/services/post_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cepu_app/screens/add_post_screen.dart';
import 'package:cepu_app/widgets/post_list_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => SignInScreen()),
      (route) => false, // Hapus semua route sebelumnya
    );
  }

  // Fungsi untuk membuat url foto profile / avatar
  String generatedAvatarUrl(String? fullName) {
    final formattedName = fullName!.trim().replaceAll(' ', '+');
    return 'https://ui-avatars.com/api/?namme=$formattedName&color=FFFhFFF&background=000000';
  }

  @override
  Widget build(BuildContext context) {
    final currentUserId = FirebaseAuth.instance.currentUser?.uid;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
        actions: [
          IconButton(
            onPressed: () {
              signOut();
            },
            icon: const Icon(Icons.logout),
            tooltip: "Sign Out",
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 8.0),
          Image.network(
            generatedAvatarUrl(
              FirebaseAuth.instance.currentUser?.displayName.toString(),
            ),
            width: 80,
            height: 80,
          ),
          const SizedBox(height: 8.0),
          Text(
            FirebaseAuth.instance.currentUser!.displayName!,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8.0),
          const Divider(),
          Expanded(
            child: StreamBuilder(
              stream: PostService.getPostList(), 
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text( 'Error: ${snapshot.error}'));
                }
                final posts = snapshot.data ?? [];
                if (posts.isEmpty) {
                  return const Center(child: Text('No posts yet.'));
                }
                return RefreshIndicator(
                  onRefresh: () async {
                  },
                  child: ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      final post = posts[index];
                      final isOwner = 
                        currentUserId != null && 
                        post.userId == currentUserId;
                      // Buat widget PostListItem, didalam folder widgets dengan nama file post_list_item_screen
                      // tambahkan parameter isOwner untuk menentukan apakah tombol delete ditampilkan bagi siapa yang melakukan post
                      return PostListItem(post: post, isOwner: isOwner);
                    },
                  ),
                );
              }
            )
          )
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