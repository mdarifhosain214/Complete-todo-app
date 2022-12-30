import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_app/pages/home_page.dart';
import 'package:todo_app/pages/phone_sign_in_ui_page.dart';
import 'package:todo_app/pages/signin_page.dart';
import 'package:todo_app/services/auth_service.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  firebase_auth.FirebaseAuth auth = firebase_auth.FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool circular =false;
  AuthClass authClass =AuthClass();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Sign up',
                style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(
                height: 20,
              ),
              buttonItem(
                  imagePath: 'images/google.svg',
                  buttonName: 'Continue with google',
                  size: 25,onTap: ()async{
                   await authClass.googleSignIn(context);
              }),
              const SizedBox(
                height: 20,
              ),
              buttonItem(
                  imagePath: 'images/phone.svg',
                  buttonName: 'Continue with phone',
                  size: 30,onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (builder)=>PhoneAuthPage()));
              }),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Or',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              const SizedBox(
                height: 20,
              ),
              textItem(
                  labelText: 'Enter your email',
                  controller: _emailController,
                  obscure: false),
              const SizedBox(
                height: 20,
              ),
              textItem(
                  labelText: 'Enter password',
                  controller: _passwordController,
                  obscure: true),
              const SizedBox(
                height: 40,
              ),
              colorButton(),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [
                  const Text(
                    'Already have an account?',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (builder)=>const SignInPage()), (route) => false);
                    },
                    child: const Text(
                      ' Sign in',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget colorButton() {
    return InkWell(
      //.....................................................
      //......Firebase Login with UserEmailAnd Password......
      //.....................................................
      onTap: () async {
        setState((){circular=true;});
        try{
          firebase_auth.UserCredential userCredential =
          await auth.createUserWithEmailAndPassword(
              email: _emailController.text,
              password: _passwordController.text);
          setState((){circular=false;});
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (builder)=>const HomePage()), (route) => false);
          //print(userCredential.user?.email);
        }catch(error){
          setState((){circular=false;});
          final snackBar =SnackBar(content: Text(error.toString(),style: const TextStyle(fontSize: 17),));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      //....................................................
      //....................................................
      child: Container(
        width: MediaQuery.of(context).size.width - 90,
        height: 60,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: const LinearGradient(colors: [
              Color(0xfffd746c),
              Color(0xffff9068),
              Color(0xfffd746c)
            ])),
        child:  Center(
          child: circular? const CircularProgressIndicator():const Text(
            'Sign up',
            style: TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget buttonItem(
      {required String imagePath,
      required String buttonName,
      required double size,required Function() onTap}) {
    return InkWell(
      onTap:onTap ,
      child: Container(
        margin: const EdgeInsets.all(0),
        width: MediaQuery.of(context).size.width - 60,
        height: 60,
        child: Card(
          color: Colors.black,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: const BorderSide(width: 1, color: Colors.grey)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                imagePath,
                width: size,
                height: size,
              ),
              const SizedBox(
                width: 15,
              ),
              Text(
                buttonName,
                style: const TextStyle(color: Colors.white, fontSize: 17),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget textItem(
      {required String labelText,
      required TextEditingController controller,
      required bool obscure}) {
    return Container(
      margin: const EdgeInsets.all(0),
      width: MediaQuery.of(context).size.width - 70,
      height: 55,
      child: TextFormField(
        obscureText: obscure,
        controller: controller,
        style: const TextStyle(color: Colors.white, fontSize: 17),
        decoration: InputDecoration(
            labelText: labelText,
            labelStyle: const TextStyle(fontSize: 17, color: Colors.white),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(width: 1, color: Colors.grey)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(width: 1, color: Colors.orange))),
      ),
    );
  }
}
