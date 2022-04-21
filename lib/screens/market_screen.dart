import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gn_accessor/models/product.dart';
import 'package:gn_accessor/services/market.dart';
import 'package:gn_accessor/services/user.dart';
import 'package:provider/provider.dart';

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
            const _MarketHeader(),
            _MarketContent(),
            const _MarketFooter(),
          ],
        ),
      ),
    );
  }
}

class _MarketHeader extends StatelessWidget {
  const _MarketHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AppHeader(title: 'Market');
  }
}

class _MarketContent extends StatelessWidget {
  _MarketContent({Key? key}) : super(key: key);

  final _market = Market();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
        stream: _market.getProducts(context.watch<User>().uid),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }
          if (!snapshot.hasData) {
            return const Text('Task Board is empty!');
          }
          return ListView(
            children: snapshot.data!.docs.map((doc) {
              final product = Product.create(doc);
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 7.0),
                child: PriceListTile(
                  title: product.title,
                  price: product.price,
                  onPressed: () {},
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

class _MarketFooter extends StatelessWidget {
  const _MarketFooter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppFooter(
      leftItem: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/general/icon-coin.png',
            height: 30,
            width: 30,
          ),
          const SizedBox(width: 5),
          Text(
            '${context.watch<User>().cryois}',
            style: const TextStyle(
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
    );
  }
}
