import 'package:flutter/material.dart';
import 'package:quizme/Pages/loginPage.dart';
import 'package:quizme/Services/RemoteAPI.dart';
import 'package:quizme/main.dart';

class name extends StatefulWidget {
  name({Key? key}) : super(key: key);

  @override
  _nameState createState() => _nameState();
}

class _nameState extends State<name> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController controller;
  late RemoteAPI _remoteAPI;

  @override
  void initState() {
    controller = TextEditingController();
    _remoteAPI = RemoteAPI();
    super.initState();
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
              Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  // ignore: prefer_const_constructors
                  child: Icon(
                    Icons.arrow_back,
                    size: 32,
                    color: Colors.black54,
                  ),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              const SizedBox(
                height: 24,
              ),
              const Text(
                'Registeration',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Enter your Name",
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
                        controller: controller,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          } else if (value.length < 2) {
                            return 'Please enter a name';
                          }

                          return null;
                        },
                        textAlign: TextAlign.center,
                        // ignore: prefer_const_constructors
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                              borderRadius: BorderRadius.circular(10)),
                          errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black12),
                              borderRadius: BorderRadius.circular(10)),
                          counterText: '',
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black12),
                              borderRadius: BorderRadius.circular(10)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black12),
                              borderRadius: BorderRadius.circular(10)),
                          prefix: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
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
                            var name = controller.text;
                            await _remoteAPI.userName(name);

                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Home()));
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
                            'Verify',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
