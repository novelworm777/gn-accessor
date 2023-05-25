import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../components/organisms/decorated_box.dart';
import '../../../components/templates/colour_default_screen.dart';
import '../../../domain/usecases/diary_usecase.dart';
import '../../../utils/helpers/screen_size.dart';
import '../../models/diary.dart';
import '../../models/user.dart';

/// Screen where user can see all diary pages.
class DiaryScreen extends StatefulWidget {
  const DiaryScreen({Key? key}) : super(key: key);

  @override
  State<DiaryScreen> createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
  final Color _primaryColour = const Color(0xFFF9F7FF);
  final Color _secondaryColour = const Color(0xFF374259);
  final DiaryUsecase _diaryUsecase = DiaryUsecase();

  List<DiaryPageDate> _dates = [];

  @override
  void initState() {
    super.initState();
    _getDiaryPageDates();
  }

  void _getDiaryPageDates() async {
    final userId = context.read<User>().id;
    final res = await _diaryUsecase.viewDiaryPages(userId: userId);
    setState(() {
      _dates = res.map((map) => DiaryPageDate.fromMap(map)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = ScreenSize.width(context, ratio: 0.83);
    double height = 50;

    return ColourDefaultScreen(
      colour: _primaryColour,
      padding: const EdgeInsets.symmetric(vertical: 33.0),
      child: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          final pageDate = _dates[index];
          String monthDay = DateFormat('MMMMd').format(pageDate.date);
          String year = DateFormat('y').format(pageDate.date);
          String ordinalNumberSuffix = _nthNumber(pageDate.date.day);
          return DiamondDecoratedBox(
            colour: _secondaryColour,
            height: height,
            width: width,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                '$monthDay$ordinalNumberSuffix, $year',
                style: GoogleFonts.jetBrainsMono(
                  color: _primaryColour,
                  fontSize: 17.0,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          );
        },
        itemCount: _dates.length,
        separatorBuilder: (BuildContext context, int index) =>
            const SizedBox(height: 13.0),
      ),
    );
  }

  String _nthNumber(int number) {
    if (number > 3 && number < 21) return 'th';
    switch (number % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }
}
