import 'package:flutter/material.dart';

import '../../config/themes/colours.dart';

const _kDefaultPadding = 7.0;
const _kDefaultRadius = Radius.circular(9.0);

/// List tile with widget body, leading, and trailing.
class AppListTile extends StatelessWidget {
  const AppListTile({
    Key? key,
    required this.body,
    this.colour = Colours.base,
    this.leading,
    this.leadingColour,
    this.leadingOnPress,
    this.trailing,
    this.trailingColour,
    this.trailingOnPress,
    required this.onPress,
  }) : super(key: key);

  final Widget body;
  final Color colour;
  final Widget? leading;
  final Color? leadingColour;
  final VoidCallback? leadingOnPress;
  final Widget? trailing;
  final Color? trailingColour;
  final VoidCallback? trailingOnPress;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // leading
            leading != null
                ? GestureDetector(
                    onTap: leadingOnPress ?? onPress,
                    child: Container(
                      alignment: Alignment.centerRight,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: _kDefaultRadius,
                          topLeft: _kDefaultRadius,
                        ),
                        color: leadingColour ?? colour,
                      ),
                      padding: const EdgeInsets.only(
                        bottom: _kDefaultPadding,
                        left: _kDefaultPadding,
                        right: _kDefaultPadding,
                        top: _kDefaultPadding,
                      ),
                      child: leading,
                    ),
                  )
                : Container(),
            // body
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: leading == null ? _kDefaultRadius : Radius.zero,
                    bottomRight:
                        trailing == null ? _kDefaultRadius : Radius.zero,
                    topLeft: leading == null ? _kDefaultRadius : Radius.zero,
                    topRight: trailing == null ? _kDefaultRadius : Radius.zero,
                  ),
                  color: colour,
                ),
                padding: EdgeInsets.only(
                  bottom: _kDefaultPadding,
                  left: leading == null ? _kDefaultPadding : _kDefaultPadding,
                  right: trailing == null ? _kDefaultPadding : _kDefaultPadding,
                  top: _kDefaultPadding,
                ),
                child: body,
              ),
            ),
            // trailing
            trailing != null
                ? GestureDetector(
                    onTap: trailingOnPress ?? onPress,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          bottomRight: _kDefaultRadius,
                          topRight: _kDefaultRadius,
                        ),
                        color: trailingColour ?? colour,
                      ),
                      padding: const EdgeInsets.only(
                        bottom: _kDefaultPadding,
                        left: _kDefaultPadding,
                        right: _kDefaultPadding,
                        top: _kDefaultPadding,
                      ),
                      child: trailing,
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
