
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({ Key? key }) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: SafeArea(
        child:SingleChildScrollView(
           child:Column(
             children:<Widget> [
               SizedBox(height: 30,),
                 Row( 
             mainAxisAlignment: MainAxisAlignment.start,
             children: [
               SizedBox(height: 30,width: 10,),
             
                 Text("Notifications",textAlign: TextAlign.center, style:TextStyle
                  (color:Color(0xff2657ce),fontSize: 18,fontWeight: FontWeight.bold, ) ),
             ],
           ),
               SizedBox(height: 5,),
                Row(
                  children:  <Widget>[
                    SizedBox(width: 15,),
                    Text("Plus tot", style:TextStyle
                  (color:Colors.black54,fontSize: 16,fontWeight: FontWeight.bold, ))
                ],),
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage("assets/images/profile.png"),
                ),
                title: Text("flen a commenter à votre publication"),
                trailing: Icon(Icons.menu),
                ),
                  ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage("assets/images/profile.png"),
                ),
                title: Text("flen a partager à votre publication"),
                trailing: Icon(Icons.menu),
                ),
                  ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage("assets/images/prof4.png"),
                ),
                title: Text("flen a réagi à votre commentaire"),
                trailing: Icon(Icons.menu),
                ),
                 ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage("assets/images/prof3.png"),
                ),
                title: Text("flen a réagi à votre publication"),
                trailing: Icon(Icons.menu),
                ),
                 ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage("assets/images/prof3.png"),
                ),
                title: Text("flen a réagi à votre publication"),
                trailing: Icon(Icons.menu),
                ),
                 ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage("assets/images/prof2.png"),
                ),
                title: Text("flen a réagi à votre publication"),
                trailing: Icon(Icons.menu),
                ),
                 ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage("assets/images/prof1.png"),
                ),
                title: Text("flen a réagi à votre publication"),
                trailing: Icon(Icons.menu),
                ),
               ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage("assets/images/prof3.png"),
                ),
                title: Text("flen a réagi à votre publication"),
                trailing: Icon(Icons.menu),
                ),
               ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage("assets/images/prof4.png"),
                ),
                title: Text("flen a réagi à votre publication"),
                trailing: Icon(Icons.menu),
                ),
                 ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage("assets/images/profile.png"),
                ),
                title: Text("flen a réagi à votre publication"),
                trailing: Icon(Icons.menu),
                ),
                 ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage("assets/images/profile.png"),
                ),
                title: Text("flen a réagi à votre publication"),
                trailing: Icon(Icons.menu),
                ),
                 ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage("assets/images/prof2.png"),
                ),
                title: Text("flen a réagi à votre publication"),
                trailing: Icon(Icons.menu),
                ),
                 ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage("assets/images/prof1.png"),
                ),
                title: Text("flen a réagi à votre publication"),
                trailing: Icon(Icons.menu),
                ),
                 ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage("assets/images/prof3.png"),
                ),
                title: Text("flen a réagi à votre publication"),
                trailing: Icon(Icons.menu),
                ),
                 ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage("assets/images/prof2.png"),
                ),
                title: Text("flen a réagi à votre publication"),
                trailing: Icon(Icons.menu),
                ),
                  ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage("assets/images/profile.png"),
                ),
                title: Text("flen a réagi à votre publication"),
                trailing: Icon(Icons.menu),
                ),
                  ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage("assets/images/profile.png"),
                ),
                title: Text("flen a réagi à votre publication"),
                trailing: Icon(Icons.menu),
                ),
                  ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage("assets/images/prof3.png"),
                ),
                title: Text("flen a réagi à votre publication"),
                trailing: Icon(Icons.menu),
                ),
             ],
           ),
       ),
       ),
    );
  }
}