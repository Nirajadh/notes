import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notes/firebase_functions.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final TextEditingController textcontroller = TextEditingController();

  void inputnote({String? docid}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: TextField(
              controller: textcontroller,
            ),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    if (docid == null) {
                      addnote(textcontroller.text);
                    } else {
                      updatenote(docid, textcontroller.text);
                    }

                    textcontroller.clear();
                    Navigator.pop(context);
                  },
                  child: const Text('Add'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('notes')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          inputnote();
        },
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder(
          stream: getnote(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List noteslist = snapshot.data!.docs;

              return ListView.builder(
                  itemCount: noteslist.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot document = noteslist[index];
                    String docId = document.id;
                    Map<String, dynamic> data =
                        document.data() as Map<String, dynamic>;
                    return ListTile(
                    
                     shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                     ),
                     contentPadding: EdgeInsets.all(5),
                      title: Text(data['note']),
                      trailing: 
                      Row(
                         mainAxisSize: MainAxisSize.min,
                                             
                        children: [
                          IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                inputnote(docid: docId);
                              }),
                          IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                               deletenote(docId);
                              }),
                        ],
                      ),
                    );
                  });
            } else {
              return const Text('no notes');
            }
          }),
    );
  }
}
