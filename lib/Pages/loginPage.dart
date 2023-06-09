import 'package:flutter/material.dart';
import 'package:phone_number/phone_number.dart';
import 'package:quizme/Services/Preferences.dart';

import 'otpPage.dart';

class loginPage extends StatefulWidget {
  loginPage({Key? key}) : super(key: key);
  @override
  _loginPageState createState() => _loginPageState();
}

var mobile;
bool isNew = false;

class _loginPageState extends State<loginPage> {
  String springFieldSA = '+966569322346';
  late PhoneNumberEditingController controller;
  // PhoneNumber phoneNumber = await
  RegionInfo region = RegionInfo(name: 'SA', code: 'SA', prefix: 966);

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    controller =
        PhoneNumberEditingController(PhoneNumberUtil(), regionCode: 'SA');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xfff7f6fb),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
          child: Column(
            children: [
              const SizedBox(
                height: 18,
              ),
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade50,
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  'images/phoneNumber.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              const Text(
                'Registration',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Add your phone number.",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black38,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 28,
              ),
              Container(
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Form(
                      key: _formKey,
                      child: TextFormField(
                        maxLength: 9,

                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your number';
                          } else if (!value.startsWith('5')) {
                            return 'Please enter valid SA number';
                          } else if (value.length != 9) {
                            return 'Please make sure your number is correct';
                          }
                          return null;
                        },
                        controller: controller,
                        keyboardType: TextInputType.number,
                        // ignore: prefer_const_constructors
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                              borderRadius: BorderRadius.circular(10)),
                          errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black12),
                              borderRadius: BorderRadius.circular(10)),
                          hintStyle: TextStyle(
                            color: Colors.grey.shade500,
                            letterSpacing: 1,
                            fontWeight: FontWeight.normal,
                          ),
                          hintText: '569343828',
                          counterText: '',
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.black12),
                              borderRadius: BorderRadius.circular(10)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.black12),
                              borderRadius: BorderRadius.circular(10)),
                          prefix: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              '+966',
                              style: TextStyle(
                                color: Colors.grey.shade700,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 22,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            mobile = '0' + controller.text;
                            var oldNumber = Preferences.getmobile();

                            if (oldNumber == null ||
                                oldNumber == '' ||
                                oldNumber != mobile) {
                              isNew = true;
                            } else {
                              Preferences.setMobile(mobile);
                            }

                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => Otp()),
                            );
                          }
                        },
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color(0xFF4C6793)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(14.0),
                          child: Text(
                            'Send',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 28,
              ),
              const Text(
                "make sure you enter the correct number",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black38,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
