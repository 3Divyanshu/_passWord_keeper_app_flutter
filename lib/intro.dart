import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:pass_word/data/Image.dart';
import 'package:pass_word/data/password.dart';
import 'package:pass_word/data/password_service.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  PasswordService _passWordService;
  bool isBright = true;
  TextEditingController _editTitleController = TextEditingController();
  TextEditingController _editPassController = TextEditingController();

  List<PassWord> _passwordList = List<PassWord>();
  List<PassWord> _passwordDisplay = List<PassWord>();

  var _password = PassWord();

  @override
  initState() {
    _dropdownMenuItem = buildDropdownmenuItem(_images);
    _selectedCompany = _dropdownMenuItem[0].value;
    super.initState();
    getAllPassWord();
    _passwordDisplay = _passwordList;
  }

  getAllPassWord() async {
    _passWordService = PasswordService();
    _passwordList = List<PassWord>();

    var passwords = await _passWordService.readpassword();

    passwords.forEach((password) {
      setState(() {
        var model = PassWord();
        model.id = password['id'];
        model.title = password['title'];
        model.password = password['password'];
        model.image = password['image'];
        _passwordList.add(model);
      });
    });
  }

  var password;
  _editCategory(BuildContext context, passwordId) async {
    password = await _passWordService.readpasswordById(passwordId);
    setState(() {
      _editTitleController.text = password[0]['title'] ?? 'No Title';
      _editPassController.text = password[0]['password'] ?? 'No Pasword';
      getAllPassWord();
    });
    _editshowDialog(context);
  }

  var passWord = PassWord();

  List<Images> _images = Images.getImages();
  List<DropdownMenuItem<Images>> _dropdownMenuItem;
  Images _selectedCompany;

  List<DropdownMenuItem<Images>> buildDropdownmenuItem(List images) {
    List<DropdownMenuItem<Images>> item = List();
    for (Images image in images) {
      item.add(DropdownMenuItem(
        value: image,
        child: Text(image.id),
      ));
    }
    return item;
  }

  onChangeDropDownItem(Images selectedImage) {
    setState(() {
      _selectedCompany = selectedImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.orange),
        backgroundColor:
            isBright ? Colors.grey[300] : Color.fromRGBO(54, 51, 74, 1.0),
        centerTitle: true,
        title: Text(
          'PassWord',
          style: TextStyle(
            color: Colors.orange,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).pushNamed('/setting', arguments: isBright);
            },
            color: Colors.orange,
          ),
        ],
      ),
      backgroundColor:
          isBright ? Colors.white : Color.fromRGBO(63, 61, 86, 1.0),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: _passwordList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: FocusedMenuHolder(
              blurBackgroundColor: Colors.white,
              menuWidth: MediaQuery.of(context).size.width * 0.46,
              onPressed: () {},
              menuItems: [
                FocusedMenuItem(
                    onPressed: () {
                      FlutterClipboard.copy(_passwordDisplay[index].password);
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text(
                          "PassWord Copied",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w800),
                        ),
                        backgroundColor: Colors.green,
                      ));
                    },
                    backgroundColor: Colors.white,
                    trailingIcon: Icon(Icons.content_copy),
                    title: Text(
                      "Copy",
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    )),
                FocusedMenuItem(
                    onPressed: () {
                      _editCategory(context, _passwordList[index].id);
                    },
                    backgroundColor: Colors.orange,
                    trailingIcon: Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                    title: Text(
                      "Edit",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          fontSize: 18),
                    )),
                FocusedMenuItem(
                    onPressed: () {
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content:
                            Text("Deleted ${_passwordDisplay[index].title}"),
                        backgroundColor: Colors.red,
                      ));
                      deletePassword(context, _passwordDisplay[index].id);
                    },
                    backgroundColor: Colors.pink,
                    trailingIcon: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                    title: Text(
                      "Delete",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          fontSize: 18),
                    )),
              ],
              child: Container(
                decoration: BoxDecoration(
                  color: isBright
                      ? Color(0xfff1f2ed)
                      : Color.fromRGBO(54, 51, 74, 1.0),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(-5, -5),
                      color: isBright
                          ? Color(0xffcdcec9)
                          : Color.fromRGBO(63, 61, 86, 1.0),
                      blurRadius: 15,
                      spreadRadius: 1.0,
                    ),
                    BoxShadow(
                      offset: Offset(5, 5),
                      color: isBright
                          ? Color(0xffffffff)
                          : Color.fromRGBO(63, 61, 86, 1.0),
                      blurRadius: 15,
                      spreadRadius: 1.0,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      child: Image.asset(_passwordList[index].image.toString()),
                    ),
                    Container(
                      width: double.infinity,
                      color: Colors.cyan[100],
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            '${_passwordDisplay[index].id.toString()}.' +
                                    '${_passwordDisplay[index].title}' ??
                                "No Title",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "click on Key",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: isBright
                                    ? Color(0xfff1f2ed)
                                    : Color.fromRGBO(63, 61, 86, 1.0),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(-2, -2),
                                    color: isBright
                                        ? Color(0xffcdcec9)
                                        : Color.fromRGBO(53, 51, 74, 1.0),
                                    blurRadius: 15,
                                    spreadRadius: 1.0,
                                  ),
                                  BoxShadow(
                                    offset: Offset(2, 2),
                                    color: isBright
                                        ? Color(0xffffffff)
                                        : Color.fromRGBO(53, 51, 74, 1.0),
                                    blurRadius: 15,
                                    spreadRadius: 1.0,
                                  ),
                                ],
                              ),
                              child: IconButton(
                                color: Colors.orange[700],
                                icon: Icon(Icons.vpn_key, size: 30),
                                onPressed: () {
                                  setState(() {
                                    showDialog(
                                        context: context,
                                        builder: (param) {
                                          return AlertDialog(
                                            backgroundColor: Colors.orange,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            title: Text("Your Password"),
                                            content: Container(
                                              child: Text(
                                                  _passwordDisplay[index]
                                                          .password ??
                                                      "No Password",
                                                  style: TextStyle(
                                                      fontSize: 24,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                          );
                                        });
                                  });
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.of(context).pushNamed('/form', arguments: isBright);
          },
          backgroundColor: Colors.orange,
          label: Row(
            children: [
              Icon(Icons.vpn_key),
              SizedBox(
                width: 5,
              ),
              Text("PassWord")
            ],
          )),
/************************/ /*Drawer*/ //***********************
      drawer: Drawer(
        child: Container(
          color: isBright ? Colors.white : Color.fromRGBO(63, 61, 86, 1.0),
          child: Column(
            children: [
              Container(
                child: Image.asset(
                  "assets/1.png",
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(height: 10),
              Card(
                color:
                    isBright ? Colors.white : Color.fromRGBO(86, 84, 118, 1.0),
                child: ListTile(
                  title: Text("DarkTheme"),
                  trailing: Switch(
                    inactiveTrackColor: Color.fromRGBO(54, 51, 71, 1.0),
                    inactiveThumbColor: Colors.orange,
                    value: isBright,
                    onChanged: (changed) {
                      setState(() {
                        isBright = changed;
                      });
                    },
                  ),
                ),
              ),
              Card(
                color:
                    isBright ? Colors.white : Color.fromRGBO(86, 84, 118, 1.0),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed('/passGenerator', arguments: isBright);
                  },
                  child: ListTile(
                    title: Text("PassWord Generator"),
                    trailing: Icon(
                      Icons.lock,
                      color: Colors.orange,
                      size: 30,
                    ),
                  ),
                ),
              ),
              Card(
                color:
                    isBright ? Colors.white : Color.fromRGBO(86, 84, 118, 1.0),
                child: ListTile(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed("/setting", arguments: isBright);
                  },
                  title: Text("Setting"),
                  trailing: Icon(
                    Icons.settings,
                    color: Colors.orange,
                  ),
                ),
              ),
              Card(
                color:
                    isBright ? Colors.white : Color.fromRGBO(86, 84, 118, 1.0),
                child: ListTile(
                  trailing: Icon(
                    Icons.bug_report,
                    color: Colors.red,
                  ),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (param) {
                          return AlertDialog(
                            title: Text("Found Bug Report us !!"),
                            actions: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                    "NOTICE :- This app is exclusively avaibale to you only so no rating allowed:)"),
                              ),
                              RaisedButton(
                                color: Colors.orange[300],
                                child: Icon(
                                  Icons.play_arrow,
                                  color: Colors.blue,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                        });
                  },
                  title: Text("Found Bug Report Us !!"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  deletePassword(BuildContext context, passId) async {
    setState(() {
      _passWordService.deletepassword(passId);
      getAllPassWord();
    });
  }

  _editshowDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Cancel",
                  style: TextStyle(color: Colors.red),
                ),
              ),
              FlatButton(
                onPressed: () async {
                  _password.id = password[0]['id'];
                  _password.title = _editTitleController.text;
                  _password.password = _editPassController.text;
                  _password.image = _selectedCompany.image;
                  await _passWordService.updateData(_password);
                  Navigator.of(context).pushNamed('/Homepage');
                },
                child: Text(
                  "Save",
                  style: TextStyle(
                    color: Colors.green,
                  ),
                ),
              )
            ],
            title: Text(
              "Edit Title & Pasword",
            ),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: _editTitleController,
                    decoration: InputDecoration(hintText: "Edit title"),
                  ),
                  TextField(
                    controller: _editPassController,
                    decoration: InputDecoration(hintText: "Edit Password"),
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: isBright ? Colors.grey[300] : Colors.orange),
                    alignment: Alignment.center,
                    child: DropdownButton(
                      items: _dropdownMenuItem,
                      value: _selectedCompany,
                      onChanged: onChangeDropDownItem,
                      icon: Icon(Icons.arrow_drop_down, color: Colors.red),
                      style: TextStyle(
                          color: Colors.orange,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
