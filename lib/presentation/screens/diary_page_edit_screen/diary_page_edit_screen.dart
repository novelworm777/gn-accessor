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
      padding: const EdgeInsets.symmetric(horizontal: 13.0, vertical: 33.0),
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
                            _updateDiaryPageDate(newDate);
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
                var section = page.sections[index];
                return CustomPaint(
                  painter: SectionOutlineContainer(colour: secondaryColour),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: section.cells
                        .map<Widget>((cell) => Padding(
                              padding: const EdgeInsets.all(17.0),
                              child: CustomPaint(
                                painter: CellOutlineContainer(
                                    colour: secondaryColour),
                                child: Container(
                                  padding: const EdgeInsets.all(17.0),
                                  child: Text(
                                    cell.text ?? '...',
                                    style: GoogleFonts.jetBrainsMono(
                                      color: secondaryColour.withOpacity(0.3),
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                );
              },
              itemCount: page.sections.length,
              scrollDirection: Axis.vertical,
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(height: 13.0),
            ),
          )
        ],
      ),
    );
  }

  /// Update the diary page date in database.
  void _updateDiaryPageDate(date) async {
    setState(() => page.date = date);
    final userId = context.read<User>().id;
    await _diaryUsecase.updateDiaryPageDate(
      userId: userId,
      pageId: page.id,
      date: date,
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
      ..lineTo(size.width / 2 + diamondSize / 2, size.height - diamondSize / 2)
      ..lineTo(size.width / 2, size.height)
      ..lineTo(size.width / 2 - diamondSize / 2, size.height - diamondSize / 2)
      ..lineTo(size.width / 2, size.height - diamondSize)
      ..lineTo(size.width / 2 + diamondSize / 2, size.height - diamondSize / 2)
      ..moveTo(size.width / 2 - diamondSize / 2, size.height - diamondSize / 2)
      ..lineTo(diamondSize / 2, size.height - diamondSize / 2)
      ..lineTo(diamondSize / 2, diamondSize / 2);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
