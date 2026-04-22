import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notes/models/note.dart';
import 'package:notes/services/note_service.dart';

class NoteDialog extends StatefulWidget {
  final Note? note;
  NoteDialog({super.key, this.note});
  @override
  State<NoteDialog> createState() => _noteDialogState();
}

class _noteDialogState extends State<NoteDialog> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  File? _imageFile;
  String? _base64Image;

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _descriptionController.text = widget.note!.description;
      _base64Image = widget.note!.imageBase64;
    }
  }

  Future<void> _pickImage() async {
    final PickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (PickedFile != null) {
      final bytes = await PickedFile.readAsBytes();
      String _base64String = base64Encode(bytes);
      setState(() {
        _base64Image = _base64String;
        _imageFile = File(PickedFile.path);
      });
      print("Base64 String: $_base64String");
    }else {
      print("No image selected.");
    }
  }
}