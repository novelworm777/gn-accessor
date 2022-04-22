import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gn_accessor/models/product.dart';
import 'package:gn_accessor/services/market.dart';
import 'package:gn_accessor/services/user.dart';
import 'package:gn_accessor/utils/constants.dart';
import 'package:gn_accessor/utils/handlers/notification_handler.dart';
import 'package:provider/provider.dart';

import '../components/atoms/app_input_form.dart';
import '../components/atoms/chip_button.dart';
import '../components/atoms/mask_image_button.dart';
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

class _MarketFooter extends StatefulWidget {
  const _MarketFooter({
    Key? key,
  }) : super(key: key);

  @override
  State<_MarketFooter> createState() => _MarketFooterState();
}

class _MarketFooterState extends State<_MarketFooter> {
  final _formKey = GlobalKey<FormBuilderState>();
  final _market = Market();
  bool _selected = true;
  int _value = 0;

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
        onPress: () {
          showModalBottomSheet(
            backgroundColor: Colors.transparent,
            context: context,
            builder: (context) => GestureDetector(
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
                setState(() {
                  _selected = false;
                });
              },
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Container(
                  padding:
                      const EdgeInsets.only(top: 33.0, left: 21.0, right: 21.0),
                  decoration: const BoxDecoration(
                    color: Color(0xFF2E2E2E),
                    borderRadius: BorderRadius.only(
                      topLeft: kSmallRadius,
                      topRight: kSmallRadius,
                    ),
                  ),
                  child: FormBuilder(
                    key: _formKey,
                    child: Column(
                      children: [
                        AppTextField(
                          name: 'title',
                          inputStyle: const TextStyle(
                            fontFamily: 'PoorStory',
                            fontSize: 19.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFFFFFFF),
                          ),
                          hint: 'What is the product called? (required)',
                          hintStyle: const TextStyle(
                            fontFamily: 'PoorStory',
                            fontSize: 19.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF818181),
                          ),
                          validators: [
                            FormBuilderValidators.required(
                                errorText: 'You have to input task title')
                          ],
                        ),
                        const SizedBox(height: 24.0),
                        Row(
                          children: [
                            const Expanded(
                              child: Text(
                                'Price Coins',
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
                                    onPressed: () {},
                                    imagePath:
                                        'assets/form/icon-arrow-down.png',
                                    isDisabled: true,
                                  ),
                                  const SizedBox(width: 3.0),
                                  _selected
                                      ? AppTextField(
                                          name: 'reward',
                                          initialValue: '$_value',
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ],
                                          inputStyle: const TextStyle(
                                            fontFamily: 'PoorStory',
                                            fontSize: 19.0,
                                            color: Color(0xFFFFFFFF),
                                          ),
                                          textAlign: TextAlign.center,
                                          width: 33,
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
                                              // widget.callback();
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
                                          backgroundColor:
                                              const Color(0xFF3B3B3B),
                                          shape: const RoundedRectangleBorder(
                                            side: BorderSide(
                                                width: 0.0,
                                                color: Color(0xFF3B3B3B)),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30.0)),
                                          ),
                                        ),
                                  const SizedBox(width: 3.0),
                                  MaskImageButton(
                                    onPressed: () {},
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
                        ),
                        const SizedBox(height: 33.0),
                        GestureDetector(
                          onTap: () {
                            final validationSuccess =
                                _formKey.currentState!.validate();

                            if (validationSuccess) {
                              _formKey.currentState!.save();
                              final formData = _formKey.currentState!.value;
                              _market.addProduct(
                                  context.read<User>().uid, formData);

                              // close modal
                              Navigator.pop(context);

                              // notify success
                              NotificationHandler.notify2(context,
                                  'Product has been successfully created.');
                            }
                          },
                          child: Container(
                            color: const Color(0xFF89CA00),
                            padding: const EdgeInsets.symmetric(vertical: 11.0),
                            width: double.infinity,
                            child: const Text(
                              'Create',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'PoorStory',
                                fontSize: 27.0,
                                color: Color(0xFFFFFFFF),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void rebuildAllChildren(BuildContext context) {
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }

    (context as Element).visitChildren(rebuild);
  }
}
