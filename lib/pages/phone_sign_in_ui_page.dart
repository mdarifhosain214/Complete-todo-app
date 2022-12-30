import 'dart:async';

import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';

class PhoneAuthPage extends StatefulWidget {
  const PhoneAuthPage({Key? key}) : super(key: key);

  @override
  State<PhoneAuthPage> createState() => _PhoneAuthPageState();
}

class _PhoneAuthPageState extends State<PhoneAuthPage> {
  double start =30;
  bool wait =false;
  String buttonName ="Send";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        centerTitle: true,
        title: const Text(
          'SignUp',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(0),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 140,
              ),
              textField(),
              const SizedBox(
                height: 30,
              ),
              Container(
                margin: EdgeInsets.zero,
                width: MediaQuery.of(context).size.width - 34,
                child: Row(
                  children: [
                    Expanded(
                        child: Container(
                      height: 2,
                      color: Colors.grey,
                    )),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'Enter 6 digit OTP',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18),
                      ),
                    ),
                    Expanded(
                        child: Container(
                      height: 2,
                      color: Colors.grey,
                    )),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              otpText(),
              const SizedBox(
                height: 40,
              ),
              RichText(text: TextSpan(
                text: 'Send OTP again ',style: const TextStyle(fontSize: 18, color: Colors.yellowAccent),
                children: [
                  TextSpan(
                    text: '00:$start ',style: const TextStyle(fontSize: 18, color: Colors.pink),
                  ),
                  const TextSpan(
                    text: 'sec',style: TextStyle(fontSize: 18, color: Colors.yellowAccent),
                  )

                ]
              )),
              SizedBox(height: 120,),
              Container(
                width: MediaQuery.of(context).size.width-60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color(0xffff9601)
                ),
                child: const Center(
                  child: Text(
                    'Submit',style: TextStyle(fontSize: 28, color: Colors.white,fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget otpText() {
    return OTPTextField(
      length: 6,
      width: MediaQuery.of(context).size.width - 30,
      fieldWidth: MediaQuery.of(context).size.width / 8,
      style: const TextStyle(fontSize: 18, color: Colors.white),
      otpFieldStyle: OtpFieldStyle(
          backgroundColor: const Color(0xff1d1d1d), borderColor: Colors.white),
      textFieldAlignment: MainAxisAlignment.spaceAround,
      fieldStyle: FieldStyle.underline,
      onCompleted: (pin) {
        print("Completed: " + pin);
      },
    );
  }
  void startTimer(){
    const sec = Duration(seconds: 1);
    Timer timer = Timer.periodic(sec, (timer) {
      if(start==0){
        timer.cancel();
        setState((){
          wait =false;
        });
      }
      else{
        setState((){
          start--;
        });
      }

    });
  }

  Widget textField() {
    return Container(
      width: MediaQuery.of(context).size.width - 40,
      height: 60,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: const Color(0xff1d1d1d)),
      child: TextFormField(
        style: const TextStyle(color: Colors.white, fontSize: 17),
        decoration:  InputDecoration(
            border: InputBorder.none,
            hintText: "Enter Phone number",
            contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
            hintStyle: const TextStyle(color: Colors.white, fontSize: 19),
            prefixIcon: const Padding(
              padding: EdgeInsets.symmetric(vertical: 14, horizontal: 15),
              child: Text(
                '+880',
                style: TextStyle(color: Colors.white, fontSize: 19),
              ),
            ),
            suffixIcon: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: InkWell(
                onTap:wait?null: (){
                  startTimer();
                  setState((){
                    buttonName= "Resend";
                    wait =true;
                    start=30;
                  });
                },
                child:wait?Text(
                  buttonName,
                  style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 19,
                      fontWeight: FontWeight.bold),
                ):  Text(
                 buttonName,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )),
      ),
    );
  }
}
