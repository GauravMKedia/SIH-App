import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

enum DomHand { left, right }

class _SettingsPageState extends State<SettingsPage> {
  DomHand _domHand = DomHand.right;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Settings'),
      //   titleTextStyle: TextStyle(color: Colors.black, fontSize: 23),
      //   centerTitle: true,
      //   leading: IconButton(
      //     icon: Icon(Icons.arrow_back),
      //     color: Colors.black,
      //     onPressed: () {},
      //   ),
      //   backgroundColor: Colors.lightBlue,
      //   elevation: 2,
      // ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 25, horizontal: 30),
        child: ListView(
          children: [
            Row(
              children: [
                Text('Dominant hand',
                    style: TextStyle(color: Colors.lightBlue, fontSize: 20)),
              ],
            ),
            Row(
              children: <Widget>[
                Flexible(
                  child: RadioListTile(
                    title: const Text('Left-handed',
                        style: TextStyle(fontSize: 16)),
                    controlAffinity: ListTileControlAffinity.trailing,
                    value: DomHand.left,
                    groupValue: _domHand,
                    onChanged: (DomHand? value) {
                      setState(() {
                        _domHand = value!;
                      });
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Flexible(
                  child: RadioListTile(
                    title: const Text('Right-handed',
                        style: TextStyle(fontSize: 16)),
                    controlAffinity: ListTileControlAffinity.trailing,
                    value: DomHand.right,
                    groupValue: _domHand,
                    onChanged: (DomHand? value) {
                      setState(() {
                        _domHand = value!;
                      });
                    },
                  ),
                ),
              ],
            ),
            Divider(
              height: 15,
              thickness: 2,
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Text('Notifications',
                    style: TextStyle(color: Colors.lightBlue, fontSize: 20)),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Phone orientation reminder',
                    style: TextStyle(fontSize: 16)),
                Transform.scale(
                  scale: 0.7,
                  child: CupertinoSwitch(
                    value: true,
                    onChanged: (bool val) {},
                    activeColor: Colors.lightBlue,
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Practice reminder', style: TextStyle(fontSize: 16)),
                Transform.scale(
                  scale: 0.7,
                  child: CupertinoSwitch(
                    value: true,
                    onChanged: (bool val) {},
                    activeColor: Colors.lightBlue,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              height: 15,
              thickness: 2,
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Text('About',
                    style: TextStyle(color: Colors.lightBlue, fontSize: 20)),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Text('About SignAll', style: TextStyle(fontSize: 16)),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Text('Contact Us', style: TextStyle(fontSize: 16)),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Text('Rate Us', style: TextStyle(fontSize: 16)),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Text('Privacy Policy', style: TextStyle(fontSize: 16)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
