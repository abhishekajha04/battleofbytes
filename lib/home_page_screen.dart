import 'package:battle_of_bytes_aution/common_widget.dart';
import 'package:battle_of_bytes_aution/teacher_login_dashboard.dart';
import 'package:battle_of_bytes_aution/teacher_register_page.dart';
import 'package:battle_of_bytes_aution/total_players.dart';
import 'package:battle_of_bytes_aution/total_teams.dart';
import 'package:battle_of_bytes_aution/utils.dart';
import 'package:battle_of_bytes_aution/visitor_login.dart';
import 'package:battle_of_bytes_aution/visitors_registration_screen.dart';
import 'package:flutter/material.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return HomePageScreenState();
  }
}

class HomePageScreenState extends State<HomePageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: hexToColor('#EAF2F4'),
      body: SafeArea(
        child: Column(
          children: [
            topMenuBar(context),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    homePageBanner(),
                    investmentWidget(),
                    freeGoldScheme(),
                    const SizedBox(
                      height: 50,
                    ),
                    coordinators(),
                    // buildButton('Teacher Register', () {
                    //   navigateTeacherRegister(context);
                    // }),
                    // buildButton('Teacher Login', () {
                    //   navigateTeacherLogin(context);
                    // }),
                    // buildButton('Visitor Register', () {
                    //   navigateVisitorRagisterPage(context);
                    // }),
                    // buildButton('Visitor Login', () {
                    //   navigateVisitorLoginPage(context);
                    // }),
                    // buildButton('Total Team', () {
                    //   navigateTeamListPage(context);
                    // }),
                    // buildButton('Total Player', () {
                    //   navigatePlayerListPage(context);
                    // }),
                    const SizedBox(
                      height: 100,
                    ),
                    certificateBanner(),
                    const SizedBox(
                      height: 100,
                    ),
                    bottomMenu()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget homePageBanner() {
  return Stack(
    alignment: Alignment.center,
    children: [
      Image.asset(
        'assets/images/background_image.png',
        width: 600,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/top_image.png',
            width: 600,
          ),
          const SizedBox(width: 100),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Hack to the Future: \nBuild, Break, Iterate!',
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                    color: hexToColor('#152238')),
                textAlign: TextAlign.end,
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                'Code, Create, Conquer!',
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: hexToColor('#194569')),
                textAlign: TextAlign.end,
              ),
              const SizedBox(
                height: 60,
              ),
              buildButton('Participate', () {},
                  width: 250,
                  backgroundColor: '#2872a3',
                  textColor: '#FFFFFF',
                  height: 55,
                  bottomMargin: 20,
                  fontSize: 18,
                  rightMargin: 0),
              const SizedBox(
                height: 25,
              ),
              const Text(
                'Where Innovation Meets Implementation: Battle of Bytes 2024',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    color: Colors.black),
                textAlign: TextAlign.end,
              ),
            ],
          )
        ],
      ),
    ],
  );
}

Widget investmentWidget() {
  return Row(
    children: [
      Stack(
        children: [
          Image.asset(
            'assets/images/asset_background.png',
            width: 600,
          ),
          Center(
              child: Container(
            margin: const EdgeInsets.fromLTRB(60, 60, 0, 0),
            child: Image.asset(
              'assets/images/investment_pic2.png',
              height: 300,
            ),
          ))
        ],
      ),
      const SizedBox(
        width: 60,
      ),
      Expanded(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '"Join Forces for Innovation: ',
              style: TextStyle(
                  fontSize: 50,
                  color: hexToColor('#25537B'),
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Click to View -',
              style: TextStyle(
                  fontSize: 32,
                  color: hexToColor('#000000'),
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Build, Break, Learn: Battle Of Bytes 2024 Experience',
              style: TextStyle(
                  fontSize: 32,
                  color: hexToColor('#5C84AF'),
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Hackathons foster a sense of community among participants, organizers, sponsors, and mentors. Collaboration and camaraderie are encouraged, and participants often form bonds that extend beyond the event itself. ',
              style: TextStyle(
                  fontSize: 18,
                  color: hexToColor('#78A3D4'),
                  fontWeight: FontWeight.normal),
            ),
            const SizedBox(
              height: 30,
            ),
            buildButton('View Your Teams', () {},
                width: 300,
                height: 60,
                fontSize: 18,
                leftMargin: 0,
                rightMargin: 0,
                backgroundColor: '#25537B',
                textColor: '#FFFFFF')
          ],
        )),
      ))
    ],
  );
}

