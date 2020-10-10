class PassWord {
  int id;
  String title;
  String password;
  String image;

  passwordMap() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id;
    mapping['title'] = title;
    mapping['password'] = password;
    mapping['image'] = image;
    return mapping;
  }
}
