import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

myStyle(double size, [Color color, FontWeight fw]) {
  return GoogleFonts.montserrat(fontSize: size, fontWeight: fw, color: color);
}

CollectionReference usercollection = FirebaseFirestore.instance.collection('users');

var exampleImage = 'gs://commentsystem-ef25d.appspot.com/userImg.png';


CollectionReference commentCollection =
FirebaseFirestore.instance.collection('comments');
StorageReference commentPictures = FirebaseStorage.instance.ref().child('commentPics');