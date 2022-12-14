import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../components/atoms/circular_button.dart';
import '../../components/templates/detail_screen.dart';
import '../../config/themes/colours.dart';
import '../../types/body_index_component.dart';
import '../../types/gender.dart';
import '../models/component.dart';
import '../models/user.dart';

const _kSpacing = SizedBox(height: 17.0);
const _kVariableComponent = [
  BodyIndexComponent.weight,
  BodyIndexComponent.bodyFatPercent,
  BodyIndexComponent.skeletalMusclePercent,
];
const _kFormulaComponent = [
  BodyIndexComponent.bodyFatKilo,
  BodyIndexComponent.skeletalMuscleKilo,
];

/// Screen to create a record of body index.
class BodyIndexFormScreen extends StatefulWidget {
  const BodyIndexFormScreen({Key? key}) : super(key: key);

  @override
  State<BodyIndexFormScreen> createState() => _BodyIndexFormScreenState();
}

class _BodyIndexFormScreenState extends State<BodyIndexFormScreen> {
  final List<Component> _components = [
    Component(type: BodyIndexComponent.gender),
    Component(type: BodyIndexComponent.age),
    Component(type: BodyIndexComponent.height),
  ];
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  bool _hasAllComponents = false;

  @override
  void initState() {
    super.initState();
    _initLockedComponents();
  }

  /// Get locked components value from database.
  void _initLockedComponents() async {
    final userId = context.read<User>().id;
    // TODO get locked components and add value as initial value
  }

