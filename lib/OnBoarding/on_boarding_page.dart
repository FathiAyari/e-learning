import 'package:ahlem/pages/auth/signin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../services/remember_controller.dart';
import '../utils/constant.dart';
import 'on_boarding_content.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

PageController _controller = PageController();
int currentPage = 0;
List<Content> contentList = [
  Content(
    img: 'assets/images/1.json',
    description:
        'êtes-vous intéressé par le camping en Tunisie? \n Campino est le mailleure solution pour vous .',
    title: 'Bienvenue chez Educo ',
  ),
  Content(
    img: 'assets/images/2.json',
    description:
        'Nous vous proposons un guide et  un espace de partge de vous experience en camping ',
    title: '',
  ),
  Content(
    img: 'assets/images/3.json',
    description:
        'Avec Campino vous êtes libre de vendre et acheter des equipement de camping en ligne',
    title: '',
  )
];
RememberController onBoardingController = RememberController();

class _OnBoardingPageState extends State<OnBoardingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomCenter,
              colors: [
                Colors.indigo,
                Colors.blueGrey,
              ]),
        ),
        child: Stack(
          children: [
            PageView.builder(
                onPageChanged: (index) {
                  setState(() {
                    currentPage = index;
                  });
                },
                itemCount: contentList.length,
                scrollDirection: Axis.horizontal, // the axis
                controller: _controller,
                itemBuilder: (context, int index) {
                  return contentList[index];
                }),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(contentList.length, (int index) {
                    return AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      height: Constants.screenHeight * 0.01,
                      width: (index == currentPage)
                          ? Constants.screenWidth * 0.08
                          : Constants.screenWidth *
                              0.04, // condition au lieu de if else
                      margin: EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: Constants.screenHeight * 0.1),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: (index == currentPage)
                              ? Colors.white
                              : Colors.blue.withOpacity(0.8)),
                    );
                  }),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Constants.screenWidth * 0.07, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: InkWell(
                            onTap: () {
                              onBoardingController.check();
                              Get.to(LoginScreen());
                            },
                            child: Text(
                              "Ignorer",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 45,
                          child: ElevatedButton(
                              onPressed: (currentPage == contentList.length - 1)
                                  ? () {
                                      Get.to(LoginScreen());
                                    }
                                  : () {
                                      onBoardingController.check();
                                      _controller.nextPage(
                                          duration: Duration(milliseconds: 400),
                                          curve: Curves.easeInOutQuint);
                                    },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                primary: Colors.blueAccent,
                              ),
                              child: (currentPage == contentList.length - 1)
                                  ? Text("Commencer")
                                  : Text('Suivant')),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
