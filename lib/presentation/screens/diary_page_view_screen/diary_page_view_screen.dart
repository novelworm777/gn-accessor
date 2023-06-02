import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../components/atoms/underline.dart';
import '../../../components/templates/colour_default_screen.dart';
import '../../../domain/usecases/diary_usecase.dart';
import '../../../utils/helpers/ordinal_number.dart';
import '../../models/diary.dart';
import '../../models/user.dart';

class DiaryPageViewScreen extends StatefulWidget {
  const DiaryPageViewScreen({Key? key, required this.id}) : super(key: key);

  final String id;

  @override
  State<DiaryPageViewScreen> createState() => _DiaryPageViewScreenState();
}

class _DiaryPageViewScreenState extends State<DiaryPageViewScreen> {
  final _diaryUsecase = DiaryUsecase();

  bool _isLoading = true;
  DiaryPage _page = DiaryPage(
    id: 'unknown',
    date: DateTime.now(),
    sections: [],
  );

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  /// Load necessary data for screen.
  void _loadData() async {
    SmartDialog.showLoading(
      maskColor: const Color(0xFFF9F7FF),
      onDismiss: () => setState(() => _isLoading = false),
    );
    await _viewDiaryPage();
    SmartDialog.dismiss(status: SmartStatus.loading);
  }

  /// View a diary page from database.
  _viewDiaryPage() async {
    final userId = context.read<User>().id;
    final res = await _diaryUsecase.viewDiaryPage(
      userId: userId,
      pageId: widget.id,
    );
    setState(() => _page = DiaryPage.fromMap(res));
  }

  @override
  Widget build(BuildContext context) {
    const primaryColour = Color(0xFFF9F7FF);
    const secondaryColour = Color(0xFF374259);

    String monthDay = DateFormat('MMMMd').format(_page.date);
    String year = DateFormat('y').format(_page.date);
    String ordinalNumberSuffix = OrdinalNumber.nthNumber(_page.date.day);

    return ColourDefaultScreen(
      colour: primaryColour,
      padding: const EdgeInsets.only(
        bottom: 33.0,
        left: 13.0,
        right: 13.0,
        top: 33.0,
      ),
      child: !_isLoading
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CustomPaint(
                  painter: DiamondUnderline(colour: secondaryColour),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      bottom: 17.0,
                      left: 7.0,
                      right: 33.0,
                    ),
                    child: Text(
                      '$monthDay$ordinalNumberSuffix, $year',
                      style: GoogleFonts.jetBrainsMono(
                        color: secondaryColour,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 21.0),
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      final section = _page.sections[index];
                      return ListView.separated(
                        itemBuilder: (context, index) {
                          final cell = section.cells[index];
                          return Text(
                            cell.text ?? '',
                            style: GoogleFonts.jetBrainsMono(
                              color: secondaryColour,
                              fontSize: 15.0,
                              fontWeight: FontWeight.w500,
                            ),
                          );
                        },
                        itemCount: section.cells.length,
                        physics: const ClampingScrollPhysics(),
                        separatorBuilder: (BuildContext context, int index) =>
                            const SizedBox(height: 21.0),
                        shrinkWrap: true,
                      );
                    },
                    itemCount: _page.sections.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return const _SectionSeparator(
                        secondaryColour: secondaryColour,
                      );
                    },
                  ),
                ),
              ],
            )
          : Container(),
    );
  }
}

/// Separator between diary sections.
class _SectionSeparator extends StatelessWidget {
  const _SectionSeparator({
    Key? key,
    required this.secondaryColour,
  }) : super(key: key);

  final Color secondaryColour;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 37.0),
      child: CustomPaint(
        painter: _DiamondSeparator(colour: secondaryColour),
        child: const SizedBox(height: 49.0),
      ),
    );
  }
}

/// Separator line with diamond in the middle.
class _DiamondSeparator extends CustomPainter {
  final Color colour;

  _DiamondSeparator({required this.colour});

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
      ..moveTo(0.0, size.height / 2)
      ..lineTo(size.width / 2 - diamondSize / 2, size.height / 2)
      ..lineTo(size.width / 2, size.height / 2 - diamondSize / 2)
      ..lineTo(size.width / 2 + diamondSize / 2, size.height / 2)
      ..lineTo(size.width / 2, size.height / 2 + diamondSize / 2)
      ..lineTo(size.width / 2 - diamondSize / 2, size.height / 2)
      ..moveTo(size.width / 2 + diamondSize / 2, size.height / 2)
      ..lineTo(size.width, size.height / 2);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
