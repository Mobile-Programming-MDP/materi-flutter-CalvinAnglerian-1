import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notes/models/note.dart';

class NoteService {
  static final FirebaseFirestore _database = FirebaseFirestore.instance;
  static final CollectionReference _noteCollection = 
    _database.collection('notes');
  
  // Method tambah data
  static Future<void> addNote(Note note) async {
    Map<String, dynamic> newNote = {
      'title': note.title,
      'description': note.description,
      'image_base_64': note.imageBase64,
      'created_at': FieldValue.serverTimestamp(),
      'update_at': FieldValue.serverTimestamp(),
    };
    await _noteCollection.add(newNote);
  }

  // Method menampilkan data
  static Stream<List<Note>> getNoteList() {
    return _noteCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return Note(
          id: doc.id,
          title: data['title'], 
          description: data ['description'],
          imageBase64: data['image_base_64'],
          createdAt: data['created_at'] != null
            ? data['created_at'] as Timestamp
            : null,
          updatedAt: data['update_at'] != null
            ? data['updated_at'] as Timestamp
            : null,
        );
      }).toList();
    });
  }

  // Method untuk ubah data
  static Future<void> updateNote(Note note) async {
    Map<String, dynamic> updateNote = {
      'title': note.title,
      'description': note.description,
      '_base64Image': note.imageBase64,
      'created_at': note.createdAt,
      'updated_at': FieldValue.serverTimestamp(),
    };

    await _noteCollection.doc(note.id).update(updateNote);
  }

  // Method untuk hapus data
  static Future<void> deleteNote(Note note) async {
    await _noteCollection.doc(note.id).delete();
  }

  // Method upload image
  static Future<String?> uploadImage(File imageFile) async {
    try {
      String fileName = path.basename(imageFile.path);
      Reference ref = _storage.ref().child('images/$fileName');
    } catch (e) {
      
    }
  }
}
