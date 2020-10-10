import 'package:flutter/material.dart';
import 'package:pass_word/data/Image.dart';
import 'package:pass_word/data/password.dart';
import 'package:pass_word/data/password_service.dart';

class PassForm extends StatefulWidget {
  final bool isBright;
  PassForm({Key key, @required this.isBright}) : super(key: key);
  @override
  _PassFormState createState() => _PassFormState();
}

class _PassFormState extends State<PassForm> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  var passWord = PassWord();

  List<Images> _images = Images.getImages();
  List<DropdownMenuItem<Images>> _dropdownMenuItem;
  Images _selectedCompany;

  @override
  void initState() {
    _dropdownMenuItem = buildDropdownmenuItem(_images);
    _selectedCompany = _dropdownMenuItem[0].value;
    super.initState();
  }

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

  //textFields
  Widget _containerfill(TextEditingController _controller, String hint) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xfff1f2ed),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              offset: Offset(-5, -5),
              color: widget.isBright
                  ? Color(0xffcdcec9)
                  : Color.fromRGBO(54, 51, 74, 1.0),
              blurRadius: 15,
              spreadRadius: 1.0,
            ),
            BoxShadow(
              offset: Offset(5, 5),
              color: widget.isBright
                  ? Color(0xffffffff)
                  : Color.fromRGBO(54, 51, 74, 1.0),
              blurRadius: 15,
              spreadRadius: 1.0,
            ),
          ],
        ),
        child: TextField(
          autocorrect: false,
          textAlign: TextAlign.center,
          controller: _controller,
          maxLength: 12,
          maxLines: 1,
          decoration: InputDecoration(
              hintText: hint,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        ),
      ),
    );
  }

  //textstyle....
  TextStyle textStyle = TextStyle(fontSize: 24, color: Colors.white);

  //dark_theme_colors
  Color green5 = Color.fromRGBO(54, 51, 74, 1.0);
  Color green6 = Color.fromRGBO(63, 61, 86, 1.0);
  Color green8 = Color.fromRGBO(86, 84, 118, 1.0);

  String warning =
      "Note:- Don't Worrry we will not share your password with FBI";
  Color warningColor = Colors.orange;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: widget.isBright ? Colors.white : green6,
        appBar: AppBar(
            backgroundColor: widget.isBright ? Colors.orange : green5,
            iconTheme: IconThemeData(color: Colors.white),
            centerTitle: true,
            title: Text("New PassWord", style: textStyle)),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  "$warning",
                  style: textStyle.copyWith(fontSize: 12, color: warningColor),
                ),
                _containerfill(
                    _titleController, "Company Name eg. Google, Facebook etc."),
                _containerfill(_passwordController, "Enter your passWord here"),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: widget.isBright ? Colors.grey[300] : green8),
                  alignment: Alignment.center,
                  child: DropdownButton(
                    items: _dropdownMenuItem,
                    value: _selectedCompany,
                    onChanged: onChangeDropDownItem,
                    icon: Icon(Icons.arrow_drop_down, color: Colors.red),
                    style: textStyle.copyWith(
                        color: Colors.orange,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Selected Icon : ${_selectedCompany.id}",
                  style: textStyle.copyWith(
                    fontSize: 12,
                    color: Colors.orange,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                MaterialButton(
                  height: 50,
                  minWidth: 100,
                  color: Colors.orange,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Text("Save",
                      style: textStyle.copyWith(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                  onPressed: () async {
                    var passObject = PassWord();
                    passObject.title = _titleController.text;
                    passObject.password = _passwordController.text;
                    passObject.image = _selectedCompany.image;
                    var passService = PasswordService();
                    if (_titleController.text == '' ||
                        _passwordController.text == '') {
                      setState(() {
                        warning =
                            "You should give appropriate title and password in order to save";
                        warningColor = Colors.red;
                      });
                    } else {
                      await passService.savepassword(passObject);
                      Navigator.pushNamed(context, '/Homepage');
                    }
                  },
                ),
                Container(
                  child: Icon(Icons.vpn_key,
                      size: 180,
                      color: widget.isBright ? Colors.grey[300] : green8),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Share your password with us like you share your things with siblings",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 12,
                        color: widget.isBright ? Colors.black : Colors.white,
                        fontWeight: FontWeight.w400),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
