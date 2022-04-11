import 'package:flutter/material.dart';

import '../components/atoms/chip_button.dart';
import '../components/atoms/mobile_screen.dart';
import '../components/molecules/app_footer.dart';
import '../components/molecules/app_header.dart';
import '../components/molecules/price_list_tile.dart';

class MarketScreen extends StatelessWidget {
  const MarketScreen({Key? key}) : super(key: key);

  static const String id = '/market';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MobileScreen(
        padding: const EdgeInsets.symmetric(vertical: 24.0),
        backgroundImage: 'assets/general/bg-general-app-screen.png',
        child: Column(
          children: [
            const AppHeader(title: 'Market'),
            Expanded(
              child: ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: const [
                  PriceListTile(
                    title: 'Medium sized cake from Harvest',
                    price: 50,
                  ),
                ],
              ),
            ),
            AppFooter(
              leftItem: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/general/icon-coin.png',
                    height: 30,
                    width: 30,
                  ),
                  const SizedBox(width: 5),
                  const Text(
                    '9999',
                    style: TextStyle(
                      color: Color(0xFF3B3B3B),
                      fontSize: 15.0,
                      fontFamily: 'PoorStory',
                    ),
                  ),
                ],
              ),
              rightItem: ChipButton(
                title: 'Create Item',
                onPress: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
