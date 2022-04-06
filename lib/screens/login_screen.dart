import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // un-focus input keyboard on blur
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/general/bg-login-screen.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: SizedBox(
              height: 55.0,
              width: 250.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          bottomLeft: Radius.circular(30.0),
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          '#',
                          style: TextStyle(
                            color: Color(0xBAF4BBBB),
                            fontSize: 21.0,
                            fontFamily: "PoorStory",
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color(0x5EFFFFFF),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30.0),
                          bottomRight: Radius.circular(30.0),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 13.0),
                      child: Center(
                        child: TextField(
                          decoration:
                              const InputDecoration(border: InputBorder.none),
                          keyboardType: TextInputType.number,
                          style: const TextStyle(
                            letterSpacing: 13.0,
                            fontFamily: 'PoorStory',
                            fontSize: 21.0,
                            color: Color(0xFFFFFFFF),
                          ),
                          cursorColor: const Color(0xFFFFFFFF),
                          onChanged: (value) {
                            if (value.length == 3) print(value);
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
