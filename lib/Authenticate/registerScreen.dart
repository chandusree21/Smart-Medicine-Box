
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:smart_medicine_box/MyHomePage.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _formKeyOTP = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController nameController =
  TextEditingController();
  final TextEditingController cellnumberController =

  TextEditingController();
  final TextEditingController otpController =
  TextEditingController();

  var isLoading = false;
  var isResend = false;
  var isRegister = true;
  var isOTPScreen = false;
  var verificationCode = '';

  //Form controllers
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    nameController.dispose();
    cellnumberController.dispose();
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isOTPScreen ? returnOTPScreen() : registerScreen();
  }

  Widget registerScreen() {
    final node = FocusScope.of(context);
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text('Register '
              'user'),
        ),
        body: ListView(children: [
          Column(
            children: [
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        child: TextFormField(
                          enabled: !isLoading,
                          controller: nameController,
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () => node.nextFocus(),
                          decoration: const InputDecoration(
                              floatingLabelBehavior:
                              FloatingLabelBehavior.never,
                              labelText: 'Name'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a name';
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        child: TextFormField(
                          enabled: !isLoading,
                          keyboardType: TextInputType.phone,
                          controller: cellnumberController,
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (_) => node.unfocus(),
                          decoration: const InputDecoration(
                              hintText: 'Phone Number',
                              floatingLabelBehavior:
                              FloatingLabelBehavior.never,
                              labelText: 'Phone Number'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a phone number';
                            }
                          },
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.only(top: 40, bottom: 5),
                          child: Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 10.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  if (!isLoading) {
                                    if (_formKey.currentState!.validate()) {
                                      // If the form is valid, we want to show a loading Snackbar
                                      setState(() {
                                        signUp();
                                        isRegister = false;
                                        isOTPScreen = true;
                                      });
                                    }
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 15.0,
                                    horizontal: 15.0,
                                  ),
                                  child:
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const <Widget>[
                                      Expanded(
                                        child: Text(
                                          "Next",
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ))),
                    ],
                  ))
            ],
          )
        ]));
  }

  Widget returnOTPScreen() {
    return Scaffold(
        key: _scaffoldKey,
        appBar:
        AppBar(
          title: const Text('OTP Screen'),
        ),
        body: ListView(children: [
          Form(
            key: _formKeyOTP,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10.0),
                    child: Text(
                        !isLoading
                            ? "Enter OTP from SMS"
                            : "Sending OTP code SMS",
                        textAlign: TextAlign.center)),
                !isLoading
                    ? Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      child: TextFormField(
                        enabled: !isLoading,
                        controller: otpController,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        initialValue: null,
                        autofocus: true,
                        decoration: const InputDecoration(
                            labelText: 'OTP',
                            labelStyle: TextStyle(color: Colors.black)),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter OTP';
                          }
                        },
                      ),
                    )
                    : Container(),
                !isLoading
                    ? Container(
                    margin: EdgeInsets.only(top: 40, bottom: 5),
                    child: Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 10.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKeyOTP.currentState!.validate()) {
                              // If the form is valid, we want to show a loading Snackbar
                              // If the form is valid, we want to do firebase signup...
                              setState(() {
                                isResend = false;
                                isLoading = true;
                              });
                              try {
                                await _auth
                                    .signInWithCredential(
                                    PhoneAuthProvider.credential(
                                        verificationId:
                                        verificationCode,
                                        smsCode: otpController.text
                                            .toString()))
                                    .then((user) async => {
                                  //sign in was success
                                  if (user != null)
                                    {
                                      //store registration details in firestore database
                                      await _firestore
                                          .collection('users')
                                          .doc(
                                          _auth.currentUser!.uid)
                                          .set(
                                          {
                                            'name': nameController
                                                .text
                                                .trim(),
                                            'PhoneNumber':
                                            cellnumberController
                                                .text
                                                .trim(),
                                          },
                                          SetOptions(
                                              merge:
                                              true)).then(
                                              (value) => {
                                            //then move to authorised area
                                            setState(() {
                                              isLoading =
                                              false;
                                              isResend =
                                              false;
                                            })
                                          }),

                                      setState(() {
                                        isLoading = false;
                                        isResend = false;
                                      }),
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (BuildContext
                                          context) =>
                                              MyHomePage(),
                                        ),
                                            (route) => false,
                                      )
                                    }
                                })
                                    .catchError((error) => {
                                  setState(() {
                                    isLoading = false;
                                    isResend = true;
                                  }),
                                });
                                setState(() {
                                  isLoading = true;
                                });
                              } catch (e) {
                                setState(() {
                                  isLoading = false;
                                });
                              }
                            }
                          },
                          child:
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 15.0,
                              horizontal: 15.0,
                            ),
                            child:
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const <Widget>[
                                Expanded(
                                  child: Text(
                                    "Submit",
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )))
                    : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          CircularProgressIndicator(
                            backgroundColor:
                            Theme.of(context).primaryColor,
                          )
                        ].where((c) => c != null).toList(),
                      )
                    ]),
                isResend
                    ? Container(
                    margin: EdgeInsets.only(top: 40, bottom: 5),
                    child: Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 10.0),
                        child:
                        ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              isResend = false;
                              isLoading = true;
                            });
                            await signUp();
                          },
                          child:
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 15.0,
                              horizontal: 15.0,
                            ),
                            child:
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const <Widget>[
                                Expanded(
                                  child: Text(
                                    "Resend Code",
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )))
                    : Column()
              ],
            ),
          )
        ]));
  }

  Future signUp() async {
    setState(() {
      isLoading = true;
    });
    debugPrint('Gideon test 1');
    var phoneNumber = '+91 ' + cellnumberController.text.toString();
    debugPrint('Gideon test 2');
    var verifyPhoneNumber = _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (phoneAuthCredential) {
        debugPrint('Gideon test 3');
        //auto code complete (not manually)
        _auth.signInWithCredential(phoneAuthCredential).then((user) async => {
          if (user != null)
            {
              //store registration details in firestore database
              await _firestore
                  .collection('users')
                  .doc(_auth.currentUser!.uid)
                  .set({
                'name': nameController.text.trim(),
                'PhoneNumber': cellnumberController.text.trim()
              }, SetOptions(merge: true))
                  .then((value) => {
                //then move to authorised area
                setState(() {

                  isLoading = false;
                  isRegister = false;
                  isOTPScreen = false;

                  //navigate to is
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          MyHomePage(),
                    ),
                        (route) => false,
                  );
                })
              })
                  .catchError((onError) => {
                debugPrint(
                    'Error saving user to db.' + onError.toString())
              })
            }
        });
        debugPrint('Gideon test 4');
      },
      verificationFailed: (FirebaseAuthException error) {
        if(error.message!=null) {
          debugPrint(error.message);
        }
        setState(() {
          isLoading = false;
        });
      },
      codeSent: (verificationId, forceResendingToken) {
        debugPrint('Gideon test 6');
        setState(() {
          isLoading = false;
          verificationCode = verificationId;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        debugPrint('Gideon test 7');
        setState(() {
          isLoading = false;
          verificationCode = verificationId;
        });
      },
      timeout: Duration(seconds: 60),
    );
    debugPrint('Gideon test 7');
    await verifyPhoneNumber;
    debugPrint('Gideon test 8');
  }
}