Widget freeGoldScheme() {
  return Row(
    children: [
      Expanded(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(80, 0, 0, 0),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Unleash Your Creativity: ',
              style: TextStyle(
                  fontSize: 50,
                  color: hexToColor('#25537B'),
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'View Bidiings',
              style: TextStyle(
                  fontSize: 32,
                  color: hexToColor('#000000'),
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Solve Real-World Problems',
              style: TextStyle(
                  fontSize: 32,
                  color: hexToColor('#5C84AF'),
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Battle of bytes provide a platform for participants to innovate and brainstorm creative solutions to specific challenges or problems. Participants often bring diverse skills and perspectives to the table, leading to novel ideas and approaches. ',
              style: TextStyle(
                  fontSize: 18,
                  color: hexToColor('#78A3D4'),
                  fontWeight: FontWeight.normal),
            ),
            const SizedBox(
              height: 30,
            ),
            buildButton('View Biddings', () {},
                width: 300,
                height: 60,
                fontSize: 18,
                leftMargin: 0,
                rightMargin: 0,
                backgroundColor: '#25537B',
                textColor: '#FFFFFF')
          ],
        )),
      )),
      const SizedBox(
        width: 100,
      ),
      Stack(
        children: [
          Image.asset(
            'assets/images/asset_background.png',
            height: 600,
          ),
          Center(
              child: Container(
            margin: const EdgeInsets.fromLTRB(0, 60, 0, 0),
            child: Image.asset(
              'assets/images/investment_pic.png',
              height: 550,
            ),
          ))
        ],
      ),
    ],
  );
}

Widget certificateBanner() {
  return Container(
    height: 250,
    width: double.infinity,
    padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
    color: hexToColor('#AEC6CF'),
    child: Row(
      children: [
        certificateWidget('assets/images/icon2.png', 'Inspiring Prizes',
            'Inspiring Prizes like, \nkeyboard, headphones, etc \nfor top three'),
        certificateWidget('assets/images/icon3.png', 'Exciting Events',
            'Exciting Events to, \ntest and innovate \nyour coding skills '),
        certificateWidget('assets/images/icon1.png', 'Team Building',
            'Interact with, \nyour seniors and juniors \nduring competition'),
        certificateWidget('assets/images/icon4.png', 'Bonus Event - Web Dev',
            'Web Development event\n bonus event to gain\nas much points as you can '),
      ],
    ),
  );
}

Widget certificateWidget(String icon, String label, String description) {
  return Expanded(
      child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Image.asset(
        icon,
        width: 100,
      ),
      Text(
        label,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: hexToColor('#343F5A')),
      ),
      Text(
        description,
        textAlign: TextAlign.center,
        style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
      ),
    ],
  ));
}

