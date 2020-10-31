import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/functions/addComment.dart';
import 'package:flutter_app/pages/comment.dart';
import 'package:flutter_app/pages/profile.dart';
import 'package:flutter_app/utils/variables.dart';

class DiscussPage extends StatefulWidget {
  @override
  _DiscussPageState createState() => _DiscussPageState();
}

class _DiscussPageState extends State<DiscussPage> {

  String uid;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUserUid();
  }

  getCurrentUserUid() async {
    var firebaseUser =FirebaseAuth.instance.currentUser;
    setState(() {
      uid = firebaseUser.uid;
    });

  }

sharePost(String documentId, String comment) async {
    Share.text("Query", comment , 'text/plain');
    DocumentSnapshot doc = await commentCollection.doc(documentId).get();
    commentCollection.doc(documentId).update({'shares': doc.data()['shares'] +1});
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>AddComment())),
            child: Icon(Icons.add,size: 32),),

        appBar:

        AppBar(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            backgroundColor: Color.fromRGBO(0, 109, 119, 0.8),
            centerTitle: true,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Discuss',
                style: myStyle(24,Colors.white,FontWeight.bold),),
                SizedBox(width: 5.0,),
                Image(width: 45,height: 54,image: AssetImage('images/logo.png'),),
              ],
            ),
          ),



      body:  StreamBuilder(
            stream: commentCollection.snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
              return CircularProgressIndicator();
              }
              return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (BuildContext context, int index) {
                DocumentSnapshot commentDoc = snapshot.data.documents[index];
                return Card(
                    shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.white70, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                    color: Color.fromRGBO(131, 197, 190, 0.8),
                    borderOnForeground: true,
                      child: ListTile(
                         leading: CircleAvatar(
                        minRadius: 20.0,
                        maxRadius: 30.0,
                        backgroundColor: Colors.white,
                        backgroundImage: NetworkImage(commentDoc['profilePic']),
                   ),
             
                          title: Text(commentDoc['username'],
                          style: myStyle(20,Colors.black,FontWeight.w600),),

                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (commentDoc.data()['type'] == 1)
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        commentDoc.data()['comment'],
                                        style: myStyle(
                                            20, Colors.black, FontWeight.w400),
                                      ),
                                  ),
                              if (commentDoc.data()['type'] == 2)
                                Image(image: NetworkImage(commentDoc['image'])),
                              if (commentDoc.data()['type'] == 3)
                                Column(
                                  children: [
                                    Text(
                                      commentDoc.data()['comment'],
                                      style: myStyle(
                                          20, Colors.black, FontWeight.w400),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Image(
                                        image: NetworkImage(
                                            commentDoc.data()['image'])),
                                  ],
                                ),

                               SizedBox(height: 10,),

                               Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                   SizedBox(width: 30,),
                                   Row(
                                     children: [
                                        InkWell(
                                          onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>CommentPage(commentDoc['id']))),
                                            child: Icon(Icons.comment)),
                                        SizedBox(width: 10,),
                                        Text(commentDoc['commentCount'].toString(),style: myStyle(18),),
                                     ],
                                   ),
                                   SizedBox(width: 30,),
                                   Row(
                                     children: [
                                       InkWell(
                                         onTap: ()=>sharePost(commentDoc.data()['id'], commentDoc.data()['comment']),
                                           child: Icon(Icons.share)),
                                       SizedBox(width: 10,),
                                       Text(commentDoc['shares'].toString(),style: myStyle(18),),
                                     ],
                                   ),
                                   SizedBox(width: 20,),

                                 ],
                       )
                     ],
                   ),
                 ),
                );
              }
            );
            })
            );
        }
      }
