//hero?

// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class CoursePage extends StatefulWidget {
  const CoursePage({ Key? key }) : super(key: key);

  @override
  State<CoursePage> createState() => _CursePageState();
}

class _CursePageState extends State<CoursePage> {
  late String chosenImg ; // late bch yfasarha wa9t li ynazel  wtitle hedhy nizid nektebha taht img arguents
  late String chosentitle ;
  
  @override
  Widget build(BuildContext context) {
    final Map  arguments = ModalRoute.of(context)?.settings.arguments as Map ; //ZEDT L ?
    chosenImg = arguments ['img']; //bch t3oud taswira tetbadel ki nodkhel lel cours
    chosentitle = arguments ['title']; // bch titre yetbadel zeda 
    return Scaffold(
      appBar: AppBar(// l appbar 3ajbetni
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Color(0x00000ffe),
       ),
       child: IconButton(onPressed: (){
         Navigator.pop(context);},
         icon:Icon(Icons.arrow_back_ios),
         color: Color(0xff2657ce),
          ),
          ),
         // SizedBox(width: 10,),
         // IconButton(onPressed: (){}, icon: Icon(CupertinoIcons.plus_app,size: 30, , color: Color(0xffff5954),))
        ),
        body:Container (
          padding:EdgeInsets.all(20),
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('$chosentitle',style: TextStyle(// kol manodkhel l cour yetbadel titre w taswira ta3 page
                color: Color(0xff2657ce),
                fontSize: 20,
              ),),
                Text('Ahlém Boughalmi',style: TextStyle(
                color: Colors.black.withOpacity(0.6),
                fontSize: 20,
              ),
            ),
           SizedBox(height: 20,),
           Container(//hedha l container lahmer ta3 taswira 
             padding: EdgeInsets.all(20),
             decoration: BoxDecoration(
               borderRadius: BorderRadius.all(Radius.circular(30)),
               color: Color(0xffff5954)
             ),
             child: Hero(tag: '$chosenImg', //BCH KOL MARRA TETBADEL TASWIRA
             child: Container(
                     height: 200,
                     width: MediaQuery.of(context).size.width,
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.all(Radius.circular(30)),
                       image:DecorationImage(
                          image: AssetImage('assets/images/$chosenImg.png')),//BCH TASWIRA KOL MARRA T3AYET SELON L HAJA LI KTEBTHA 
                     ),//dollar dima $ bch y3ayetli 3al varible li 3amaltou bch nbadlou kima nheb ena
             ),
             ),
           ),
        SizedBox(height: 20,),//tawa bch nekdhou les cours kifeh bch yjiw
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Course',style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w600
            ),),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 2),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: Color(0xffd3defa)
              ),
              child:Row(
                children: [
                  Container(
                    width: 35,
                    child: IconButton( onPressed: (){},
                        icon: Icon(Icons.timer,color: Colors.blue,),
                     ),
                     ),
                    Text('3 Hourse, 20 Min',style: TextStyle(
                color: Colors.black.withOpacity(0.7),
                fontSize: 20,
                ),),
               ],
               ),
               ),
              ],
            ),
            SizedBox(height: 10,),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [//hedhom l cour najem nbadel asamihom chnowa ena nheb nhot 
                    productListing("Introduction","Introduction of the course","active"),
                    productListing("Language of Color","learn about the longauge of...","inactive"),
                    productListing("Psychologie of color","learn about the Psychologie ","inactive"),
                    productListing("Introduction","Introduction of the course","active"),
                    productListing("Introduction","Introduction of the course","active"),
                    productListing("Introduction","Introduction of the course","active"),
                    productListing("Introduction","Introduction of the course","active"),
                    productListing("Introduction","Introduction of the course","active"),
                    productListing("Introduction","Introduction of the course","active"),
                    productListing("Introduction","Introduction of the course","active"),
                  ],
                ),
              )
            )
           ],
          )
        )
      );
  }
Column productListing(String title , String info, String activeOrInactive)//l cour l wehd fihom hedhom n3aytelhom louta bel kol mba3ed nbadel chnowa nheb 
{//$ b dolar n3ayetelhom bih
  return Column(
    children: [
       SizedBox(height: 10,),
         Row(children: [
           Container(//hedhy ta3 lvideo w zina mte3ha
             width: 50,
             height: 50,
              decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(17)),
            color:(activeOrInactive == 'active') ? Color(0xff2657ce) : Color(0xffd3defa),//wki tabda l 3ax bidha
            //ki tabda active l backg round zar9a gham9a
       ),
       child: IconButton(icon: Icon(Icons.play_arrow ,
       color: (activeOrInactive == 'active') ? Colors.white : Color(0xff2657ce),),//w icon zda nafes l condition 
       onPressed: (){},
        ),
     ),
SizedBox(width: 15,),
Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text('$title',style: TextStyle(fontSize: 20),),
   Text('$info',style: TextStyle(fontSize: 18, color: Colors.grey),),
  ],
   ),
 SizedBox(width: 10,),
IconButton(onPressed: (){}, icon: Icon(CupertinoIcons.arrow_down_to_line_alt , color: Color(0xffff5954),))
     ],
     ),
     Center(
       child: Container(
         margin: EdgeInsets.symmetric(vertical:10),//bch yeb3ou les 3la b3adhom
         width: MediaQuery.of(context).size.width*0.85,
         height: 0.5,
          color: Colors.grey,
       ),
       ),
       SizedBox(height: 10,),
     ],
   );
}

}