import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:todo_app/pages/signin_page.dart';
import 'package:todo_app/services/auth_service.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  firebase_auth.FirebaseAuth auth = firebase_auth.FirebaseAuth.instance;
  AuthClass authClass = AuthClass();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(onPressed: (){
              authClass.logOut();
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (builder)=>const SignInPage()), (route) => false);
              }, icon: const Icon(Icons.logout))
          ],
        ),
      ),
    );
  }
}
