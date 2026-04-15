import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class TambahDataScreen extends StatefulWidget {
  @override
  _TambahDataScreenState createState() => _TambahDataScreenState(); 
}

class _TambahDataScreenState extends State<TambahDataScreen> {
  final namaC = TextEditingController();
  final jkC = TextEditingController();
  final umurC = TextEditingController();
  final kasusC = TextEditingController();

  // final dbRef = FirebaseDatabase.instance.ref("narapidana");
  final dbRef = FirebaseDatabase.instanceFor(
    app: Firebase.app(),
    databaseURL: "https://latihanuts-calvin-default-rtdb.firebaseio.com/",
  ).ref("narapidana");

  void simpan() async {
    await dbRef.push().set({
      "nama": namaC.text,
      "jenis_kelamin" : jkC.text,
      "umur" : umurC.text,
      "kasus" : kasusC.text,
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tambah Data")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: namaC, decoration: InputDecoration(labelText: "Nama")),
            TextField(controller: jkC, decoration: InputDecoration(labelText: "Jenis Kelamin")),
            TextField(controller: umurC, decoration: InputDecoration(labelText: "Umur")),
            TextField(controller: kasusC, decoration: InputDecoration(labelText: "Kasus" )),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: simpan, 
              child: Text("Simpan"),
            )
          ],
        ),
      ),
    );
  }
}