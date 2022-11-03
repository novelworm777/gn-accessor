import 'dart:async';

import 'package:battery_info/battery_info_plugin.dart';
import 'package:battery_info/model/android_battery_info.dart';
import 'package:circular_menu/circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../components/atoms/circular_button.dart';
import '../../components/templates/colour_default_screen.dart';
import '../../config/route/routes.dart';
import '../../config/themes/colours.dart';

/// Screen for the root of all screens.
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late DateTime _currentTime;

  @override
  void initState() {
    _getCurrentTime();
    super.initState();
    Timer.periodic(const Duration(seconds: 1), (_) => _getCurrentTime());
  }

  _getCurrentTime() => setState(() => _currentTime = DateTime.now());

  @override
  Widget build(BuildContext context) {
    final String _dateMonth = DateFormat('d/M').format(_currentTime);
    final String _day = DateFormat('EEE').format(_currentTime).toUpperCase();
    final String _hourMinute = DateFormat('HH:mm').format(_currentTime);

    return ColourDefaultScreen(
      colour: Colours.darkBase,
      child: CircularMenu(
        animationDuration: const Duration(milliseconds: 370),
        backgroundWidget: Stack(
          children: <Widget>[
            // status bar
            StreamBuilder<AndroidBatteryInfo?>(
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        "${(snapshot.data!.batteryLevel)}%",
                        style: GoogleFonts.jetBrainsMono(color: Colours.text),
                      ),
                      const SizedBox(width: 7.0),
                      const Icon(
                        FontAwesomeIcons.batteryThreeQuarters,
                        color: Colours.text,
                        size: 21.0,
                      ),
                    ],
                  );
                }
                return Container();
              },
              stream: BatteryInfoPlugin().androidBatteryInfoStream,
            ),
            // time and date
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Text>[
                  Text(
                    _hourMinute,
                    style: GoogleFonts.jetBrainsMono(
                      color: Colours.text,
                      fontSize: 77.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '$_dateMonth $_day',
                    style: GoogleFonts.jetBrainsMono(
                      color: Colours.darkText,
                      fontSize: 21.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        curve: Curves.easeOut,
        items: <CircularMenuItem>[
          // task board app icon button
          CircularMenuItem(
            color: Colours.text,
            icon: FontAwesomeIcons.clipboard,
            iconColor: Colours.darkText,
            onTap: () {
              Navigator.pushNamed(context, Routes.taskBoardScreen);
            },
          ),
          // turn off icon button
          CircularMenuItem(
            color: Colours.text,
            icon: FontAwesomeIcons.powerOff,
            iconColor: Colours.darkText,
            onTap: () {
              // show exit app pop up
              _showExitAppPopUp(() => SystemNavigator.pop());
            },
          ),
        ],
        reverseCurve: Curves.easeIn,
        toggleButtonColor: Colours.text,
        toggleButtonIconColor: Colours.darkText,
      ),
      padding: const EdgeInsets.only(
        bottom: 33.0,
        left: 21.0,
        right: 21.0,
        top: 17.0,
      ),
    );
  }

  _showExitAppPopUp(VoidCallback onPress) {
    SmartDialog.show(
      builder: (_) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularButton(
              colour: Colours.text,
              icon: const Icon(
                FontAwesomeIcons.powerOff,
                color: Colours.darkText,
                size: 70.0,
              ),
              onPress: onPress,
              size: 100.0,
            ),
            const SizedBox(height: 13.0),
            Text(
              'Exit App',
              style: GoogleFonts.jetBrainsMono(
                color: Colours.text,
                fontSize: 17.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        );
      },
      clickMaskDismiss: true,
      maskColor: Colors.black.withOpacity(0.93),
    );
  }
}
