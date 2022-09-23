import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soal_app/core/sharedpreferences/storage_manager.dart';
import 'package:soal_app/src/pages/Home/menu_widget.dart';
import 'package:soal_app/src/pages/New/Requeriments/approved_requeriments.dart';
import 'package:soal_app/src/pages/New/Requeriments/pending_requeriments.dart';

class Requeriments extends StatefulWidget {
  const Requeriments({Key? key}) : super(key: key);

  @override
  State<Requeriments> createState() => _RequerimentsState();
}

class _RequerimentsState extends State<Requeriments> {
  String? idRol = '';
  @override
  void initState() {
    getIdUser();
    Future.delayed(Duration(milliseconds: 100));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: idRol == '' ? Colors.orangeAccent : Colors.white,
        leading: const MenuWidget(),
        title: Text(
          'Requerimientos ${idRol == '' ? 'Pendientes' : 'Aprobados'} ',
          style: TextStyle(
            fontSize: ScreenUtil().setSp(18),
            fontWeight: FontWeight.bold,
            color: idRol == '' ? Colors.white : Colors.black,
          ),
        ),
        elevation: 0,
      ),
      body: idRol == '' ? PendingRequeriments() : ApprovedRequeriments(),
    );
  }

  void getIdUser() async {
    idRol = await StorageManager.readData('idRoleUser');
    setState(() {});
  }
}
