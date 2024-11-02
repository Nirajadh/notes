import 'package:cloud_firestore/cloud_firestore.dart';

addnote( String text) async{
await FirebaseFirestore.instance.collection('notes').add({'note': text ,
'timestamp':Timestamp.now(),


},);
}


 Stream<QuerySnapshot> getnote(){
return FirebaseFirestore.instance.collection('notes').orderBy('timestamp',descending: true).snapshots();

}


updatenote(String docid , String newnote) async{
await FirebaseFirestore.instance.collection('notes').doc(docid).update({'note':newnote , 'timestamp':Timestamp.now()} );

}

deletenote(String docid) async{
 await FirebaseFirestore.instance.collection('notes').doc(docid).delete();
}