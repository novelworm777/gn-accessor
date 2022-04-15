import 'package:flutter/material.dart';
import 'package:gn_accessor/utils/constants.dart';

import '../atoms/app_list_tile.dart';

class PriceListTile extends StatelessWidget {
  const PriceListTile({
    Key? key,
    required this.title,
    required this.price,
    required this.onPressed,
  }) : super(key: key);

  final String title;
  final int price;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return AppListTile(
      title: title,
      trailing: Container(
        margin: const EdgeInsets.only(right: 21.0),
        padding: const EdgeInsets.all(13.0),
        decoration: const BoxDecoration(
          color: Color(0xFF2E2E2E),
          borderRadius: BorderRadius.only(
            topRight: kSmallRadius,
            bottomRight: kSmallRadius,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$price',
              style: const TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 15.0,
                fontFamily: 'PoorStory',
              ),
            ),
            const SizedBox(width: 5),
            Image.asset(
              'assets/general/icon-coin.png',
              height: 30,
              width: 30,
            ),
          ],
        ),
      ),
      onPressed: onPressed,
    );
  }
}