  @override
  Widget build(BuildContext context) {
    return DetailScreen(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            FormBuilder(
              key: _formKey,
              child: ListView.separated(
                itemBuilder: ((context, index) =>
                    _generateComponentWidget(_components[index])),
                itemCount: _components.length,
                primary: false,
                separatorBuilder: ((context, index) => _kSpacing),
                shrinkWrap: true,
              ),
            ),
            if (!_hasAllComponents) _kSpacing,
            if (!_hasAllComponents)
              GestureDetector(
                onTap: () {
                  // show dropdown pop up
                  _showAddComponentDropdownPopUp();
                  // check whether all components are already added
                  if (_components.length == BodyIndexComponent.values.length) {
                    _hasAllComponents = true;
                  }
                },
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(7.0)),
                    color: Colours.green,
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 73.0),
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Icon(
                        FontAwesomeIcons.plus,
                        color: Colours.text,
                        size: 21.0,
                      ),
                      const SizedBox(width: 7.0),
                      Text(
                        "Add Component",
                        style: GoogleFonts.jetBrainsMono(
                          color: Colours.text,
                          fontSize: 13.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
      colour: Colours.darkBase,
      hasRightIconButton: true,
      rightIconColour: Colours.green,
      rightIconData: Icons.save,
      rightIconOnPress: () {
        // TODO create as new record
      },
    );
  }

  /// Generate component widget based on its component group.
  Widget _generateComponentWidget(Component component) {
    BodyIndexComponent componentType = component.type!;
    bool hasValue = component.value != null;

    if (BodyIndexComponent.isBasicProfile(component.type!)) {
      return BasicProfileComponentForm(
        componentType: componentType,
        initialValue: hasValue ? '${component.value}' : null,
        onChanged: (value) {
          setState(() => component.value = value);
        },
      );
    }
    return RecordComponentForm(
      componentType: componentType,
      deleteCallback: () {
        setState(() {
          // remove component from the list
          _components.remove(component);
          // remove component form value
          _formKey.currentState!.fields['$componentType']?.didChange(null);
        });
      },
      initialValue:
          hasValue ? num.parse(component.value).toStringAsFixed(2) : null,
      isDisabled: _checkDisabled(componentType),
      onChanged: (value) {
        setState(() => component.value = value);
        if (_kVariableComponent.contains(componentType)) {
          _recalculateAllFormulaComponents();
        }
      },
    );
  }

  /// Check whether component widget needs to be disabled.
  bool _checkDisabled(BodyIndexComponent componentType) {
    Map<BodyIndexComponent, bool> hasFormula = {
      BodyIndexComponent.bodyFatKilo: _bodyFatKiloHasFormula(),
      BodyIndexComponent.skeletalMuscleKilo: _skeletalMuscleHasFormula(),
    };

    if (!hasFormula.containsKey(componentType)) return false;
    return hasFormula[componentType]!;
  }

  /// Check whether body fat kilo should be from resulted calculation or not.
  bool _bodyFatKiloHasFormula() {
    final existing = _components.map((component) => component.type!).toList();
    if (existing.contains(BodyIndexComponent.weight) &&
        existing.contains(BodyIndexComponent.bodyFatPercent)) {
      return true;
    }
    return false;
  }

  /// Check whether skeletal muscle kilo should be from resulted calculation or not.
  bool _skeletalMuscleHasFormula() {
    final existing = _components.map((component) => component.type!).toList();
    if (existing.contains(BodyIndexComponent.weight) &&
        existing.contains(BodyIndexComponent.skeletalMusclePercent)) {
      return true;
    }
    return false;
  }

  /// Show a dropdown pop up for user to choose component.
  _showAddComponentDropdownPopUp() {
    SmartDialog.show(
      builder: (_) {
        // get available options (exclude components already added)
        final existing =
            _components.map((component) => component.type!).toList();
        var options = BodyIndexComponent.values.toList();
        options.removeWhere((option) =>
            existing.contains(option) || option == BodyIndexComponent.unknown);

        return Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(13.0)),
            color: Colours.text,
          ),
          height: 370.0,
          padding: const EdgeInsets.symmetric(horizontal: 17.0, vertical: 21.0),
          width: 210.0,
          child: ListView.separated(
            itemBuilder: ((context, index) {
              final option = options[index];
              return GestureDetector(
                onTap: () {
                  // add new component into the list
                  setState(() => _components.add(Component(type: option)));
                  // recalculate value for component which has formula
                  if (_kFormulaComponent.contains(option)) {
                    _recalculateAllFormulaComponents();
                  }
                  // remove popup
                  SmartDialog.dismiss();
                },
                child: Text(
                  option.pretty,
                  style: GoogleFonts.jetBrainsMono(
                    color: Colours.darkBase,
                    fontSize: _kFontSize,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            }),
            itemCount: options.length,
            separatorBuilder: ((context, index) => const Divider(
                  color: Colours.darkText,
                  thickness: 0.7,
                )),
          ),
        );
      },
      clickMaskDismiss: true,
      maskColor: Colors.black.withOpacity(0.93),
    );
  }

  /// Recalculate the value of components with formula.
  void _recalculateAllFormulaComponents() {
    _recalculationBodyFatKiloValue();
    _recalculationSkeletalMuscleKiloValue();
  }

  /// Recalculate body fat kilo value.
  void _recalculationBodyFatKiloValue() {
    // check whether the component exists
    final bodyFatKilo = _getComponent(BodyIndexComponent.bodyFatKilo);
    if (bodyFatKilo == null) return;

    // get variable components
    final weight = _getComponentValue(BodyIndexComponent.weight);
    final bodyFatPercent =
        _getComponentValue(BodyIndexComponent.bodyFatPercent);

    // recalculate value
    if (weight == null || bodyFatPercent == null) {
      setState(() {
        bodyFatKilo.value = null;
      });
      _formKey.currentState!.fields['${bodyFatKilo.type}']?.didChange(null);
    } else {
      setState(() {
        bodyFatKilo.value = (weight * bodyFatPercent / 100).toStringAsFixed(2);
      });
      _formKey.currentState!.fields['${bodyFatKilo.type}']
          ?.didChange('${bodyFatKilo.value}');
    }
  }

  /// Recalculate skeletal muscle kilo value.
  void _recalculationSkeletalMuscleKiloValue() {
    // check whether the component exists
    final skeletalMuscleKilo =
        _getComponent(BodyIndexComponent.skeletalMuscleKilo);
    if (skeletalMuscleKilo == null) return;

    // get variable components
    final weight = _getComponentValue(BodyIndexComponent.weight);
    final skeletalMusclePercent =
        _getComponentValue(BodyIndexComponent.skeletalMusclePercent);

    // recalculate value
    if (weight == null || skeletalMusclePercent == null) {
      setState(() {
        skeletalMuscleKilo.value = null;
      });
      _formKey.currentState!.fields['${skeletalMuscleKilo.type}']
          ?.didChange(null);
    } else {
      setState(() {
        skeletalMuscleKilo.value =
            (weight * skeletalMusclePercent / 100).toStringAsFixed(2);
      });
      _formKey.currentState!.fields['${skeletalMuscleKilo.type}']
          ?.didChange('${skeletalMuscleKilo.value}');
    }
  }

  /// Get value of certain existing component.
  num? _getComponentValue(BodyIndexComponent componentType) {
    final component = _getComponent(componentType);
    if (component == null) return null;
    final value = component.value;
    return value != null && value != '' ? num.parse(value) : null;
  }

  /// Get a component from existing components.
  Component? _getComponent(BodyIndexComponent componentType) {
    try {
      return _components.firstWhere((element) => element.type == componentType);
    } catch (e) {
      return null;
    }
  }
}

/// Component widget for basic profile components.
class BasicProfileComponentForm extends StatefulWidget {
  const BasicProfileComponentForm({
    Key? key,
    required this.componentType,
    this.initialValue,
    required this.onChanged,
  }) : super(key: key);

  final BodyIndexComponent componentType;
  final String? initialValue;
  final void Function(dynamic) onChanged;

