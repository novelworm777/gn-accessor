import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../components/atoms/circular_button.dart';
import '../../components/templates/detail_screen.dart';
import '../../config/route/routes.dart';
import '../../config/themes/colours.dart';
import '../../domain/usecases/body_index_usecase.dart';
import '../../types/body_index_component.dart';
import '../../types/gender.dart';
import '../../utils/helpers/map_formatter.dart';
import '../models/user.dart';

/// Screen for body index record details.
class BodyIndexScreen extends StatefulWidget {
  const BodyIndexScreen({Key? key}) : super(key: key);

  @override
  State<BodyIndexScreen> createState() => _BodyIndexScreenState();
}

class _BodyIndexScreenState extends State<BodyIndexScreen> {
  final double _spacing = 17.0;
  final BodyIndexUseCase _bodyIndexUseCase = BodyIndexUseCase();

  String? _id;
  DateTime _date = DateTime.now();
  Map<String, dynamic> _basicProfileData = {};
  Map<String, dynamic> _bodyIndexData = {};
  Map<String, dynamic> _circumferenceData = {};
  bool _hasRecord = false;

  @override
  void initState() {
    super.initState();
    _initBodyIndex();
  }

  /// Get body index from database.
  void _initBodyIndex() async {
    final userId = context.read<User>().id;
    final date = DateTime(_date.year, _date.month, _date.day);
    try {
      final res = await _bodyIndexUseCase.viewBodyIndex(
        userId: userId,
        date: date,
      );
      _setBodyIndexData(res);
    } catch (e) {
      _emptyBodyIndexData();
    }
  }

  /// Give value to body index data.
  void _setBodyIndexData(res) {
    setState(() {
      _id = res['id'];
      _basicProfileData = MapFormatter.removeNull(res['basicProfile']);
      _bodyIndexData = MapFormatter.removeNull(res['bodyIndex']);
      _circumferenceData = MapFormatter.removeNull(res['circumference']);
      if (_basicProfileData.isNotEmpty ||
          _bodyIndexData.isNotEmpty ||
          _circumferenceData.isNotEmpty) {
        _hasRecord = true;
      }
    });
  }

