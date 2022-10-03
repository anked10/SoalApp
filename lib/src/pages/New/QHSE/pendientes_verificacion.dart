import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soal_app/core/util/utils.dart';
import 'package:soal_app/src/bloc/provider_bloc.dart';
import 'package:soal_app/src/models/Rqhse/incidencia_model.dart';
import 'package:soal_app/src/pages/New/QHSE/detail_incidencia.dart';
import 'package:soal_app/src/widgets/show_loading.dart';
import 'package:soal_app/src/widgets/widgets.dart';

class PendientesVerificacion extends StatelessWidget {
  const PendientesVerificacion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final incidenciasBloc = ProviderBloc.incidencias(context);
    incidenciasBloc.getIncidenciasPendientes();

    return Padding(
      padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(5), horizontal: ScreenUtil().setWidth(16)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Pendientes de Verificación',
                style: TextStyle(fontSize: ScreenUtil().setSp(16), fontWeight: FontWeight.w500, color: Colors.indigo),
              ),
              IconButton(
                onPressed: () {
                  incidenciasBloc.getIncidenciasPendientes();
                },
                icon: Icon(Icons.refresh),
              ),
            ],
          ),
          SizedBox(height: ScreenUtil().setHeight(10)),
          Expanded(
            child: StreamBuilder<bool>(
              stream: incidenciasBloc.cargandoMStream,
              builder: (_, l) {
                if (!l.hasData)
                  return Center(
                    child: ShowLoadding(active: true, color: Colors.transparent),
                  );
                if (l.data!)
                  return Center(
                    child: ShowLoadding(active: true, color: Colors.transparent),
                  );
                return StreamBuilder<List<IncidenciaModel>>(
                  stream: incidenciasBloc.incidenciasStream,
                  builder: (_, snapshot) {
                    if (!snapshot.hasData) return Container();
                    if (snapshot.data!.isEmpty) return Center(child: Text('No existen Incidencias Pendientes de Verificación'));
                    return Column(
                      children: [
                        ...snapshot.data!.map((element) => _buildItem(context, element)).toList(),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(BuildContext context, IncidenciaModel incidencia) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) {
                return DetailIncidencia(
                  incidencia: incidencia,
                );
              },
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                var begin = Offset(0.0, 1.0);
                var end = Offset.zero;
                var curve = Curves.ease;

                var tween = Tween(begin: begin, end: end).chain(
                  CurveTween(curve: curve),
                );

                return SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                );
              },
            ),
          );
        },
        child: cards(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Text(
                  obtenerFecha(incidencia.dateGenerated ?? ''),
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(10),
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(4)),
              Text(
                incidencia.correlativoIncidencia ?? '',
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(11),
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(4)),
              rows(titulo: 'Generado por:', data: incidencia.personGenerated ?? '', st: 9, sd: 10, crossAxisAlignment: CrossAxisAlignment.start),
              SizedBox(height: ScreenUtil().setHeight(4)),
              rows(titulo: 'Cargo:', data: incidencia.cargoGenerado ?? '', st: 9, sd: 10, crossAxisAlignment: CrossAxisAlignment.start),
              SizedBox(height: ScreenUtil().setHeight(4)),
              Divider(),
              rows(
                  titulo: 'Fecha Verificada:',
                  data: obtenerFechaHour(incidencia.dateVericated ?? ''),
                  st: 9,
                  sd: 10,
                  crossAxisAlignment: CrossAxisAlignment.start),
              SizedBox(height: ScreenUtil().setHeight(4)),
              rows(titulo: 'Verificado por:', data: incidencia.personVericated ?? '', st: 9, sd: 10, crossAxisAlignment: CrossAxisAlignment.start),
              SizedBox(height: ScreenUtil().setHeight(4)),
              Divider(),
              rows(titulo: 'Empresa:', data: incidencia.businessName ?? '', st: 9, sd: 10, crossAxisAlignment: CrossAxisAlignment.start),
              SizedBox(height: ScreenUtil().setHeight(4)),
              rows(titulo: 'Estado Incidencia:', data: incidencia.statusName ?? '', st: 9, sd: 10, crossAxisAlignment: CrossAxisAlignment.start),
              SizedBox(height: ScreenUtil().setHeight(4)),
            ],
          ),
          fondo: Colors.white,
          color: Colors.indigo,
          height: 60,
          mtop: 20,
        ),
      ),
    );
  }
}
