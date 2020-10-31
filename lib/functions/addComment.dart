

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/utils/variables.dart';
import 'package:image_picker/image_picker.dart';

class AddComment extends StatefulWidget {
  @override
  _AddCommentState createState() => _AddCommentState();
}

class _AddCommentState extends State<AddComment> {
  var commentController =TextEditingController();

  File imagePath;

  bool uploading = false;


  pickImage(ImageSource imgSource) async {
    final image = await ImagePicker().getImage(source: imgSource);
    setState(() {
      imagePath = File(image.path) ;
    });
    Navigator.pop(context);
  }

  optionsDialog() {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            children: [
              SimpleDialogOption(
                onPressed: () =>pickImage(ImageSource.gallery),
                child: Text(
                  "Image from gallery",
                  style: myStyle(20),
                ),
              ),
              SimpleDialogOption(
                onPressed: () =>pickImage(ImageSource.camera),
                child: Text(
                  "Image from camera",
                  style: myStyle(20),
                ),
              ),
              SimpleDialogOption(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  "Cancel",
                  style: myStyle(20),
                ),
              )
            ],
          );
        });
  }

  uploadImage(String id) async {
    StorageUploadTask storageUploadTask =
    commentPictures.child(id).putFile(imagePath);
    StorageTaskSnapshot storageTaskSnapshot =
    await storageUploadTask.onComplete;
    String downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  postComment() async {

    setState(() {
      uploading = true;
    });

    var firebaseUser = FirebaseAuth.instance.currentUser;
    DocumentSnapshot userDoc = await usercollection.doc(firebaseUser.uid).get();
    var allDocuments = await commentCollection.get();
    int length = allDocuments.docs.length;
    // 3 conditions
    // only comment
    if (commentController.text != '' && imagePath == null) {
      commentCollection.doc('Comment $length').set({
        'username': userDoc.data()['username'],
        'profilePic': userDoc.data()['profilePic'],
        'uid': firebaseUser.uid,
        'id': 'Comment $length',
        'comment': commentController.text,
        'commentCount': 0,
        'shares': 0,
        'type': 1
      });
      Navigator.pop(context);
    }
    // only image
    if (commentController.text == '' && imagePath != null) {
      String imageUrl = await uploadImage('Comment $length');
      commentCollection.doc('Comment $length').set({
        'username': userDoc.data()['username'],
        'profilePic': userDoc.data()['profilePic'],
        'uid': firebaseUser.uid,
        'id': 'Comment $length',
        'image': imageUrl,
        'commentCount': 0,
        'shares': 0,
        'type': 2
      });
      Navigator.pop(context);
    }

    // comment and image
    if (commentController.text != '' && imagePath != null) {
      String imageUrl = await uploadImage('Comment $length');
      commentCollection.doc('Comment $length').set({
        'username': userDoc.data()['username'],
        'profilePic': userDoc.data()['profilePic'],
        'uid': firebaseUser.uid,
        'id': 'Comment $length',
        'comment': commentController.text,
        'image': imageUrl,
        'commentCount': 0,
        'shares': 0,
        'type': 3
      });
      Navigator.pop(context);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: ()=>postComment(),
        child: Icon(
          Icons.publish,
          size: 32,
        ),
      ),
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back, size: 32),
        ),
        centerTitle: true,
        title: Text(
          "Add Queries here ",
          style: myStyle(20),
        ),
        actions: [
          InkWell(
            onTap: () => optionsDialog(),
            child: Icon(
              Icons.photo,
              size: 40,
            ),
          )
        ],
      ),

      body:
      uploading == false
          ? Column(
        children: [
          Expanded(
            child: TextField(
              controller: commentController,
              maxLines: null,
              style: myStyle(20),
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 20),
                  labelText: "What's your query?",
                  labelStyle: myStyle(25),
                  border: InputBorder.none),
            ),
          ),
          imagePath == null ? Container() : MediaQuery.of(context).viewInsets.bottom >0 ?Container() :Image(
              width: 200,
              height: 200,
              image: FileImage(imagePath),
              )
        ],
      ):
          Center(
            child: Text(
              "Uploading.....",
              style: myStyle(25),
            ),
          ),

    );
  }
}
