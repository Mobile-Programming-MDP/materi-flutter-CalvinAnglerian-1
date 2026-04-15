import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:latihanuts/screens/tambahData_screen.dart';
import 'package:firebase_core/firebase_core.dart';

class HomeScreen extends StatelessWidget {
  // final dbRef = FirebaseDatabase.instance.ref("narapidana");
  final dbRef = FirebaseDatabase.instanceFor(
    app: Firebase.app(),
    databaseURL: "https://latihanuts-calvin-default-rtdb.firebaseio.com/",
  ).ref("narapidana");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.greenAccent, // Warna background pada bagian tengah
      appBar: AppBar(
        title: Text(
          "Data Narapidana",
          style: TextStyle(color: Colors.red, fontSize: 20),
        ),
        backgroundColor: Colors.blue,
      ), // bg pada judul

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => TambahDataScreen()),
          );
        },
      ),

      body: StreamBuilder(
        stream: dbRef.onValue,

        builder: (context, snapshot) {
          // loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          // kalau tidak ada data/ data kosong
          if (!snapshot.hasData || snapshot.data!.snapshot.value == null) {
            return Center(child: Text("Belum ada data"));
          }

          // ambil data
          final data = snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
          final list = data.entries.toList();

          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              // AMBIL KEY UNTUK HAPUS DATA
              final key = list[index].key;

              // Isi data
              final item = list[index].value;

              return Card(
                margin: EdgeInsets.all(10),
                color: Colors.white,
                child: ListTile(
                  title: Text(item['nama'] ?? '-'),
                  subtitle: Text(
                    "${item['jenis_kelamin'] ?? '-'} | ${item['umur'] ?? '-'} | ${item['kasus'] ?? '-'}",
                  ),

                  // LETAK TOMBOL HAPUS
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),

                    //HAPUS DATA
                    onPressed: () {
                      dbRef.child(key).remove(); // Hapus data berdasarkan key

                      // Notifikasi data dihapus
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Data dihapus")),
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
