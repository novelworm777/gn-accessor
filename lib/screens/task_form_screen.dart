import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gn_accessor/screens/task_board_screen.dart';
import 'package:gn_accessor/services/task_board.dart';
import 'package:gn_accessor/services/user.dart';
import 'package:provider/provider.dart';

import '../components/atoms/app_back_button.dart';
import '../components/atoms/app_input_form.dart';
import '../components/atoms/chip_button.dart';
import '../components/atoms/mobile_screen.dart';

class TaskFormScreen extends StatefulWidget {
  const TaskFormScreen({Key? key}) : super(key: key);

  static const String id = '/task-board/form';

  @override
  State<TaskFormScreen> createState() => _TaskFormScreenState();
}

class _TaskFormScreenState extends State<TaskFormScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool _selected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // un-focus input keyboard on blur
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        if (_selected) rewardCallback();
        _formKey.currentState?.fields['reward']?.reset();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: MobileScreen(
            colour: const Color(0xFF2E2E2E),
            child: FormBuilder(
              key: _formKey,
              child: Column(
                children: [
                  _TaskFormHeader(formKey: _formKey),
                  const SizedBox(height: 30.0),
                  const _TitleForm(),
                  const SizedBox(height: 24.0),
                  const _NotesForm(),
                  const SizedBox(height: 24.0),
                  const _DueDateTimeForm(),
                  const SizedBox(height: 24.0),
                  const _AvailableForm(),
                  const SizedBox(height: 24.0),
                  _RewardForm(selected: _selected, callback: rewardCallback),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void rewardCallback() {
    setState(() => _selected = !_selected);
  }
}

class _RewardForm extends StatefulWidget {
  const _RewardForm({
    Key? key,
    required this.selected,
    required this.callback,
  }) : super(key: key);

  final bool selected;
  final VoidCallback callback;

  @override
  State<_RewardForm> createState() => _RewardFormState();
}

class _RewardFormState extends State<_RewardForm> {
  int _value = 0;

  @override
  Widget build(BuildContext context) {
    bool _selected = widget.selected;

    return Row(
      children: [
        const Expanded(
          child: Text(
            'Reward Coins',
            style: TextStyle(
              fontFamily: 'PoorStory',
              fontSize: 19.0,
              color: Color(0xFFFFFFFF),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MaskImageButton(
                onPressed: _subOneValue,
                imagePath: 'assets/form/icon-arrow-down.png',
                isDisabled: true,
              ),
              const SizedBox(width: 3.0),
              _selected
                  ? AppTextField(
                      name: 'reward',
                      initialValue: '$_value',
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      inputStyle: const TextStyle(
                        fontFamily: 'PoorStory',
                        fontSize: 19.0,
                        color: Color(0xFFFFFFFF),
                      ),
                      textAlign: TextAlign.center,
                      width: 33,
                      // enabledBorder: InputBorder.none,
                      // focusedBorder: InputBorder.none,
                      keyboardType: TextInputType.number,
                      autoFocus: true,
                      onChange: (value) {
                        setState(() {
                          if (value != null) {
                            _value = int.parse(value);
                          }
                        });
                      },
                    )
                  : ActionChip(
                      onPressed: () {
                        setState(() {
                          widget.callback();
                        });
                      },
                      label: Text(
                        '$_value',
                        style: const TextStyle(
                          fontFamily: 'PoorStory',
                          fontSize: 19.0,
                          color: Color(0xFFFFFFFF),
                        ),
                      ),
                      backgroundColor: const Color(0xFF3B3B3B),
                      shape: const RoundedRectangleBorder(
                        side: BorderSide(width: 0.0, color: Color(0xFF3B3B3B)),
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      ),
                    ),
              const SizedBox(width: 3.0),
              MaskImageButton(
                onPressed: _addOneValue,
                imagePath: 'assets/form/icon-arrow-up.png',
                isDisabled: true,
              ),
              const SizedBox(width: 13.0),
              Image.asset(
                'assets/general/icon-coin.png',
                height: 33,
                width: 33,
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _addOneValue() {
    setState(() {
      _value += 1;
    });
  }

  void _subOneValue() {
    setState(() {
      _value -= 1;
      if (_value < 0) _value = 0;
    });
  }
}

class MaskImageButton extends StatelessWidget {
  const MaskImageButton({
    Key? key,
    required this.onPressed,
    required this.imagePath,
    this.isDisabled = false,
  }) : super(key: key);

  final VoidCallback onPressed;
  final String imagePath;
  final bool isDisabled;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: !isDisabled ? onPressed : null,
      child: ColorFiltered(
        colorFilter: ColorFilter.mode(
          !isDisabled ? const Color(0xFF89CA00) : const Color(0xFF969696),
          BlendMode.srcIn,
        ),
        child: Image.asset(
          imagePath,
          height: 33.0,
          width: 33.0,
        ),
      ),
    );
  }
}

class _TaskFormHeader extends StatelessWidget {
  _TaskFormHeader({
    Key? key,
    required GlobalKey<FormBuilderState> formKey,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormBuilderState> _formKey;
  final _taskBoard = TaskBoard();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const AppBackButton(),
        ChipButton(
          title: 'Create',
          colour: const Color(0xFF3B3B3B),
          dropShadow: false,
          onPress: () async {
            final validationSuccess = _formKey.currentState!.validate();

            if (validationSuccess) {
              _formKey.currentState!.save();
              final formData = _formKey.currentState!.value;
              print(formData);
              await _taskBoard.addTask(context.read<User>().uid!, formData);
              Navigator.pushNamed(context, TaskBoardScreen.id,
                  arguments: 'Task has been successfully created.');
            }
          },
        ),
      ],
    );
  }
}

class _TitleForm extends StatelessWidget {
  const _TitleForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      name: 'title',
      inputStyle: const TextStyle(
        fontFamily: 'PoorStory',
        fontSize: 19.0,
        fontWeight: FontWeight.bold,
        color: Color(0xFFFFFFFF),
      ),
      hint: 'What is the task called? (required)',
      hintStyle: const TextStyle(
        fontFamily: 'PoorStory',
        fontSize: 19.0,
        fontWeight: FontWeight.bold,
        color: Color(0xFF818181),
      ),
      validators: [FormBuilderValidators.required(errorText: '')],
    );
  }
}

class _NotesForm extends StatelessWidget {
  const _NotesForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AppTextField(
      name: 'notes',
      inputStyle: TextStyle(
        fontFamily: 'PoorStory',
        fontSize: 19.0,
        color: Color(0xFFFFFFFF),
        // overflow: TextOverflow.clip,
      ),
      hint: 'Anything to note?',
      hintStyle: TextStyle(
        fontFamily: 'PoorStory',
        fontSize: 19.0,
        color: Color(0xFF818181),
      ),
    );
  }
}

class _DueDateTimeForm extends StatefulWidget {
  const _DueDateTimeForm({Key? key}) : super(key: key);

  @override
  State<_DueDateTimeForm> createState() => _DueDateTimeFormState();
}

class _DueDateTimeFormState extends State<_DueDateTimeForm> {
  var dueChoice = 1;
  bool pickTime = false;

  List<Map> dueOptions = [
    {'value': 1, 'text': 'None'},
    {'value': 2, 'text': 'Pick a Time & Date'},
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Expanded(
          child: Text(
            'Due Date',
            style: TextStyle(
              fontFamily: 'PoorStory',
              fontSize: 19.0,
              color: Color(0xFFFFFFFF),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Column(
            children: [
              AppChoiceChip(
                name: 'due',
                optionMapper: dueOptions,
                chipColourCallback: _dueDateColourChoice,
                onChangeCallback: (value) {
                  _dueDateTimeOnChange(value);
                },
              ),
              pickTime
                  ? const AppDateTimePicker(name: 'due_date_time')
                  : Container(),
            ],
          ),
        ),
      ],
    );
  }

  Color _dueDateColourChoice(var value) {
    if (dueChoice == value) {
      return const Color(0xFFFFFFFF);
    }
    return const Color(0xFF818181);
  }

  void _dueDateTimeOnChange(int? value) {
    setState(() {
      if (value == null) {
        dueChoice = 0;
        pickTime = false;
      } else if (value == 1) {
        dueChoice = 1;
        pickTime = false;
      } else {
        dueChoice = value;
        pickTime = true;
      }
    });
  }
}

class _AvailableForm extends StatefulWidget {
  const _AvailableForm({Key? key}) : super(key: key);

  @override
  State<_AvailableForm> createState() => _AvailableFormState();
}

class _AvailableFormState extends State<_AvailableForm> {
  var availableChoice = 1;
  bool pickNumber = false;

  List<Map> availableOptions = [
    {'value': 1, 'text': 'Once'},
    {'value': 2, 'text': 'Pick a Number'},
    {'value': 3, 'text': 'Infinite'},
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Expanded(
          child: Text(
            'Available',
            style: TextStyle(
              fontFamily: 'PoorStory',
              fontSize: 19.0,
              color: Color(0xFFFFFFFF),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Column(
            children: [
              AppChoiceChip(
                name: 'avail',
                optionMapper: availableOptions,
                chipColourCallback: _availableColourChoice,
                onChangeCallback: (value) {
                  _availableOnChange(value);
                },
              ),
              pickNumber
                  ? const AppTextField(
                      name: 'available',
                      padding: EdgeInsets.only(left: 170.0),
                      inputStyle: TextStyle(
                        fontFamily: 'PoorStory',
                        fontSize: 19.0,
                        color: Color(0xFFFFFFFF),
                        // overflow: TextOverflow.clip,
                      ),
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                    )
                  : Container(),
            ],
          ),
        ),
      ],
    );
  }

  Color _availableColourChoice(var value) {
    if (availableChoice == value) {
      return const Color(0xFFFFFFFF);
    }
    return const Color(0xFF818181);
  }

  void _availableOnChange(int? value) {
    setState(() {
      if (value == null) {
        availableChoice = 0;
        pickNumber = false;
      } else if (value == 1 || value == 3) {
        availableChoice = value;
        pickNumber = false;
      } else {
        availableChoice = value;
        pickNumber = true;
      }
    });
  }
}
