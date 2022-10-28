import 'package:flutter/material.dart';

import '../../config/themes/colours.dart';
import '../atoms/flying_icon_button.dart';

const _kDefaultContentPadding = EdgeInsets.only(
  bottom: 33.0,
  left: 33.0,
  right: 33.0,
);

class DetailScreen extends StatelessWidget {
  const DetailScreen({
    Key? key,
    required this.body,
    required this.colour,
    this.hasRightIconButton = false,
    this.homeRoute,
    this.onTapUnfocus = true,
    this.padding = _kDefaultContentPadding,
    this.rightIconColour,
    this.rightIconData,
    this.rightIconOnPress,
  }) : super(key: key);

  final Widget body;
  final Color colour;
  final bool hasRightIconButton;
  final String? homeRoute;
  final bool onTapUnfocus;
  final EdgeInsetsGeometry padding;
  final Color? rightIconColour;
  final IconData? rightIconData;
  final VoidCallback? rightIconOnPress;

  @override
  Widget build(BuildContext context) {
    // right icon button validation
    if (hasRightIconButton) {
      assert(rightIconColour != null, 'rightIconColour is required');
      assert(rightIconData != null, 'rightIconData is required');
      assert(rightIconOnPress != null, 'rightIconOnPress is required');
    }

    return SafeArea(
      child: GestureDetector(
        child: Scaffold(
          backgroundColor: colour,
          body: Padding(
            padding: const EdgeInsets.only(top: 33.0),
            child: Column(
              children: [
                // header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        // back icon button
                        FlyingIconButton(
                          colour: Colours.base,
                          iconData: Icons.arrow_back_ios_rounded,
                          location: FlyingLocation.left,
                          onPress: () => Navigator.pop(context),
                        ),
                        const SizedBox(width: 13.0),
                        // home icon button
                        FlyingIconButton(
                          colour: Colours.base,
                          iconData: Icons.home,
                          location: FlyingLocation.center,
                          onPress: () => homeRoute != null
                              ? Navigator.pushNamed(context, homeRoute!)
                              : Navigator.pop(context),
                        ),
                      ],
                    ),
                    // right icon button
                    hasRightIconButton
                        ? FlyingIconButton(
                            colour: rightIconColour!,
                            iconData: rightIconData!,
                            location: FlyingLocation.right,
                            onPress: rightIconOnPress!,
                          )
                        : Container(),
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
                // content
                Expanded(
                  child: Container(child: body, padding: padding),
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
