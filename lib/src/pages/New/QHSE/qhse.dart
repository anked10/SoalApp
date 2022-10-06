import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soal_app/src/bloc/data_user.dart';
import 'package:soal_app/src/bloc/provider_bloc.dart';
import 'package:soal_app/src/pages/Home/menu_widget.dart';
import 'package:soal_app/src/pages/New/QHSE/generate_reporte_incidencias.dart';
import 'package:soal_app/src/pages/New/QHSE/pendientes_verificacion.dart';
import 'package:soal_app/src/widgets/show_loading.dart';

class QHSE extends StatefulWidget {
  const QHSE({Key? key}) : super(key: key);

  @override
  State<QHSE> createState() => _QHSEState();
}

class _QHSEState extends State<QHSE> {
  int inicio = 0;
  @override
  Widget build(BuildContext context) {
    final dataUserBloc = ProviderBloc.data(context);
    if (inicio == 0) {
      dataUserBloc.obtenerUser();
      inicio++;
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const MenuWidget(),
        title: Text(
          'Reporte de Incidencias',
          style: TextStyle(
            fontSize: ScreenUtil().setSp(18),
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
      body: StreamBuilder<UserModel>(
        stream: dataUserBloc.userStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: ShowLoadding(active: true, color: Colors.transparent));
          return (snapshot.data!.idRoleUser == '7')
              ? GenerateReport(
                  datosUsuario: snapshot.data!,
                )
              : PendientesVerificacion();
        },
      ),
    );
  }
}
