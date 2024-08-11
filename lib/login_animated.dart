import 'package:animated_login_using_getx_and_rive/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  var animationLink = 'assets/animated_login_character.riv';
  SMIInput<bool>? isChecking;
  SMIInput<bool>? isHandsUp;
  SMIInput<bool>? trigSuccess;
  SMIInput<bool>? trigFail;
  late StateMachineController? stateMachineController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 97, 67, 133),
        title: const Text(
          "L O G I N",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),
      backgroundColor: Color.fromARGB(255, 81, 99, 149),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  height: 350,
                  width: 400,
                  child: RiveAnimation.asset(
                    animationLink, //added animation through the link
                    fit: BoxFit.cover,
                    stateMachines: const ['Login Machine'],
                    onInit: (artBoard) {
                      stateMachineController =
                          StateMachineController.fromArtboard(
                              artBoard, 'Login Machine');
                      if (stateMachineController == null) return;
                      artBoard.addController(stateMachineController!);
                      isChecking =
                          stateMachineController?.findInput('isChecking');
                      isHandsUp =
                          stateMachineController?.findInput('isHandsUp');
                      trigSuccess =
                          stateMachineController?.findInput('trigSuccess');
                      trigFail = stateMachineController?.findInput('trigFail');
                    },
                  )),
              Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 81, 99, 149),
                  // color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                height: 320.0,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          style: TextStyle(
                              color: const Color.fromARGB(255, 135, 133, 133)),
                          onChanged: (value) {
                            if (isHandsUp != null) {
                              isHandsUp!.change(false);
                            }
                            if (isChecking == null) return;
                            isChecking!.change(true);
                          },
                          controller: _usernameController,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(color: Colors.white),
                            hintText: "Enter a Valid Username!",
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 95, 159, 129)),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: BorderSide.none,
                            ),
                            fillColor: Colors.grey.shade200,
                            filled: true,
                            hintStyle: TextStyle(color: Colors.grey[500]),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color:
                                      const Color.fromARGB(255, 155, 54, 244)),
                              // Border color when not focused
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0)),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color:
                                      const Color.fromARGB(255, 155, 54, 244)),
                              // Border color when not focused
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0)),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Username should be filled';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16.0),
                        TextFormField(
                          onChanged: (value) {
                            if (isChecking != null) {
                              isChecking!.change(false);
                            }
                            if (isHandsUp == null) return;
                            isHandsUp!.change(true);
                          },
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(color: Colors.grey[500]),
                            hintText: "Enter PassWord",
                            labelStyle: TextStyle(color: Colors.white),
                            filled: true,
                            // fillColor: Colors.grey.withOpacity(0.5),
                            fillColor: Colors.grey.shade200,

                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 95, 159, 129)),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: BorderSide.none,
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color:
                                      const Color.fromARGB(255, 155, 54, 244)),
                              // Border color when not focused
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0)),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color:
                                      const Color.fromARGB(255, 155, 54, 244)),
                              // Border color when not focused
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0)),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Pass Cannot be Empty';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 40.0),
                        Container(
                          height: 40.0,
                          width: 200.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              border: Border.all(
                                  color: Color.fromARGB(255, 97, 67, 133)),
                              color: const Color.fromARGB(255, 155, 54, 244)),
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                // Perform login logic here
                                String username = _usernameController.text;
                                String password = _passwordController.text;
                                // Add your authentication logic here
                                print(
                                    'Logging in: $username with password: $password');
                                isChecking!.change(false);
                                isHandsUp!.change(false);
                                trigFail!.change(false);
                                trigSuccess!.change(true);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomeScreen()),
                                );
                              } else {
                                isChecking!.change(false);
                                isHandsUp!.change(false);
                                trigSuccess!.change(false);
                                trigFail!.change(true);
                              }
                            },
                            child: Text('L O G I N'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
