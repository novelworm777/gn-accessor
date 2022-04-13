import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    Key? key,
    required this.name,
    this.inputStyle,
    this.hint,
    this.hintStyle,
    this.validators,
  }) : super(key: key);

  final String name;
  final TextStyle? inputStyle;
  final String? hint;
  final TextStyle? hintStyle;
  final List<String? Function(String?)>? validators;

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: name,
      initialValue: '',
      style: inputStyle,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: hintStyle,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFF818181),
            width: 2.0,
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFF89CA00),
            width: 2.0,
          ),
        ),
      ),
      validator: validators != null
          ? FormBuilderValidators.compose(validators!)
          : FormBuilderValidators.compose([]),
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}

class AppDateTimePicker extends StatelessWidget {
  const AppDateTimePicker({
    Key? key,
    required this.name,
  }) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 73.0),
      child: FormBuilderDateTimePicker(
        name: name,
        currentDate: DateTime.now(),
        initialTime: TimeOfDay(
          hour: DateTime.now().hour,
          minute: DateTime.now().minute,
        ),
        format: DateFormat('d MMM yy hh:mm a'),
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontFamily: 'PoorStory',
          fontSize: 19.0,
          color: Color(0xFFFFFFFF),
        ),
        inputType: InputType.both,
        decoration: const InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFF818181),
              width: 2.0,
            ),
          ),
        ),
        initialEntryMode: DatePickerEntryMode.calendarOnly,
      ),
    );
  }
}

class AppChoiceChip extends StatelessWidget {
  const AppChoiceChip({
    Key? key,
    required this.name,
    this.initialValue,
    required this.optionMapper,
    this.onChangeCallback,
    this.chipColourCallback,
  }) : super(key: key);

  final String name;
  final int? initialValue;
  final List<Map> optionMapper;
  final void Function(int?)? onChangeCallback;
  final Color Function(int)? chipColourCallback;

  @override
  Widget build(BuildContext context) {
    return FormBuilderChoiceChip<int>(
      name: name,
      initialValue: initialValue ?? optionMapper[0]['value'],
      backgroundColor: const Color(0xFF3B3B3B),
      selectedColor: const Color(0xFF89CA00),
      alignment: WrapAlignment.end,
      options: generateOptions(optionMapper),
      decoration: const InputDecoration(border: InputBorder.none),
      spacing: 13.0,
      onChanged: onChangeCallback,
    );
  }

  List<FormBuilderFieldOption<int>> generateOptions(List<Map> optionMapper) {
    List<FormBuilderFieldOption<int>> options = [];
    for (var element in optionMapper) {
      FormBuilderFieldOption<int> newOption = FormBuilderFieldOption(
        value: element['value'],
        child: Text(
          element['text'],
          style: TextStyle(
            fontFamily: 'PoorStory',
            fontSize: 19.0,
            color: chipColourCallback != null
                ? chipColourCallback!(element['value'])
                : Colors.white,
          ),
        ),
      );
      options.add(newOption);
    }
    return options;
  }
}