  /// Return body index data to empty state.
  void _emptyBodyIndexData() {
    setState(() {
      _id = null;
      _basicProfileData.clear();
      _bodyIndexData.clear();
      _circumferenceData.clear();
      _hasRecord = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DetailScreen(
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () async {
                      // show date picker to pick a new body index date
                      DateTime? newDate = await showDatePicker(
                          context: context,
                          initialDate: _date,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                          builder: (context, child) {
                            return Theme(
                              data: ThemeData(
                                colorScheme: const ColorScheme.light(
                                  primary: Colours.base,
                                  onPrimary: Colours.text,
                                  onSurface: Colours.darkBase,
                                ),
                              ),
                              child: child!,
                            );
                          });
                      // no change in body index date
                      if (newDate == null) return;
                      if (_date != newDate) {
                        // change body index date
                        setState(() => _date = newDate);
                        // update body index data
                        _initBodyIndex();
                      }
                    },
                    child: const Icon(
                      FontAwesomeIcons.solidCalendarDays,
                      color: Colours.darkText,
                      size: 21.0,
                    ),
                  ),
                  const SizedBox(width: 13.0),
                  Text(
                    DateFormat('d MMM yyyy').format(_date),
                    style: GoogleFonts.jetBrainsMono(
                      color: Colours.text,
                      fontSize: 15.0,
                    ),
                  ),
                ],
              ),
              _hasRecord
                  ? GestureDetector(
                      onTap: () {
                        // show pop up to delete
                        _showDeleteBodyIndexPopup();
                      },
                      child: const Icon(
                        FontAwesomeIcons.solidTrashCan,
                        color: Colours.red,
                        size: 21.0,
                      ),
                    )
                  : Container(),
            ],
          ),
          const SizedBox(height: 21.0),
          Expanded(
            child: _hasRecord
                ? Column(
                    children: <Widget>[
                      ExpandedBodyIndexPanel(
                        components: _convertDataToWidget(_basicProfileData),
                        isExpanded: false,
                        title: "Basic Profile",
                      ),
                      if (_bodyIndexData.isNotEmpty) SizedBox(height: _spacing),
                      if (_bodyIndexData.isNotEmpty)
                        ExpandedBodyIndexPanel(
                          components: _convertDataToWidget(_bodyIndexData),
                          title: "Body Index",
                        ),
                      if (_circumferenceData.isNotEmpty)
                        SizedBox(height: _spacing),
                      if (_circumferenceData.isNotEmpty)
                        ExpandedBodyIndexPanel(
                          components: _convertDataToWidget(_circumferenceData),
                          title: "Circumference",
                        ),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 37.0),
                        child: Text(
                          "There's no record for this date yet",
                          style: GoogleFonts.jetBrainsMono(
                            color: Colours.text,
                            fontSize: 15.0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 37.0),
                      CircularButton(
                        colour: Colours.base,
                        icon: const Icon(
                          Icons.add,
                          color: Colours.green,
                          size: 56.0,
                        ),
                        onPress: () => Navigator.pushNamed(
                          context,
                          Routes.bodyIndexFormScreen,
                          arguments: _date,
                        ),
                        size: 73.0,
                      ),
                    ],
                  ),
          ),
        ],
      ),
      colour: Colours.darkBase,
    );
  }

  _showDeleteBodyIndexPopup() {
    const radius = Radius.circular(15.0);
    const margin = 49.0;
    const message = 'Are you sure you want to delete body index record of ';
    final date = DateFormat('d MMM yyyy').format(_date);

    SmartDialog.show(
      builder: (_) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: radius,
                topRight: radius,
              ),
              color: Colours.darkBase,
            ),
            margin: const EdgeInsets.symmetric(horizontal: margin),
            padding: const EdgeInsets.all(21.0),
            child: RichText(
              text: TextSpan(
                style: GoogleFonts.jetBrainsMono(
                  color: Colours.text,
                  fontSize: 13.0,
                ),
                children: <TextSpan>[
                  const TextSpan(text: message),
                  TextSpan(
                    text: date,
                    style: GoogleFonts.jetBrainsMono(color: Colours.red),
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    // remove popup
                    SmartDialog.dismiss();
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(bottomLeft: radius),
                      color: Colours.text,
                    ),
                    margin: const EdgeInsets.only(left: margin),
                    padding: const EdgeInsets.all(13.0),
                    child: Text(
                      'Back',
                      style: GoogleFonts.jetBrainsMono(
                        color: Colours.darkBase,
                        fontSize: 13.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    // delete body index
                    final userId = context.read<User>().id;
                    _bodyIndexUseCase.deleteBodyIndex(
                      userId: userId,
                      bodyIndexId: _id!,
                    );
                    _emptyBodyIndexData();
                    // remove popup
                    SmartDialog.dismiss();
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(bottomRight: radius),
                      color: Colours.red,
                    ),
                    margin: const EdgeInsets.only(right: margin),
                    padding: const EdgeInsets.all(13.0),
                    child: Text(
                      'Confirm',
                      style: GoogleFonts.jetBrainsMono(
                        color: Colours.text,
                        fontSize: 13.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      clickMaskDismiss: true,
      maskColor: Colors.black.withOpacity(0.93),
    );
  }

  /// Convert each component data into [BodyIndexComponentView].
  List<BodyIndexComponentView> _convertDataToWidget(Map<String, dynamic> data) {
    List<BodyIndexComponentView> components = [];
    data.forEach((key, value) {
      BodyIndexComponent type = BodyIndexComponent.getType(key);
      if (type == BodyIndexComponent.gender) {
        value = Gender.fromString(value).pretty;
      }
      BodyIndexComponentView component = BodyIndexComponentView(
        name: type.pretty,
        notation: type.notation,
        value: value,
      );
      if (type != BodyIndexComponent.unknown) components.add(component);
    });
    return components;
  }
}

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

/// Body index component widget for view usage.
class BodyIndexComponentView extends StatelessWidget {
  const BodyIndexComponentView({
    Key? key,
    required this.name,
    this.notation,
    required this.value,
  }) : super(key: key);

  final String name;
  final String? notation;
  final Object value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Text>[
        Text(
          name,
          style: GoogleFonts.jetBrainsMono(
            color: Colours.darkText,
            fontSize: 13.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          notation != null ? "$value$notation" : "$value",
          style: GoogleFonts.jetBrainsMono(
            color: Colours.darkText,
            fontSize: 13.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
