import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../config/themes/colours.dart';
import 'body_index_component_view.dart';

/// Expanded panel for body index record.
// ignore: must_be_immutable
class ExpandedBodyIndexPanel extends StatefulWidget {
  ExpandedBodyIndexPanel({
    Key? key,
    required this.components,
    this.isExpanded = true,
    required this.title,
  }) : super(key: key);

  final List<BodyIndexComponentView> components;
  bool isExpanded;
  final String title;

  @override
  State<ExpandedBodyIndexPanel> createState() => _ExpandedBodyIndexPanelState();
}

class _ExpandedBodyIndexPanelState extends State<ExpandedBodyIndexPanel> {
  final Radius _radius = const Radius.circular(7.0);

  @override
  Widget build(BuildContext context) {
    return widget.isExpanded
        ? Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.75),
                  blurRadius: 4,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: <Widget>[
                _ExpandedBodyIndexPanelHeader(
                  arrowIcon: Icons.arrow_drop_down,
                  bottomWithoutRadius: true,
                  onPress: () => setState(() {
                    widget.isExpanded = !widget.isExpanded;
                  }),
                  title: widget.title,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: _radius,
                      bottomRight: _radius,
                    ),
                    color: Colours.base,
                  ),
                  padding: const EdgeInsets.all(13.0),
                  child: ListView.separated(
                    itemBuilder: (BuildContext context, int index) {
                      return widget.components[index];
                    },
                    itemCount: widget.components.length,
                    primary: false,
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(height: 7.0),
                    shrinkWrap: true,
                  ),
                ),
              ],
            ),
          )
        : Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.75),
                  blurRadius: 4,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: _ExpandedBodyIndexPanelHeader(
              arrowIcon: Icons.arrow_right,
              onPress: () => setState(() {
                widget.isExpanded = !widget.isExpanded;
              }),
              title: widget.title,
            ),
          );
  }
}

/// Expanded panel header for [ExpandedBodyIndexPanel].
class _ExpandedBodyIndexPanelHeader extends StatelessWidget {
  const _ExpandedBodyIndexPanelHeader({
    Key? key,
    required this.arrowIcon,
    this.bottomWithoutRadius = false,
    required this.onPress,
    required this.title,
  }) : super(key: key);

  final IconData arrowIcon;
  final bool bottomWithoutRadius;
  final VoidCallback onPress;
  final String title;

  final Radius _radius = const Radius.circular(7.0);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: bottomWithoutRadius
            ? BorderRadius.only(topLeft: _radius, topRight: _radius)
            : BorderRadius.all(_radius),
        color: Colours.lightBase,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 3.0),
      child: Row(
        children: <Widget>[
          GestureDetector(
            onTap: onPress,
            child: Icon(
              arrowIcon,
              color: Colours.text,
              size: 33.0,
            ),
          ),
          Text(
            title,
            style: GoogleFonts.jetBrainsMono(
              color: Colours.text,
              fontSize: 15.0,
            ),
          ),
        ],
      ),
    );
  }
}