  @override
  State<BasicProfileComponentForm> createState() =>
      _BasicProfileComponentFormState();
}

class _BasicProfileComponentFormState extends State<BasicProfileComponentForm> {
  bool isLocked = false;

  @override
  Widget build(BuildContext context) {
    return BodyIndexComponentForm(
      componentType: widget.componentType,
      iconButtonColour: Colours.lightBase,
      iconColour: Colours.text,
      iconData: isLocked ? FontAwesomeIcons.lock : FontAwesomeIcons.lockOpen,
      initialValue: widget.initialValue,
      isDisabled: isLocked,
      onChanged: widget.onChanged,
      onPress: () {
        setState(() => isLocked = !isLocked);
        // TODO update locked component value in database
      },
    );
  }
}

/// Component widget for body index and circumference components.
class RecordComponentForm extends StatelessWidget {
  const RecordComponentForm({
    Key? key,
    required this.componentType,
    required this.deleteCallback,
    this.initialValue,
    this.isDisabled = false,
    required this.onChanged,
  }) : super(key: key);

  final BodyIndexComponent componentType;
  final VoidCallback deleteCallback;
  final String? initialValue;
  final bool isDisabled;
  final void Function(dynamic) onChanged;

  @override
  Widget build(BuildContext context) {
    return BodyIndexComponentForm(
      componentType: componentType,
      iconButtonColour: Colours.red,
      iconColour: Colours.text,
      iconData: FontAwesomeIcons.solidTrashCan,
      initialValue: initialValue,
      isDisabled: isDisabled,
      onChanged: onChanged,
      onPress: deleteCallback,
    );
  }
}

const _kFontSize = 15.0;
const _kFormTextStyle = TextStyle(
  color: Colours.darkBase,
  fontSize: 15.0,
);

/// Body index component widget for form usage.
class BodyIndexComponentForm extends StatelessWidget {
  const BodyIndexComponentForm({
    Key? key,
    required this.componentType,
    this.initialValue,
    required this.iconButtonColour,
    required this.iconColour,
    required this.iconData,
    this.isDisabled = false,
    required this.onChanged,
    required this.onPress,
  }) : super(key: key);

  final BodyIndexComponent componentType;
  final String? initialValue;
  final Color iconButtonColour;
  final Color iconColour;
  final IconData iconData;
  final bool isDisabled;
  final void Function(dynamic) onChanged;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        SizedBox(
          width: 100,
          child: Text(
            componentType.pretty,
            softWrap: true,
            style: GoogleFonts.jetBrainsMono(
              color: Colours.darkText,
              fontSize: _kFontSize,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Row(
          children: <Widget>[
            SizedBox(
              width: 100.0,
              child: _generateForm(),
            ),
            if (componentType.notation != null) const SizedBox(width: 13.0),
            if (componentType.notation != null)
              Text(
                componentType.notation!.trim(),
                style: GoogleFonts.jetBrainsMono(
                  color: Colours.darkText,
                  fontSize: _kFontSize,
                  fontWeight: FontWeight.w500,
                ),
              ),
            const SizedBox(width: 13.0),
            CircularButton(
              colour: iconButtonColour,
              icon: Icon(
                iconData,
                color: iconColour,
                size: 13.0,
              ),
              onPress: onPress,
              size: 28.0,
            ),
          ],
        ),
      ],
    );
  }

  /// Generate form based on its component type.
  Widget _generateForm() {
    switch (componentType) {
      case BodyIndexComponent.gender:
        return FormBuilderDropdown(
          decoration: _getFormDecoration(),
          dropdownColor: Colours.text,
          enabled: !isDisabled,
          iconSize: 0,
          initialValue: initialValue,
          itemHeight: 49.0,
          items: Gender.values
              .map((element) => DropdownMenuItem(
                    value: element.toString(),
                    child: Text(element.pretty),
                  ))
              .toList(),
          name: componentType.toString(),
          onChanged: onChanged,
          style: _kFormTextStyle,
        );
      default:
        return FormBuilderTextField(
          decoration: _getFormDecoration(),
          enabled: !isDisabled,
          initialValue: initialValue,
          name: componentType.toString(),
          onChanged: onChanged,
          readOnly: isDisabled,
          showCursor: false,
          style: _kFormTextStyle,
          textAlign: TextAlign.right,
        );
    }
  }

  /// Get default decoration for forms.
  InputDecoration _getFormDecoration() {
    return InputDecoration(
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 13.0,
        vertical: 7.0,
      ),
      disabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(7.0)),
        borderSide: BorderSide.none,
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(7.0)),
        borderSide: BorderSide.none,
      ),
      filled: true,
      fillColor: isDisabled ? const Color(0xFFC3C3C3) : Colours.text,
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(7.0)),
        borderSide: BorderSide(
          color: Colours.darkText,
          strokeAlign: StrokeAlign.center,
          width: 3.0,
        ),
      ),
    );
  }
}
