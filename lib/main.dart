import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:notes/firebase_options.dart';
import 'package:notes/homepage.dart';

void main() async{
WidgetsFlutterBinding.ensureInitialized();

await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
 
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
// FirebaseFirestore.instance.collection('notes').add({'note':'hello world'});

    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
       home: const Homepage()
    );
  }
}
