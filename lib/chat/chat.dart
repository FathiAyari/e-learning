import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import: lcloud fire store bch yjouni, l lmesget li sajelthom f fire 

class chat extends StatefulWidget {
  const chat({ Key? key }) : super(key: key);

  @override
  State<chat> createState() => _chatState();
}

class _chatState extends State<chat> {
 

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffff5954),
        title: Row(
          children: [
            Image.asset(''),
            SizedBox(width: 10,),
            Text("Messageme"),
           ],
        ),
        actions: [
          IconButton(onPressed: (){
         
          }, icon: Icon(Icons.close),)
        ],
      ),
      body:SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            
            Container(),
            Container(
              decoration: BoxDecoration(
                border: Border(
               top: BorderSide(
                 color: Color(0xffff5954),
                 width: 2,
                 ),
               )
              ),
         child: Row(
           crossAxisAlignment: CrossAxisAlignment.center,
           children: [
             Expanded(
               child: TextField(
                 onChanged: (value){
                 //  messageText = value ;
                 },
                 decoration: InputDecoration(
                   contentPadding: EdgeInsets.symmetric(
                     vertical: 10,
                     horizontal: 20,
                   ),
                   hintText: "write your message here.....",
                   border: InputBorder.none,
                 ),
                 ),
             ),
            IconButton(onPressed: (){
              //bch n3ayet lel instance firestore
              //_firestore.Collections("esm lcolection f firebase li samitou").add({
              // nhot l key li f firestore houma zouz text w email
              // 'Text':messageText hedhy heya champ f fire w ba3ed l variable messageText li bch yji fyh l mssg})
            // 'sender': signedInUser.Email //ya3ni bch yekhou menou ken email 
            //bch n3ayet lel methode messageStreamscd
            }, 
            icon:Icon(CupertinoIcons.paperplane, color:Color(0xffff5954)) ),
           ],
         ),
            ),
          ],
          ),
      ),
    );
  }
}