import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../components/atoms/circular_button.dart';
import '../../components/templates/detail_screen.dart';
import '../../config/themes/colours.dart';
import '../models/user.dart';

/// Body index component types.
enum _BodyIndexComponentType {
  gender("Gender", null),
  age("Age", " Y/O"),
  height("Height", "cm"),
  weight("Weight", "kg"),
  bodyAge("Body Age", null),
  bodyMassIndex("BMI", null),
  bodyFatPercent("Body Fat (%)", "%"),
  bodyFatKilo("Body Fat (kg)", "kg"),
  skeletalMusclePercent("Skeletal Muscle (%)", "%"),
  skeletalMuscleKilo("Skeletal Muscle (kg)", "kg"),
  visceralFat("Visceral Fat", null),
  antioxidantValue("Antioxidant Value", null),
  basalMetabolicRate("BMR", "kcal/day"),
  navel("Navel", "cm"),
  waistline("Waistline", "cm"),
  abdomen("Abdomen", "cm"),
  hip("Hip", "cm"),
  leftUpperArm("Upper Left Arm", "cm"),
  rightUpperArm("Upper Right Arm", "cm"),
  leftThigh("Left Thigh", "cm"),
  rightThigh("Right Thigh", "cm"),
  leftCalf("Left Calf", "cm"),
  rightCalf("Right Calf", "cm"),
  unknown("???", null);

  const _BodyIndexComponentType(this.name, this.notation);
  final String name;
  final String? notation;

  /// Get [_BodyIndexComponentType] by key.
  static _BodyIndexComponentType getType(String key) {
    switch (key) {
      case "gender":
        return _BodyIndexComponentType.gender;
      case "age":
        return _BodyIndexComponentType.age;
      case "height":
        return _BodyIndexComponentType.height;
      case "weight":
        return _BodyIndexComponentType.weight;
      case "body_age":
        return _BodyIndexComponentType.bodyAge;
      case "body_mass_index":
        return _BodyIndexComponentType.bodyMassIndex;
      case "body_fat_percent":
        return _BodyIndexComponentType.bodyFatPercent;
      case "body_fat_kilo":
        return _BodyIndexComponentType.bodyFatKilo;
      case "skeletal_muscle_percent":
        return _BodyIndexComponentType.skeletalMusclePercent;
      case "skeletal_muscle_kilo":
        return _BodyIndexComponentType.skeletalMuscleKilo;
      case "visceral_fat":
        return _BodyIndexComponentType.visceralFat;
      case "antioxidant_value":
        return _BodyIndexComponentType.antioxidantValue;
      case "basal_metabolic_rate":
        return _BodyIndexComponentType.basalMetabolicRate;
      case "navel":
        return _BodyIndexComponentType.navel;
      case "waistline":
        return _BodyIndexComponentType.waistline;
      case "abdomen":
        return _BodyIndexComponentType.abdomen;
      case "hip":
        return _BodyIndexComponentType.hip;
      case "left_upper_arm":
        return _BodyIndexComponentType.leftUpperArm;
      case "right_upper_arm":
        return _BodyIndexComponentType.rightUpperArm;
      case "left_thigh":
        return _BodyIndexComponentType.leftThigh;
      case "right_thigh":
        return _BodyIndexComponentType.rightThigh;
      case "left_calf":
        return _BodyIndexComponentType.leftCalf;
      case "right_calf":
        return _BodyIndexComponentType.rightCalf;
      default:
        return _BodyIndexComponentType.unknown;
    }
  }
}

/// Gender types.
enum _Gender {
  male("Male"),
  female("Female");

  const _Gender(this.pretty);
  final String pretty;

  static _Gender fromString(String str) {
    return _Gender.values
        .firstWhere((element) => element.toString() == '$_Gender.$str');
  }
}

/// Screen for body index record details.
class BodyIndexScreen extends StatefulWidget {
  const BodyIndexScreen({Key? key}) : super(key: key);

  @override
  State<BodyIndexScreen> createState() => _BodyIndexScreenState();
}

class _BodyIndexScreenState extends State<BodyIndexScreen> {
  final double _spacing = 17.0;

  DateTime _date = DateTime.now();
  bool _hasRecord = false;
  Map<String, dynamic> _basicProfileData = {
    "gender": "female",
    "age": 21,
    "height": 155,
  };
  Map<String, dynamic> _bodyIndexData = {};
  Map<String, dynamic> _circumferenceData = {};

  @override
  void initState() {
    super.initState();
    _initRecord();
  }

  /// Get record from database.
  void _initRecord() async {
    final userId = context.read<User>().id;
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
                  const Icon(
                    FontAwesomeIcons.solidCalendarDays,
                    color: Colours.darkText,
                    size: 21.0,
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
                  ? const Icon(
                      FontAwesomeIcons.solidTrashCan,
                      color: Colours.red,
                      size: 21.0,
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
                        onPress: () {},
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

  /// Convert each component data into [BodyIndexComponent].
  List<BodyIndexComponent> _convertDataToWidget(Map<String, dynamic> data) {
    List<BodyIndexComponent> components = [];
    data.forEach((key, value) {
      _BodyIndexComponentType type = _BodyIndexComponentType.getType(key);
      if (type == _BodyIndexComponentType.gender) {
        value = _Gender.fromString(value).pretty;
      }
      BodyIndexComponent component = BodyIndexComponent(
        name: type.name,
        notation: type.notation,
        value: value,
      );
      if (type != _BodyIndexComponentType.unknown) components.add(component);
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

  final List<BodyIndexComponent> components;
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
class BodyIndexComponent extends StatelessWidget {
  const BodyIndexComponent({
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
