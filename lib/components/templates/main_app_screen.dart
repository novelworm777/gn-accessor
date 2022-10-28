import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../config/themes/colours.dart';
import '../atoms/flying_icon_button.dart';

const _kDefaultContentPadding = EdgeInsets.only(
  bottom: 33.0,
  left: 33.0,
  right: 33.0,
);

/// A screen template for main apps.
class MainAppScreen extends StatelessWidget {
  const MainAppScreen({
    Key? key,
    required this.colour,
    required this.content,
    this.contentPadding = _kDefaultContentPadding,
    required this.headerTitle,
    this.homeRoute,
    this.onTapUnfocus = true,
  }) : super(key: key);

  final Color colour;
  final Widget content;
  final EdgeInsetsGeometry contentPadding;
  final String headerTitle;
  final String? homeRoute;
  final bool onTapUnfocus;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        child: Scaffold(
          backgroundColor: colour,
          body: Padding(
            padding: const EdgeInsets.only(top: 33.0),
            child: Column(
              children: [
                // header
                Stack(
                  alignment: Alignment.centerLeft,
                  children: <Widget>[
                    // home icon button
                    FlyingIconButton(
                      colour: Colours.base,
                      iconData: Icons.home,
                      location: FlyingLocation.left,
                      onPress: () => homeRoute != null
                          ? Navigator.pushNamed(context, homeRoute!)
                          : Navigator.pop(context),
                    ),
                    // header title
                    Center(
                      child: Text(
                        headerTitle,
                        style: GoogleFonts.jetBrainsMono(
                          color: Colours.text,
                          fontSize: 21.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                // divider
                const Divider(
                  color: Colours.darkText,
                  endIndent: 21.0,
                  height: 37.0,
                  indent: 21.0,
                  thickness: 3.0,
                ),
                // body
                Expanded(
                  child: Container(
                    child: content,
                    padding: contentPadding,
                  ),
                ),
              ],
            ),
          ),
        ),
        onTap: () {
          if (onTapUnfocus) FocusManager.instance.primaryFocus?.unfocus();
        },
      ),
    );
  }
}
