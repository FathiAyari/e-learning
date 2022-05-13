import 'package:flutter/material.dart';

class Course  extends StatefulWidget {
  const  Course ({ Key? key }) : super(key: key);

  @override
  State<Course> createState() => _CourseState();

}

class _CourseState extends State<Course> {

  void openCoursePage(String img , String title ) //title zedtha bch ywali yetbadel l titre ta3 kol cour w pages mte3ou wahdhha 
{
  Navigator.pushNamed(context, '/coursePage' , arguments: {'img' : '$img'  , 'title' :'$title'});
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff4f6fd),
       body:Container(
        padding: EdgeInsets.only(top: 40,left: 30,right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //3malt row fiha text w taswira mte3i
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Hello Developers',style: TextStyle(color:Colors.blueAccent,fontSize:20,
                    ),),
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image:DecorationImage(
                        image: AssetImage("assets/images/profile.png"),),
                  ),
                ),
              ],
             ),
             SizedBox(height:25),
             Text("What do you \nwant to \nlearn today ?",style: TextStyle(color:Colors.black,fontSize: 35,//slash yhabet lektiba louta
                    fontWeight: FontWeight.w700,height:1.3,
                    ),),
                    SizedBox(height:10),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Row(
                          mainAxisAlignment:MainAxisAlignment.spaceBetween,
                          children:[
                            Container(
                              width: MediaQuery.of(context).size.width*0.4,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  courseWidget('php','','img1',Color(0xffff6a65),Color(0xffff5954)),
                                  SizedBox(height: 20,),
                                  courseWidget('Social Media','Social Media Monitoring','img2',Color(0xffe9eefa),Colors.white),
                                ],
                              ),
                            ),
                            Container(width: MediaQuery.of(context).size.width*0.4,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(height: 50,),
                                  courseWidget('Programming','Python for everybody','img3',Color(0xffe9eefa),Colors.white),
                                  SizedBox(height: 20,),
                                  courseWidget('Graphique Design','Fundamentals of Design','img4',Color(0xffbdcddfa),Colors.blueAccent),
                              ],
                            ),
                            ),
                          ],
                        )
                        ),
                      ),
                     ]),
                    ) ,
                   );
                   }
  Container  courseWidget(String category , String title,String img, Color categoryColor,Color bgColor)
  {
return Container(
    padding: EdgeInsets.only(top: 20,left: 20,right: 20,bottom: 10),
    decoration: BoxDecoration(
      color:bgColor,
      borderRadius:BorderRadius.all(Radius.circular(30))
    ),
    child: InkWell(
      onTap: (){openCoursePage('$img', '$title');},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: categoryColor,//lideclarytha string
            borderRadius: BorderRadius.all(Radius.circular(20))
            ),
            child: Text("$category",style: TextStyle(
              color: (categoryColor == Color(0xffe9eefa) ? Color(0xff2657ce) : Colors.white)//lwhite loun lektiba
              ),
              ),
          ),
          SizedBox(height: 10,),
          Text("$title",style:TextStyle(
            color: (bgColor == Color(0xffff5954)) ? Colors.white :Colors.black,//? YA3NI RETURN ... W : YA3NI ELSE RETEURN...
            fontSize: 20,
            height: 1,
          )),
          SizedBox(height: 10,),
          Row(
            children: [
              Container(
                height: 5,
                width: 100,
                color: (bgColor == Color(0xffff5954)) ? Colors.red : Color(0xff2657ce)
              ),
              Expanded(
                child: Container(
                  height: 5,
                  color: (bgColor == Color(0xffff5954)) ? Colors.white.withOpacity(0.5) : Color(0xff2657ce).withOpacity(0.5),
                  ),
              ),
            ],
            ),
           SizedBox(height: 10,),
           Hero(tag: '$img',//bch jou tsawer
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/$img.png'),
                  ),
                ),
             ),
            ),
         ],
        ),
      ),
    );
  }


}