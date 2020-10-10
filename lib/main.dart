import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:pass_word/Navigation/route_generator.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

class Intro extends StatefulWidget {
  @override
  _IntroState createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  TextEditingController _securityController = TextEditingController();

  final LocalAuthentication _localAuthentication = LocalAuthentication();
  bool _canCheckBiometric = false;
  String _authorizedOrNot = "Not Authorized";
  List<BiometricType> _availableBiometricType = List<BiometricType>();

  Future<void> _authorizeNow() async {
    bool isAuthorized = false;
    try {
      isAuthorized = await _localAuthentication.authenticateWithBiometrics(
          localizedReason: "Put your Finger on Finger Sensor for Verification",
          useErrorDialogs: true,
          stickyAuth: true);
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;
    setState(() {
      if (isAuthorized) {
        _authorizedOrNot = "Authorized";
        Navigator.pushNamed(context, '/Homepage');
      } else {
        _authorizedOrNot = "Not Authorized";
      }
    });
  }

  check() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (_securityController.text == preferences.getString("security")) {
      Navigator.pushNamed(context, '/Homepage');
    } else {
      print("Not allowed");
    }
  }

  BoxShadow _shadow1 = BoxShadow(
      color: Colors.grey[600],
      offset: Offset(4.0, 4.0),
      blurRadius: 15.0,
      spreadRadius: 1.0);
  BoxShadow _shadow2 = BoxShadow(
      color: Colors.white,
      offset: Offset(-4.0, -4.0),
      blurRadius: 15.0,
      spreadRadius: 1.0);

  Widget _button(int btval) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: MaterialButton(
          height: 30,
          minWidth: 30,
          elevation: 0.0,
          onPressed: () {
            setState(() {
              _securityController.text = btval.toString();
            });
          },
          child: Text(
            "$btval",
            style: TextStyle(
                fontSize: 40,
                color: Colors.orange,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 70,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.orange,
                    shape: BoxShape.rectangle,
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(80))),
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                height: 50,
                alignment: Alignment.center,
                color: Colors.orange,
                child: Text(
                  "PassWord",
                  style: TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 30),
              GestureDetector(
                onTap: _authorizeNow,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: [_shadow1, _shadow2]),
                  child: Icon(
                    Icons.fingerprint,
                    size: 100,
                    color: Colors.orange,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 16, left: 16.0, right: 16.0),
                child: TextField(
                  controller: _securityController,
                  textAlign: TextAlign.center,
                  cursorColor: Colors.orange,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: "Enter Password",
                      border: OutlineInputBorder(),
                      fillColor: Colors.orange),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width * 1.0,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(54, 50, 58, 1.0),
                      border: Border.all(color: Colors.orange, width: 3),
                    ),
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        ListTile(
                          trailing: Icon(
                            Icons.radio_button_checked,
                            color: Colors.orange,
                          ),
                          onTap: () {},
                          title: Text(
                            "Can we check FingerPrint",
                            style: TextStyle(color: Colors.white54),
                          ),
                        ),
                        ListTile(
                          trailing: Icon(
                            Icons.radio_button_checked,
                            color: Colors.orange,
                          ),
                          onTap: () {},
                          title: Text(
                            "Can we check FingerPrint",
                            style: TextStyle(color: Colors.white54),
                          ),
                        ),
                        ListTile(
                          trailing: Icon(
                            Icons.radio_button_checked,
                            color: Colors.orange,
                          ),
                          onTap: () {},
                          title: Text(
                            "Can we check FingerPrint",
                            style: TextStyle(color: Colors.white54),
                          ),
                        ),
                        Divider(thickness: 3,height: 0.3),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            'Tip:- Click on finger icon above to authorize',
                            style: TextStyle(
                              color: Colors.orange
                            ),
                          ),
                        )
                      ],
                    )),
              ),
              // SizedBox(height: 100),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MaterialButton(
                      minWidth: 200,
                      color: Colors.orange,
                      child: Text(
                        "Enter",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      height: 50,
                      onPressed: () {
                        check();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// gradient: LinearGradient(
//                         begin: Alignment.topLeft,
//                         end: Alignment.bottomRight,
//                         colors: [
//                           Colors.grey[200],
//                           Colors.grey[300],
//                           Colors.grey[400],
//                         ],
//                         stops: [
//                           0.1,
//                           0.3,
//                           0.8,
//                         ]
//                       )
