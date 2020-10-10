import 'package:pass_word/data/password.dart';
import 'package:pass_word/data/repository.dart';

class PasswordService {
  Repository _repository;

  PasswordService() {
    _repository = Repository();
  }

  savepassword(PassWord password) async {
    return await _repository.insertData("password", password.passwordMap());
  }

  readpassword() async {
    return await _repository.readData('password');
  }

  readpasswordById(passwordId) async {
    return await _repository.readDataById('password', passwordId);
  }

  deletepassword(itemId) async {
    return await _repository.deleteData('password', itemId);
  }

  updateData(PassWord password) async {
    return await _repository.updateData('password', password.passwordMap());
  }
}
