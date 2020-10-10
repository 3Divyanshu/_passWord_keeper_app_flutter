import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Setting extends StatefulWidget {
  final bool isBright;
  Setting({Key key, @required this.isBright}) : super(key: key);
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  TextEditingController _passChangeController = TextEditingController();

  setSecurity() async {
    print(_passChangeController.text);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("security", _passChangeController.text);
    print(preferences.getString("security"));
  }

  Widget cards(String title, Icon icons) {
    return ListTile(
        title: Text(
          "$title",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: widget.isBright ? Colors.black : Colors.white),
        ),
        trailing: icons);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          widget.isBright ? Colors.grey[200] : Color.fromRGBO(86, 84, 118, 1.0),
      appBar: AppBar(
        backgroundColor:
            widget.isBright ? Colors.orange : Color.fromRGBO(54, 51, 74, 1.0),
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text(
          "Setting",
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: [
              InkWell(
                child: cards(
                  "Change/Set Password",
                  Icon(
                    Icons.lock,
                    color: Colors.orange,
                  ),
                ),
                onTap: () {
                  editSecurityDialog();
                },
              ),
              Divider(thickness: 1),
              InkWell(
                child: cards(
                  "About",
                  Icon(
                    Icons.info,
                    color: Colors.orange,
                  ),
                ),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (param) {
                        return AlertDialog(
                          title: Text("About"),
                          content: Text("Made with \u{1f44f} \u2665\nGithub (@3Divyanshu) ☜(ಠ_ಠ☜)"),
                          actions: [
                            OutlineButton(
                              child: Text("Back"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        );
                      });
                },
              ),
              Divider(thickness: 1),
              InkWell(
                child: cards(
                  "Login Data",
                  Icon(
                    Icons.power_settings_new,
                    color: Colors.orange,
                  ),
                ),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (param) {
                        return AlertDialog(
                          title: Text("Login"),
                          content: Text('Gmail:- "No functioning yet"'),
                          actions: [
                            OutlineButton(
                              child: Text("Back"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        );
                      });
                },
              ),
              Divider(thickness: 1),
              InkWell(
                child: cards(
                  "Github Source Code",
                  Icon(
                    Icons.code,
                    color: Colors.orange,
                  ),
                ),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (param) {
                        return AlertDialog(
                          title: Text("Souce Code"),
                          content: Text('Souce code is available on Github Do check it out and feel free to Contribute', textAlign: TextAlign.center),
                          actions: [
                            OutlineButton(
                              child: Text("Back"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        );
                      });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  editSecurityDialog() {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
              actions: [
                MaterialButton(
                  onPressed: () {
                    setSecurity();
                    Navigator.of(context).pop();
                  },
                  color: Colors.green,
                  child: Text(
                    "Save",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
                OutlineButton(
                  child: Text("Cancel"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
              content: TextField(
                controller: _passChangeController,
                keyboardType: TextInputType.number,
                decoration:
                    InputDecoration(hintText: "Enter your new Password"),
              ));
        });
  }
}
