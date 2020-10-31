import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/pages/comment.dart';
import 'package:flutter_app/utils/variables.dart';
import 'package:intl/intl.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  String profilePic;
  String uid;
  Stream userStream;
  String username;

  bool dataIsThere = false;


  sharePost(String documentId, String comment) async {
    Share.text("Query", comment , 'text/plain');
    DocumentSnapshot doc = await commentCollection.doc(documentId).get();
    commentCollection.doc(documentId).update({'shares': doc.data()['shares'] +1});
  }



  initState(){
  super.initState();
  getCurrentUserInfo();
  getStream();
  getCurrentUserUid();
  }

  getStream() async {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    setState(() {
      userStream =
          commentCollection.where('uid', isEqualTo: firebaseUser.uid).snapshots();
    });
  }

  getCurrentUserUid() async {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    setState(() {
      uid = firebaseUser.uid;
    });
  }


  getCurrentUserInfo() async {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    DocumentSnapshot userDoc = await usercollection.doc(firebaseUser.uid).get();
    usercollection
        .doc(firebaseUser.uid)
        .get()
        .then((doc) {
    });

    setState(() {
      username = userDoc.data()['username'];
      profilePic = userDoc.data()['profilePic'];
      dataIsThere = true;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:dataIsThere ==true ?
      SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 4,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.lightBlue, Colors.purple]),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 6,
                  left: MediaQuery.of(context).size.width / 2 - 64),
              child: CircleAvatar(
                radius: 64,
                backgroundColor: Colors.white,
                backgroundImage: NetworkImage(profilePic),
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 2.7),
              child: Column(
                children: [
                  Text(
                    username,
                    style: myStyle(30, Colors.black, FontWeight.w600),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                              colors: [Colors.blue, Colors.lightBlue])),
                      child: Center(
                        child: Text(
                          "Edit Profile",
                          style: myStyle(
                              25, Colors.white, FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "User Comments",
                    style: myStyle(25, Colors.black, FontWeight.w700),
                  ),
                  StreamBuilder(
                      stream: userStream,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return CircularProgressIndicator();
                        }
                        return ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data.docs.length,
                            itemBuilder:
                                (BuildContext context, int index) {
                              DocumentSnapshot commentDoc =
                              snapshot.data.docs[index];
                              return Card(
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    backgroundImage: NetworkImage(
                                        commentDoc.data()['profilePic']),
                                  ),
                                  title: Text(
                                    commentDoc.data()['username'],
                                    style: myStyle(20, Colors.black,
                                        FontWeight.w600),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      if (commentDoc.data()['type'] == 1)
                                        Padding(
                                          padding:
                                          const EdgeInsets.all(8.0),
                                          child: Text(
                                            commentDoc.data()['comment'],
                                            style: myStyle(
                                                20,
                                                Colors.black,
                                                FontWeight.w400),
                                          ),
                                        ),
                                      if (commentDoc.data()['type'] == 2)
                                        Image(
                                            image: NetworkImage(
                                                commentDoc['image'])),
                                      if (commentDoc.data()['type'] == 3)
                                        Column(
                                          children: [
                                            Text(
                                              commentDoc.data()['comment'],
                                              style: myStyle(
                                                  20,
                                                  Colors.black,
                                                  FontWeight.w400),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Image(
                                                image: NetworkImage(
                                                    commentDoc.data()[
                                                    'image'])),
                                          ],
                                        ),
                                      SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              InkWell(
                                                onTap: () => Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            CommentPage(
                                                                commentDoc
                                                                    .data()['id']))),
                                                child:
                                                Icon(Icons.comment),
                                              ),
                                              SizedBox(
                                                width: 10.0,
                                              ),
                                              Text(
                                                commentDoc
                                                    .data()[
                                                'commentCount']
                                                    .toString(),
                                                style: myStyle(18),
                                              ),
                                            ],
                                          ),

                                          Row(
                                            children: [
                                              InkWell(
                                                onTap: () => sharePost(
                                                    commentDoc
                                                        .data()['id'],
                                                    commentDoc.data()[
                                                    'comment']),
                                                child:
                                                Icon(Icons.share),
                                              ),
                                              SizedBox(
                                                width: 10.0,
                                              ),
                                              Text(
                                                commentDoc
                                                    .data()['shares']
                                                    .toString(),
                                                style: myStyle(18),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            });
                      })
                ],
              ),
            )
          ],
        ),
      )
          : Center(child: CircularProgressIndicator()));
  }
}