Widget bottomMenu() {
  return Column(
    children: [
      Container(
        color: hexToColor('#343F5A'),
        height: 500,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(100, 50, 100, 50),
          child: Row(
            children: [
              Expanded(
                  child: Center(
                      child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 50, 30, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/images/logo_kyat.png',
                      width: 120,
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Text(
                      'Battle of bytes provide a platform for participants to innovate and brainstorm creative solutions to specific challenges or problems.',
                      style: TextStyle(
                          fontSize: 16,
                          color: hexToColor('#FFFFFF'),
                          fontWeight: FontWeight.normal),
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                    Text(
                      '2024 \u00a9 Copyright Powered by BATTLE OF BYTES',
                      style: TextStyle(
                          fontSize: 16,
                          color: hexToColor('#FFFFFF'),
                          fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ))),
              const SizedBox(
                width: 100,
              ),
              Expanded(
                  child: Center(
                      child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 30, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          color: Colors.blue[300],
                          height: 25,
                          width: 2,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        const Text(
                          'Our Services',
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                              fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 20, 10, 0),
                      child: GestureDetector(
                        onTap: () {},
                        child: Text(
                          'Home',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 16,
                              color: hexToColor('#B3CDE0')),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 20, 10, 0),
                      child: GestureDetector(
                        onTap: () {},
                        child: Text(
                          'Visitors Login',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 16,
                              color: hexToColor('#B3CDE0')),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 20, 10, 0),
                      child: GestureDetector(
                        onTap: () {},
                        child: Text(
                          'Participate in bidding',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 16,
                              color: hexToColor('#B3CDE0')),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 20, 10, 0),
                      child: GestureDetector(
                        onTap: () {},
                        child: Text(
                          'Teacher Login',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 16,
                              color: hexToColor('#B3CDE0')),
                        ),
                      ),
                    )
                  ],
                ),
              ))),
              Expanded(
                  child: Center(
                      child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 30, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          color: Colors.blue[300],
                          height: 25,
                          width: 2,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        const Text(
                          'Important Links',
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                              fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 20, 10, 0),
                      child: GestureDetector(
                        onTap: () {},
                        child: Text(
                          'Privacy Policy',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 16,
                              color: hexToColor('#B3CDE0')),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 20, 10, 0),
                      child: GestureDetector(
                        onTap: () {},
                        child: Text(
                          'Terms and Condition',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 16,
                              color: hexToColor('#B3CDE0')),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 20, 10, 0),
                      child: GestureDetector(
                        onTap: () {},
                        child: Text(
                          'About Us',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 16,
                              color: hexToColor('#B3CDE0')),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 20, 10, 0),
                      child: GestureDetector(
                        onTap: () {},
                        child: Text(
                          'Our Blogs',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 16,
                              color: hexToColor('#B3CDE0')),
                        ),
                      ),
                    )
                  ],
                ),
              ))),
              Expanded(
                  child: Center(
                      child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 30, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          color: Colors.blue[300],
                          height: 25,
                          width: 2,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        const Text(
                          'Social Media',
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                              fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 20, 10, 0),
                      child: GestureDetector(
                        onTap: () {},
                        child: Text(
                          'Facebook',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 16,
                              color: hexToColor('#B3CDE0')),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 20, 10, 0),
                      child: GestureDetector(
                        onTap: () {},
                        child: Text(
                          'Instagram',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 16,
                              color: hexToColor('#B3CDE0')),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 20, 10, 0),
                      child: GestureDetector(
                        onTap: () {},
                        child: Text(
                          'Linked In',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 16,
                              color: hexToColor('#B3CDE0')),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 20, 10, 0),
                      child: GestureDetector(
                        onTap: () {},
                        child: Text(
                          'Youtube',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 16,
                              color: hexToColor('#B3CDE0')),
                        ),
                      ),
                    )
                  ],
                ),
              ))),
            ],
          ),
        ),
      ),
      Container(
        color: hexToColor('#8795B6'),
        height: 40,
        child: const Center(
          child: Text(
            '2024 \u00a9 Copyright Powered by Battle Of Bytes',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    ],
  );
}

void navigateTeacherRegister(BuildContext context) {
  Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (BuildContext context) {
    return const TeeacherRegisterScreen();
  }));
}

void navigateTeacherLogin(BuildContext context) {
  Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (BuildContext context) {
    return const TeacherLoginScreen();
  }));
}

void navigateVisitorLoginPage(BuildContext context) {
  Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (BuildContext context) {
    return const VisitorsLoginScreen();
  }));
}

void navigateVisitorRagisterPage(BuildContext context) {
  Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (BuildContext context) {
    return const VisitorRegisterScreen();
  }));
}

void navigatePlayerListPage(BuildContext context) {
  Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (BuildContext context) {
    return const TotalPlayerScreen();
  }));
}

void navigateTeamListPage(BuildContext context) {
  Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (BuildContext context) {
    return const TotalTeamScreen();
  }));
}
