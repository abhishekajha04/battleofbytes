import 'package:battle_of_bytes_aution/studentSignup.dart';
import 'package:battle_of_bytes_aution/teacher_login_dashboard.dart';
import 'package:battle_of_bytes_aution/total_players.dart';
import 'package:battle_of_bytes_aution/total_teams.dart';
import 'package:battle_of_bytes_aution/utils.dart';
import 'package:battle_of_bytes_aution/visitor_login.dart';
import 'package:flutter/material.dart';

Widget topMenuBar(BuildContext context) {
  return Column(
    children: [
      Container(
          color: hexToColor('#EAF2F4'),
          width: double.infinity,
          height: 70,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(80, 0, 80, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logo_kyat.png',
                  width: 60,
                ),
                const SizedBox(
                  width: 40,
                ),
                menuButton(
                  'All Teams',
                  () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return const TotalTeamScreen();
                    }));
                  },
                ),
                const SizedBox(
                  width: 40,
                ),
                menuButton('Current Biddings', () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return const TotalPlayerScreen();
                  }));
                }),
                const SizedBox(
                  width: 40,
                ),
                menuButton('Previous Event', () {
                  // Navigator.of(context)
                  //     .push(MaterialPageRoute(builder: (context) {
                  //   return const AboutUsPageScreen();
                  // }));
                }),
                const Spacer(
                  flex: 1,
                ),
                mainMenuButton('Visitor Login', () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return const VisitorsLoginScreen();
                  }));
                }),
                const SizedBox(
                  width: 40,
                ),
                mainMenuButton('Teacher Login', () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return const TeacherLoginScreen();
                  }));
                }),
                const SizedBox(
                  width: 40,
                ),
                mainMenuButton('Participate', () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return const StudentLoginScreen();
                  }));
                }),
                const SizedBox(
                  width: 40,
                )
              ],
            ),
          )),
      Container(
        height: 2,
        color: hexToColor('#A4C9D7'),
      )
    ],
  );
}

Widget menuButton(String label, Function onPressed) {
  return HoverWidget(builder: ((isHovered) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Text(
        label,
        style: TextStyle(
          fontSize: 14,
          color: isHovered ? Colors.black : hexToColor('#2D7F9D'),
        ),
      ),
    );
  }));
}

Widget mainMenuButton(String label, Function onPressed) {
  return GestureDetector(
    onTap: () {
      onPressed();
    },
    child: HoverWidget(
      builder: (isHovered) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color:
                isHovered ? Colors.grey.withOpacity(0.2) : Colors.transparent,
          ),
          child: PhysicalModel(
            color: Colors.transparent,
            elevation: isHovered ? 25 : 0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              height: 45,
              width: 125,
              child: Center(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    color: isHovered ? Colors.black : hexToColor('#2D7F9D'),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    ),
  );
}

class HoverWidget extends StatefulWidget {
  final Function(bool isHovered) builder;

  const HoverWidget({super.key, required this.builder});
  @override
  // ignore: library_private_types_in_public_api
  _HoverWidgetState createState() => _HoverWidgetState();
}

class _HoverWidgetState extends State<HoverWidget> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final hovered = Matrix4.identity()..translate(0, -4, 0);
    final transform = isHovered ? hovered : Matrix4.identity();
    return MouseRegion(
      onEnter: (_) => onEntered(true),
      onExit: (_) => onEntered(false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: transform,
        child: widget.builder(isHovered),
      ),
    );
  }

  void onEntered(bool isHovered) {
    setState(() {
      this.isHovered = isHovered;
    });
  }
}

Widget buildButton(
  String title,
  Function onPressed, {
  double leftMargin = 30,
  double rightMargin = 30,
  double topMargin = 0,
  double bottomMargin = 40,
  double fontSize = 20,
  double height = 65,
  double width = double.infinity,
  String backgroundColor = '#C7E5FA',
  String textColor = "#000000",
  var isButtonVisible = true,
  var isProgressBarVisible = false,
}) {
  return Stack(
    alignment: Alignment.center,
    children: [
      Container(
        width: width,
        height: height,
        margin: EdgeInsets.fromLTRB(
          leftMargin,
          topMargin,
          rightMargin,
          bottomMargin,
        ),
        child: Visibility(
          visible: isButtonVisible,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: hexToColor(backgroundColor),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ElevatedButton(
              onPressed: () {
                onPressed();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent, // Transparent background
                elevation: 1, // No shadow
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: FittedBox(
                child: Text(
                  title,
                  style: TextStyle(
                    color: hexToColor(textColor),
                    fontWeight: FontWeight.bold,
                    fontSize: fontSize,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      Visibility(
        visible: isProgressBarVisible,
        child: const CircularProgressIndicator(color: Color(0xFF4F346B)),
      ),
    ],
  );
}

Widget fillDetails(String label, TextEditingController controller,
    {double padding = 60, int i = 0, double width = 350}) {
  return Padding(
    padding: EdgeInsets.fromLTRB(10, padding, 10, 0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 15, right: 15),
          height: 40,
          width: width,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: TextField(
            controller: controller,
            keyboardType: i == 1 ? TextInputType.number : TextInputType.text,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero, // To remove default padding
              isCollapsed:
                  true, // To remove the extra space around the TextField
            ),
          ),
        )
      ],
    ),
  );
}

Widget coordinators() {
  return Padding(
    padding: EdgeInsets.all(20),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Faculty Coordinator',
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: hexToColor('#343F5A')),
        ),
        const Text(
          'Dr Piyush Gupta Sir, Dr. Shripal Vijaywargiya Sir',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
        ),
        const SizedBox(
          height: 25,
        ),
        Text(
          'All the Team Mentors',
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: hexToColor('#343F5A')),
        ),
        const Text(
          ' Mr. Puneet Sharma , Mr. PK Sharma , Mr. Gurminder Singh , Dr. Anju Sharma, \nMr. Jyoti Kumar Chandel ,Dr. Seema Gaur , Mr. Vikas Sangwan, Mr. B Pathak, Mr. Santosh Kumar Agarwal,\n Dr. Vivek Gaur, Mr. Santosh Kumar Sharma , Mr. Subhash Chand Gupta ',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 25,
        ),
        Text(
          'Event Coordinator',
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: hexToColor('#343F5A')),
        ),
        const Text(
          'Rajveer Mewara, Hardik Malik, Abhinav Tadi, Anushree Agrawal, Sanchi Malhotra',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
        ),
      ],
    ),
  );
}
