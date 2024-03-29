import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gn_accessor/components/atoms/diamond.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../components/atoms/underline.dart';
import '../../../components/templates/colour_default_screen.dart';
import '../../../domain/usecases/diary_usecase.dart';
import '../../../utils/helpers/ordinal_number.dart';
import '../../models/diary.dart';
import '../../models/user.dart';

/// Screen to edit a diary page content.
class DiaryPageEditScreen extends StatefulWidget {
  const DiaryPageEditScreen({Key? key, this.id}) : super(key: key);

  final String? id;

  @override
  State<DiaryPageEditScreen> createState() => _DiaryPageEditScreenState();
}

class _DiaryPageEditScreenState extends State<DiaryPageEditScreen> {
  final _diaryUsecase = DiaryUsecase();
  final _formKey = GlobalKey<FormBuilderState>();

  late DiaryPage page;

  @override
  void initState() {
    super.initState();
    if (widget.id == null) {
      _createDiaryPage();
    }
  }

  /// Create a new diary page in database.
  void _createDiaryPage() async {
    final userId = context.read<User>().id;
    final res = await _diaryUsecase.createDiaryPage(userId: userId);
    setState(() => page = DiaryPage.fromMap(res));
  }

  @override
  Widget build(BuildContext context) {
    const primaryColour = Color(0xFFF9F7FF);
    const secondaryColour = Color(0xFF374259);
    const tertiaryColour = Color(0xFF5837D0);

    String monthDay = DateFormat('MMMMd').format(page.date);
    String year = DateFormat('y').format(page.date);
    String ordinalNumberSuffix = OrdinalNumber.nthNumber(page.date.day);

    return ColourDefaultScreen(
      colour: primaryColour,
      padding: const EdgeInsets.only(left: 13.0, right: 13.0, top: 33.0),
      resizeToAvoidBottomInset: true,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: Row(
              children: <Widget>[
                CustomPaint(
                  painter: DiamondUnderline(colour: secondaryColour),
                  child: Container(
                    padding: const EdgeInsets.only(
                      bottom: 17.0,
                      left: 7.0,
                      right: 33.0,
                    ),
                    child: Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () async {
                            // show date picker and pick a date
                            DateTime? newDate = await showDatePicker(
                                context: context,
                                initialDate: page.date,
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2100),
                                builder: (context, child) {
                                  return Theme(
                                    data: ThemeData(
                                      colorScheme: const ColorScheme.light(
                                        primary: secondaryColour,
                                        onPrimary: primaryColour,
                                        onSurface: tertiaryColour,
                                      ),
                                    ),
                                    child: child!,
                                  );
                                });
                            // no change
                            if (newDate == null) return;
                            // change diary page date
                            if (page.date != newDate) {
                              _updateDiaryPageDate(newDate);
                            }
                          },
                          child: const Icon(
                            FontAwesomeIcons.calendarDay,
                            color: secondaryColour,
                            size: 21.0,
                          ),
                        ),
                        const SizedBox(width: 13.0),
                        Text(
                          '$monthDay$ordinalNumberSuffix, $year',
                          style: GoogleFonts.jetBrainsMono(
                            color: secondaryColour,
                            fontSize: 15.0,
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
          const SizedBox(height: 13.0),
          FormBuilder(
            key: _formKey,
            child: Expanded(
              child: ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  var isCell = index < page.sections.length;
                  return isCell
                      ? CustomPaint(
                          painter: SectionOutlineContainer(
                            colour: secondaryColour,
                          ),
                          child: _viewSectionItems(
                            sectionIndex: index,
                            colour: secondaryColour,
                            addCellOnPress: () => _addDiaryCell(index),
                          ),
                        )
                      : _AddSectionButton(
                          colour: secondaryColour,
                          onPress: _addDiarySection,
                        );
                },
                itemCount: page.sections.length + 1,
                scrollDirection: Axis.vertical,
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(height: 13.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Update the diary page date in database.
  void _updateDiaryPageDate(date) async {
    final userId = context.read<User>().id;
    await _diaryUsecase.updateDiaryPageDate(
      userId: userId,
      pageId: page.id,
      date: date,
    );
    setState(() => page.date = date);
  }

  /// View section items.
  _Section _viewSectionItems({sectionIndex, colour, addCellOnPress}) {
    var section = page.sections[sectionIndex];
    var cells = <_Cell>[];
    for (var index = 0; index < section.cells.length; index++) {
      var cell = _Cell(
        cell: section.cells[index],
        colour: colour,
        onChangeText: (value) {
          _updateDiaryCellText(sectionIndex, index, value);
        },
        onLongPress: () => _showActionPopup(
          onDeleteCell: () {
            _removeDiaryCell(sectionIndex, index);
            SmartDialog.dismiss();
          },
          onDeleteSection: () {
            _removeDiarySection(sectionIndex);
            SmartDialog.dismiss();
          },
        ),
      );
      cells.add(cell);
    }
    return _Section(
      addCellButton: _AddCellButton(onPress: addCellOnPress, colour: colour),
      cells: cells,
    );
  }

  /// Update the diary cell text in database and local.
  void _updateDiaryCellText(sectionIndex, cellIndex, text) async {
    final userId = context.read<User>().id;
    await _diaryUsecase.updateDiaryCellText(
      userId: userId,
      pageId: page.id,
      sectionIndex: sectionIndex,
      cellIndex: cellIndex,
      text: text,
    );
    setState(() => page.sections[sectionIndex].cells[cellIndex].text = text);
  }

  /// Show popup for actions.
  void _showActionPopup({onDeleteCell, onDeleteSection}) {
    SmartDialog.show(
      builder: (_) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _ActionButton(
              text: 'Delete cell',
              onPress: onDeleteCell,
            ),
            const SizedBox(height: 13.0),
            _ActionButton(
              text: 'Delete section',
              onPress: onDeleteSection,
            ),
          ],
        );
      },
      clickMaskDismiss: true,
      maskColor: Colors.white.withOpacity(0.93),
    );
  }

  /// Remove diary cell in database and local.
  void _removeDiaryCell(sectionIndex, cellIndex) async {
    final userId = context.read<User>().id;
    await _diaryUsecase.removeDiaryCell(
      userId: userId,
      pageId: page.id,
      sectionIndex: sectionIndex,
      cellIndex: cellIndex,
    );
    setState(() => page.sections[sectionIndex].cells.removeAt(cellIndex));
  }

  /// Remove diary section in database and local.
  void _removeDiarySection(sectionIndex) async {
    final userId = context.read<User>().id;
    await _diaryUsecase.removeDiarySection(
      userId: userId,
      pageId: page.id,
      sectionIndex: sectionIndex,
    );
    setState(() => page.sections.removeAt(sectionIndex));
  }

  /// Add diary cell in database and local.
  void _addDiaryCell(sectionIndex) async {
    final userId = context.read<User>().id;
    await _diaryUsecase.addDiaryCell(
      userId: userId,
      pageId: page.id,
      sectionIndex: sectionIndex,
    );
    setState(() => page.sections[sectionIndex].cells.add(DiaryCell(
          name: UniqueKey(),
        )));
  }

  /// Add diary section in database and local.
  void _addDiarySection() async {
    final userId = context.read<User>().id;
    await _diaryUsecase.addDiarySection(userId: userId, pageId: page.id);
    setState(() => page.sections.add(DiarySection(cells: [
          DiaryCell(name: UniqueKey()),
        ])));
  }
}

/// Action button view.
class _ActionButton extends StatelessWidget {
  const _ActionButton({
    Key? key,
    required this.text,
    required this.onPress,
  }) : super(key: key);

  final String text;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    const primaryColour = Color(0xFFF9F7FF);
    const secondaryColour = Color(0xFF374259);

    return GestureDetector(
      onTap: onPress,
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(3.0)),
          color: secondaryColour,
        ),
        padding: const EdgeInsets.all(13.0),
        width: 250.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            CustomPaint(
              painter: Diamond(colour: primaryColour),
              child: const SizedBox(
                height: 21.0,
                width: 21.0,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 13.0),
              child: Text(
                text,
                style: GoogleFonts.jetBrainsMono(
                  color: primaryColour,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Diary section container view.
class _Section extends StatelessWidget {
  const _Section({
    Key? key,
    required this.addCellButton,
    required this.cells,
  }) : super(key: key);

  final Widget addCellButton;
  final List<_Cell> cells;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(17.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[...cells, addCellButton],
      ),
    );
  }
}

/// Diary cell container view.
class _Cell extends StatelessWidget {
  const _Cell({
    Key? key,
    required this.cell,
    required this.colour,
    required this.onChangeText,
    required this.onLongPress,
  }) : super(key: key);

  final DiaryCell cell;
  final Color colour;
  final void Function(dynamic) onChangeText;
  final VoidCallback onLongPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: onLongPress,
      child: CustomPaint(
        painter: CellOutlineContainer(colour: colour),
        child: Padding(
          padding: const EdgeInsets.all(21.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 7.0),
                child: CustomPaint(
                  painter: Diamond(colour: colour),
                  child: const SizedBox(height: 20.0, width: 20.0 * 0.8),
                ),
              ),
              FormBuilderTextField(
                cursorColor: colour,
                decoration: InputDecoration(
                  isDense: true,
                  hintText: '...',
                  hintStyle: GoogleFonts.jetBrainsMono(
                    color: colour.withOpacity(0.3),
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500,
                  ),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
                maxLines: null,
                name: '${cell.name}-text',
                onChanged: onChangeText,
                style: GoogleFonts.jetBrainsMono(
                  color: colour,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 7.0),
                child: CustomPaint(
                  painter: Diamond(colour: colour),
                  child: const SizedBox(height: 20.0, width: 20.0 * 0.8),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String nameFormat(object, index, field) => '$object-$index-$field';

/// Button for adding new cell.
class _AddCellButton extends StatelessWidget {
  const _AddCellButton({
    Key? key,
    required this.colour,
    required this.onPress,
  }) : super(key: key);

  final Color colour;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 7.0),
      child: GestureDetector(
        onTap: onPress,
        child: Center(
          child: CustomPaint(
            painter: AddCellButtonContainer(colour: colour),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 33.0,
                vertical: 7.0,
              ),
              child: Text(
                'Add cell...',
                style: GoogleFonts.jetBrainsMono(
                  color: colour,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Button for adding new section.
class _AddSectionButton extends StatelessWidget {
  const _AddSectionButton({
    Key? key,
    required this.colour,
    required this.onPress,
  }) : super(key: key);

  final Color colour;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 33.0),
      child: GestureDetector(
        onTap: onPress,
        child: Center(
          child: CustomPaint(
            painter: AddSectionButtonContainer(colour: colour),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 33.0,
                vertical: 7.0,
              ),
              child: Text(
                'Add section...',
                style: GoogleFonts.jetBrainsMono(
                  color: colour,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SectionOutlineContainer extends CustomPainter {
  final Color colour;

  SectionOutlineContainer({required this.colour});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = colour.withOpacity(0.3)
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    var diamondSize = 13.0;
    var path = Path()
      ..moveTo(diamondSize, diamondSize / 2)
      ..lineTo(diamondSize / 2, diamondSize)
      ..lineTo(0.0, diamondSize / 2)
      ..lineTo(diamondSize / 2, 0.0)
      ..lineTo(diamondSize, diamondSize / 2)
      ..lineTo(size.width, diamondSize / 2)
      ..lineTo(size.width, size.height)
      ..lineTo(diamondSize / 2, size.height)
      ..lineTo(diamondSize / 2, diamondSize + diamondSize / 2);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class CellOutlineContainer extends CustomPainter {
  final Color colour;

  CellOutlineContainer({required this.colour});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = colour.withOpacity(0.7)
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    var diamondSize = 13.0;
    var path = Path()
      ..moveTo(diamondSize / 2, diamondSize / 2)
      ..lineTo(size.width, diamondSize / 2)
      ..lineTo(size.width, size.height - diamondSize / 2)
      ..lineTo(diamondSize / 2, size.height - diamondSize / 2)
      ..lineTo(diamondSize / 2, diamondSize / 2);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class AddSectionButtonContainer extends CustomPainter {
  final Color colour;

  AddSectionButtonContainer({required this.colour});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = colour.withOpacity(0.3)
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    var diamondSize = 13.0;
    var path = Path()
      ..moveTo(diamondSize / 2, 0.0)
      ..lineTo(size.width - diamondSize / 2, 0.0)
      ..lineTo(size.width - diamondSize / 2, size.height / 2 - diamondSize / 2)
      ..lineTo(size.width - diamondSize, size.height / 2)
      ..lineTo(size.width - diamondSize / 2, size.height / 2 + diamondSize / 2)
      ..lineTo(size.width, size.height / 2)
      ..lineTo(size.width - diamondSize / 2, size.height / 2 - diamondSize / 2)
      ..moveTo(size.width - diamondSize / 2, size.height / 2 + diamondSize / 2)
      ..lineTo(size.width - diamondSize / 2, size.height)
      ..lineTo(diamondSize / 2, size.height)
      ..lineTo(diamondSize / 2, size.height / 2 + diamondSize / 2)
      ..lineTo(diamondSize, size.height / 2)
      ..lineTo(diamondSize / 2, size.height / 2 - diamondSize / 2)
      ..lineTo(0.0, size.height / 2)
      ..lineTo(diamondSize / 2, size.height / 2 + diamondSize / 2)
      ..moveTo(diamondSize / 2, size.height / 2 - diamondSize / 2)
      ..lineTo(diamondSize / 2, 0.0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class AddCellButtonContainer extends CustomPainter {
  final Color colour;

  AddCellButtonContainer({required this.colour});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = colour.withOpacity(0.7)
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    var diamondSize = 13.0;
    var path = Path()
      ..moveTo(diamondSize / 2, 0.0)
      ..lineTo(size.width - diamondSize / 2, 0.0)
      ..lineTo(size.width - diamondSize / 2, size.height / 2 - diamondSize / 2)
      ..lineTo(size.width - diamondSize, size.height / 2)
      ..lineTo(size.width - diamondSize / 2, size.height / 2 + diamondSize / 2)
      ..lineTo(size.width, size.height / 2)
      ..lineTo(size.width - diamondSize / 2, size.height / 2 - diamondSize / 2)
      ..moveTo(size.width - diamondSize / 2, size.height / 2 + diamondSize / 2)
      ..lineTo(size.width - diamondSize / 2, size.height)
      ..lineTo(diamondSize / 2, size.height)
      ..lineTo(diamondSize / 2, size.height / 2 + diamondSize / 2)
      ..lineTo(diamondSize, size.height / 2)
      ..lineTo(diamondSize / 2, size.height / 2 - diamondSize / 2)
      ..lineTo(0.0, size.height / 2)
      ..lineTo(diamondSize / 2, size.height / 2 + diamondSize / 2)
      ..moveTo(diamondSize / 2, size.height / 2 - diamondSize / 2)
      ..lineTo(diamondSize / 2, 0.0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
