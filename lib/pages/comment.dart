
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/utils/variables.dart';
import 'package:timeago/timeago.dart' as tAgo;


class CommentPage extends StatefulWidget {
  final String documentId;
  CommentPage(this.documentId);

  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {

  var commentController = TextEditingController();


  addComment() async {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    DocumentSnapshot userDoc = await usercollection.doc(firebaseUser.uid).get();
    commentCollection.doc(widget.documentId).collection('comments').doc().set({
      'comment': commentController.text,
      'username': userDoc.data()['username'],
      'uid': userDoc.data()['uid'],
      'profilePic': userDoc.data()['profilePic'],
      'time': DateTime.now()
    });
    DocumentSnapshot commentCount =
    await commentCollection.doc(widget.documentId).get();

    commentCollection
        .doc(widget.documentId)
        .update({'commentCount': commentCount.data()['commentCount'] + 1});
    commentController.clear();
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder(
                  stream: commentCollection
                      .doc(widget.documentId)
                      .collection('comments')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot commentDoc =
                          snapshot.data.docs[index];
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.white,
                              backgroundImage:
                              NetworkImage(commentDoc.data()['profilePic']),
                            ),
                            title: Row(
                              children: [
                                Text(
                                  commentDoc.data()['username'],
                                  style: myStyle(20),
                                ),
                                SizedBox(
                                  width: 15.0,
                                ),
                                Text(
                                  commentDoc.data()['comment'],
                                  style:
                                  myStyle(20, Colors.grey, FontWeight.w500),
                                ),
                              ],
                            ),
                            subtitle: Text(
                              tAgo
                                  .format(commentDoc.data()['time'].toDate())
                                  .toString(),
                              style: myStyle(15),
                            ),
                          );
                        });
                  },
                ),
              ),
              Divider(),
              ListTile(
                title: TextFormField(
                  controller: commentController,
                  decoration: InputDecoration(
                    hintText: "Add a Query..",
                    hintStyle: myStyle(18),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                  ),
                ),
                trailing: OutlineButton(
                  onPressed: () => addComment(),
                  borderSide: BorderSide.none,
                  child: Text(
                    "Publish",
                    style: myStyle(16),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}