import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: Row(
              children: <Widget>[
                CustomPaint(
                  painter: DateUnderline(colour: secondaryColour),
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
          Expanded(
            child: ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                var isCell = index < page.sections.length;
                return isCell
                    ? CustomPaint(
                        painter: SectionOutlineContainer(
                          colour: secondaryColour,
                        ),
                        child: _viewSectionItems(
                          section: page.sections[index],
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
  _Section _viewSectionItems({section, colour, addCellOnPress}) {
    return _Section(
      addCellButton: _AddCellButton(onPress: addCellOnPress, colour: colour),
      cells: section.cells
          .map<_Cell>((cell) => _Cell(cell: cell, colour: colour))
          .toList(),
    );
  }

  /// Add diary cell in database and local.
  void _addDiaryCell(sectionIndex) async {
    final userId = context.read<User>().id;
    await _diaryUsecase.addDiaryCell(
      userId: userId,
      pageId: page.id,
      sectionIndex: sectionIndex,
    );
    setState(() => page.sections[sectionIndex].cells.add(DiaryCell()));
  }

  /// Add diary section in database and local.
  void _addDiarySection() async {
    final userId = context.read<User>().id;
    await _diaryUsecase.addDiarySection(userId: userId, pageId: page.id);
    setState(() => page.sections.add(DiarySection(cells: [DiaryCell()])));
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
  }) : super(key: key);

  final DiaryCell cell;
  final Color colour;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: CellOutlineContainer(colour: colour),
      child: Container(
        padding: const EdgeInsets.all(17.0),
        child: Text(
          cell.text ?? '...',
          style: GoogleFonts.jetBrainsMono(
            color: colour.withOpacity(0.3),
            fontSize: 15.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

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

class DateUnderline extends CustomPainter {
  final Color colour;

  DateUnderline({required this.colour});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = colour
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    var diamondSize = 13.0;
    var path = Path()
      ..moveTo(0.0, size.height - diamondSize / 2)
      ..lineTo(size.width - diamondSize, size.height - diamondSize / 2)
      ..lineTo(size.width - diamondSize / 2, size.height - diamondSize)
      ..lineTo(size.width, size.height - diamondSize / 2)
      ..lineTo(size.width - diamondSize / 2, size.height)
      ..lineTo(size.width - diamondSize, size.height - diamondSize / 2);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
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
