import 'package:flutter/material.dart';
import 'package:mark7/provider/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mark7/provider/quiz.dart';
import 'package:mark7/provider/webpreview.dart';
import 'package:provider/provider.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:mark7/provider/logged_In_Widget.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:mark7/provider/profile_page.dart';
import 'package:mark7/provider/settings_page.dart';
import 'package:mark7/provider/webpreview.dart';

class asl extends StatefulWidget {
  const asl({Key? key}) : super(key: key);

  @override
  State<asl> createState() => _aslState();
}

class _aslState extends State<asl> {
  final user = FirebaseAuth.instance.currentUser!;
  String _colorName = 'No';
  Color _color = Colors.black;

  String dropdownvalue = 'Item 1';
  var items = [
    'assets/icons8-google.svg',
    'assets/icons8-google.svg',
    'assets/icons8-google.svg',
    'assets/icons8-google.svg',
  ];

  /*------------------------------- Speed dial ---------------------------*/
  SpeedDial buildSpeedDial() {
    return SpeedDial(
      direction: SpeedDialDirection.up,
      spacing: 10,
      buttonSize: Size(50.0, 50.0),
      childrenButtonSize: Size(55.0, 55.0),
      animatedIcon: AnimatedIcons.menu_close,
      backgroundColor: Color.fromARGB(185, 0, 59, 114),
      visible: true,
      curve: Curves.bounceInOut,
      children: [
        SpeedDialChild(
          child: Image.asset("assets/Camera.png", width: 35, height: 35),
          backgroundColor: Color(0xFF003B72),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoggedInWidget()),
          ),
          label: 'Sign to Text',
          labelStyle:
              TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
          labelBackgroundColor: Colors.black,
        ),
        SpeedDialChild(
          child: Image.asset("assets/Group.png", width: 48, height: 48),
          backgroundColor: Color(0xFF003B72),
          onTap: () => print('Text to Sign'),
          label: 'Text to Sign',
          labelStyle:
              TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
          labelBackgroundColor: Colors.black,
        ),
      ],
    );
  }

  /*--------------------------------------------------*/
  SpeedDial buildSpeedDialSe() {
    return SpeedDial(
      spacing: 10,
      buttonSize: Size(45.0, 45.0),
      childrenButtonSize: Size(50.0, 50.0),
      direction: SpeedDialDirection.down,
      child: CircleAvatar(
          backgroundColor: Color(0xFF003B72),
          radius: 48,
          backgroundImage: NetworkImage(user.photoURL!)),
      backgroundColor: Color(0xFF003B72),
      visible: true,
      curve: Curves.bounceInOut,
      children: [
        SpeedDialChild(
          child: Image.asset("assets/profile.png", width: 35, height: 35),
          backgroundColor: Color(0xFF003B72),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ProfilePage()),
          ),
          label: 'Profile',
          labelStyle:
              TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
          labelBackgroundColor: Colors.black,
        ),
        SpeedDialChild(
          child: Image.asset("assets/dark-mode.png", width: 35, height: 35),
          backgroundColor: Color(0xFF003B72),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Webper()),
          ),
          label: 'Dark Mode',
          labelStyle:
              TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
          labelBackgroundColor: Colors.black,
        ),
        SpeedDialChild(
          child: Image.asset("assets/settings.png", width: 35, height: 35),
          backgroundColor: Color(0xFF003B72),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SettingsPage()),
          ),
          label: 'Settings',
          labelStyle:
              TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
          labelBackgroundColor: Colors.black,
        ),
        SpeedDialChild(
          child: Image.asset("assets/logout.png", width: 35, height: 35),
          backgroundColor: Color(0xFF003B72),
          onTap: () {
            final provider =
                Provider?.of<GoogleSignInProvider>(context, listen: false);
            provider.Logout();
          },
          label: 'Logout',
          labelStyle:
              TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
          labelBackgroundColor: Colors.black,
        ),
      ],
    );
  } /*------------------------------------------------------*/

  @override
  Widget build(BuildContext context) {
    double wi = MediaQuery.of(context).size.width - 36 - 5;
    final primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      backgroundColor: Color(0xFFE6EDF3),
      floatingActionButton: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 10.0),
              child: buildSpeedDial(),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 60.0, 0.0, 0.0),
              child: buildSpeedDialSe(),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          color: Color(0xFFE6EDF3),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 32),
                Row(
                  children: <Widget>[
                    Image.asset("assets/notification.png",
                        width: 32, height: 32),
                    SizedBox(width: MediaQuery.of(context).size.width - 124),
                  ],
                ),
                SizedBox(height: 50),
                Text(
                  "Hi " + user.displayName! + " 👋",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 23,
                      color: Color(0xFF0A1E51)),
                ),
                SizedBox(height: 3),
                Text(
                  'How are you?',
                  style: TextStyle(
                      color: Color.fromARGB(255, 24, 23, 31), fontSize: 14),
                ),
                SizedBox(height: 15),
                Expanded(
                  child: ScrollConfiguration(
                    behavior: CustomScroll(),
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 130,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: Color.fromARGB(188, 86, 79, 215),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(12, 15, 12, 12),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    runApp(MyQuiz());
                                  },
                                  child: const Text("Test Your Sign Language ",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0)),
                                ),
                                SizedBox(width: 6),
                                CircularPercentIndicator(
                                  radius: 100.0,
                                  lineWidth: 13.0,
                                  animation: true,
                                  percent: 0.7,
                                  center: new Text("70%",
                                      style: new TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0,
                                          color: Colors.white)),
                                  circularStrokeCap: CircularStrokeCap.round,
                                  progressColor: Color(0xFF554FD7),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Container(
                                    width: wi / 2,
                                    height: 230,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.0),
                                      color: Color.fromARGB(186, 183, 147, 217),
                                    ),
                                    child: Text((172.toString()),
                                        style: TextStyle(color: Colors.white))),
                                SizedBox(height: 5),
                                Container(
                                    width: wi / 2,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.0),
                                      color: Color.fromARGB(185, 0, 59, 114),
                                    ),
                                    child: Text(
                                        (MediaQuery.of(context).size.width)
                                            .toString(),
                                        style: TextStyle(color: Colors.white))),
                              ],
                            ),
                            SizedBox(
                                width: MediaQuery.of(context).size.width -
                                    (MediaQuery.of(context).size.width - 5)),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    width: wi / 2,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.0),
                                      color: Color.fromARGB(185, 0, 59, 114),
                                    ),
                                    child: Text(
                                        (MediaQuery.of(context).size.width -
                                                201)
                                            .toString(),
                                        style: TextStyle(color: Colors.white))),
                                SizedBox(height: 5),
                                Container(
                                    width: wi / 2,
                                    height: 230,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.0),
                                      color: Color.fromARGB(186, 47, 12, 73),
                                    ),
                                    child: Text(
                                        (MediaQuery.of(context).size.width -
                                                201)
                                            .toString(),
                                        style: TextStyle(color: Colors.white))),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 130,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: Color.fromARGB(188, 86, 79, 215),
                          ),
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Container(
                              width: wi / 2,
                              height: 180,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                                color: Color.fromARGB(186, 183, 147, 217),
                              ),
                            ),
                            SizedBox(width: 5),
                            Container(
                              width: wi / 2,
                              height: 180,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                                color: Color.fromARGB(185, 0, 59, 114),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Container(
                              width: wi / 2,
                              height: 180,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                                color: Color.fromARGB(188, 86, 79, 215),
                              ),
                            ),
                            SizedBox(width: 5),
                            Container(
                              width: wi / 2,
                              height: 180,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                                color: Color.fromARGB(188, 255, 65, 129),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomScroll extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
