import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mark7/provider/google_sign_in.dart';
import 'package:provider/provider.dart';

class sign_up_widget extends StatefulWidget {
  const sign_up_widget({Key? key}) : super(key: key);

  @override
  State<sign_up_widget> createState() => _sign_up_widgetState();
}

class _sign_up_widgetState extends State<sign_up_widget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFFE6EDF3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height - 700,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(width: MediaQuery.of(context).size.width - 348),
                SizedBox(
                  child: SvgPicture.asset(
                    "assets/Backg.svg",
                  ),
                  width: MediaQuery.of(context).size.width - 23,
                  height: 370,
                ),
              ],
            ),
            const SizedBox(height: 55),
            const Text(
              'Start you Journey\nWith Motion',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Color(0xFF0A1E51)),
            ),
            const SizedBox(height: 15),
            const Text(
              'For the words behind the silence sign \nin to express througn signs ',
              style: TextStyle(color: Color.fromARGB(255, 24, 23, 31)),
            ),
            const SizedBox(height: 25),
            Row(
              children: [
                const SizedBox(width: 55),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      onPrimary: const Color.fromARGB(255, 24, 23, 31),
                      minimumSize: const Size(80, 50),
                      shape: const StadiumBorder()),
                  onPressed: () {
                    final provider = Provider.of<GoogleSignInProvider>(context,
                        listen: false);
                    provider.googleLogin();
                  },
                  icon: SvgPicture.asset(
                    'assets/icons8-google.svg',
                    width: 30,
                    height: 30,
                  ),
                  label: const Text('Sign in',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
