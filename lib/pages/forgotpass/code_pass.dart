
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../auth/welcome.dart';
import 'forgot_password.dart';

class CodePass extends StatelessWidget {
  const CodePass({Key? key}) : super(key: key);

  void onFinish(res, code) {
    print(code);
    print(res);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: SafeArea(child:
       Column(children: [
           Row( 
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                onPressed: (){
                  Navigator.pop(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => ForgotPass()));
                  },
                icon: const Icon(CupertinoIcons.arrow_left),), 
                SizedBox(width:8 ,),
                Text("Retour" ,style:TextStyle(color:Color(0xFF8B8B8B),fontSize: 18)),
            ],
          ),
     const  SizedBox(height: 16,),
            SizedBox(
              width: double.infinity,
              child: Column(
                children:const  [
                   Text("Vérification",
                    style: TextStyle(color:Color(0xff2657ce),
                    fontSize: 28,
                    fontWeight: FontWeight.bold)),
                  Text("Saisire le code envoyer sur votre email",
                  textAlign: TextAlign.center,),
             ],
          ),
         ),
         SizedBox(height: 15,),
        OtpWidget(onFinish),
               const SizedBox(height: 15),
                 Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 16),
                 child: Row(
                   children: [
                    Expanded(
                     child: CupertinoButton(
                      borderRadius: const BorderRadius.all(Radius.circular(60)),
                      color:  Color(0xffff5954),
                      onPressed: (() {
                    
                      // Navigator.pop(
                       //  context,
                       //  CupertinoPageRoute(
                       //  builder: (context) =>  CodePass(onSuccess: )));
                      
                      }),
                   child: const Text('Vérifier', 
                   style: TextStyle(color: Colors.white)))),
                    ],
                 ),
               ),
               SizedBox(height:18),
               Text("Vous n'avez pas reçu de code ?" , 
               style: TextStyle(
                 fontSize: 14, fontWeight: FontWeight.bold,color: Colors.black38
               ),),
             const  SizedBox(height: 18,),
               TextButton(onPressed: (){
                             Navigator.pushReplacement(
                              context,
                                CupertinoPageRoute(
                                   builder: (context) => WelcomeScreen()));}, 
                           child: const Text("Renvoyer le nouveau code", 
                           style: TextStyle(
                             fontSize: 18,
                             fontWeight: FontWeight.bold,
               color: Color(0xff2657ce)),))],
          ),
       ),
    );
  }
}

class OtpWidget extends StatefulWidget {
  final Function onSuccess;

  OtpWidget(this.onSuccess);

  @override
  _OtpWidgetState createState() => _OtpWidgetState();
}

class _OtpWidgetState extends State<OtpWidget> {
  final code = {
    'first': null,
    'second': null,
    'third': null,
    'fourth': null,
  };

  bool checkResult() {
    return code['first'] != null &&
           code['second'] != null &&
           code['third'] != null &&
            code['fourth'] != null;
  }

  void firstVal(value) {
    setState(() {
      code['first'] = value;
    });
    print(code);
    widget.onSuccess(checkResult(), code);
  }

  void secondVal(value) {
    setState(() {
      code['second'] = value;
    });
    print(code);
    widget.onSuccess(checkResult(), code);
  }

  void thirdVal(value) {
    setState(() {
      code['third'] = value;
    });
    print(code);
    widget.onSuccess(checkResult(), code);
  }

  void fourthVal(value) {
    setState(() {
      code['fourth'] = value;
    });
    print(code);
    widget.onSuccess(checkResult(), code);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child:    Container(
          padding: EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius:BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OtpTextField(first: true, last: false, onChange: firstVal),
                  OtpTextField(first: false, last: false, onChange: secondVal),
                  OtpTextField(first: false, last: false, onChange: thirdVal),
                  OtpTextField(first: false, last: true, onChange: fourthVal),
                ],
              ),
            ],
          ),
        ),
     );
  }
}

class OtpTextField extends StatelessWidget {
  final bool first;
  final bool last;
  final Function onChange;
  const OtpTextField(
      { Key? key, required this.first, required this.last, required this.onChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85,
      
      child: AspectRatio(
        aspectRatio: 0.7,
        child: TextField(
          autofocus: true,
          onChanged: (value) {
            onChange(value);
            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
            }
            if (value.isEmpty && first == false) {
              FocusScope.of(context).previousFocus();
            }
          },
          showCursor: true,
          readOnly: false,
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            counter: Offstage(),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(width: 2, color: Colors.black12), 
              ),
              focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(width: 2, color: Colors.black12), 
              ),
          ),
        ),
      ),
    );
  }
}