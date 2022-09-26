import 'package:rxdart/rxdart.dart';
import 'package:soal_app/core/sharedpreferences/storage_manager.dart';

class DataUserBloc {
  final _dataUserController = BehaviorSubject<UserModel>();

  Stream<UserModel> get userStream => _dataUserController.stream;

  dispose() {
    _dataUserController.close();
  }

  void obtenerUser() async {
    UserModel userModel = UserModel();
    userModel.idUser = await StorageManager.readData('idUser');
    userModel.idPerson = await StorageManager.readData('idPerson');
    userModel.userNickname = await StorageManager.readData('userNickname');
    userModel.userEmail = await StorageManager.readData('userEmail');
    userModel.userImage = await StorageManager.readData('userImage');
    userModel.personName = await StorageManager.readData('personName');
    userModel.personSurname = await StorageManager.readData('personSurname');
    userModel.personSurname2 = await StorageManager.readData('personSurname2');
    userModel.idRoleUser = await StorageManager.readData('idRoleUser');
    userModel.roleName = await StorageManager.readData('roleName');
    userModel.dniPerson = await StorageManager.readData('dniPerson');
    userModel.cargoID = await StorageManager.readData('cargoID');
    userModel.cargoName = await StorageManager.readData('cargoName');
    userModel.peridoID = await StorageManager.readData('peridoID');
    userModel.businessID = await StorageManager.readData('businessID');
    userModel.businessName = await StorageManager.readData('businessName');
    _dataUserController.sink.add(userModel);
  }
}

class UserModel {
  String? idUser;
  String? idPerson;
  String? userNickname;
  String? userEmail;
  String? userImage;
  String? personName;
  String? personSurname;
  String? personSurname2;
  String? idRoleUser;
  String? roleName;
  String? dniPerson;
  String? cargoID;
  String? cargoName;
  String? peridoID;
  String? businessID;
  String? businessName;

  UserModel({
    this.idUser,
    this.idPerson,
    this.userNickname,
    this.userEmail,
    this.userImage,
    this.personName,
    this.personSurname,
    this.personSurname2,
    this.idRoleUser,
    this.roleName,
    this.dniPerson,
    this.cargoID,
    this.cargoName,
    this.peridoID,
    this.businessID,
    this.businessName,
  });
}
