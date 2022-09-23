import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soal_app/core/util/utils.dart';
import 'package:soal_app/src/bloc/provider_bloc.dart';
import 'package:soal_app/src/models/Requerimientos/request_model.dart';
import 'package:soal_app/src/pages/New/Requeriments/detail_request.dart';
import 'package:soal_app/src/widgets/show_loading.dart';

class PendingRequeriments extends StatelessWidget {
  const PendingRequeriments({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final requestBloc = ProviderBloc.requerimets(context);
    requestBloc.getRequerimentsByStatus('1');
    return StreamBuilder<bool>(
      stream: requestBloc.cargandoMStream,
      builder: (_, isLoadding) {
        if (!isLoadding.hasData) return ShowLoadding(active: true, color: Colors.transparent);
        if (isLoadding.data!) return ShowLoadding(active: true, color: Colors.transparent);
        return StreamBuilder<List<RequestModel>>(
          stream: requestBloc.requestStream,
          builder: (_, snapshot) {
            if (!snapshot.hasData) return Container();
            if (snapshot.data!.isEmpty) return Center(child: Text('No existen requerimientos pendientes por aprobar'));
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (_, index) {
                var request = snapshot.data![index];
                int i = index + 1;
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return DetailRequest(
                            request: request,
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
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(16), vertical: ScreenUtil().setHeight(6)),
                    child: Row(
                      children: [
                        SizedBox(
                          width: ScreenUtil().setWidth(20),
                          child: Text(
                            i.toString(),
                            style: TextStyle(fontSize: ScreenUtil().setSp(10)),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.transparent.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: Text(
                                            obtenerFecha(request.requestDate ?? ''),
                                            style: TextStyle(
                                              fontSize: ScreenUtil().setSp(10),
                                              fontWeight: FontWeight.w400,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: ScreenUtil().setHeight(4)),
                                        Text(
                                          request.proyectName ?? '',
                                          style: TextStyle(
                                            fontSize: ScreenUtil().setSp(12),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(height: ScreenUtil().setHeight(6)),
                                        Row(
                                          children: [
                                            Text(
                                              'Empresa:',
                                              style: TextStyle(
                                                fontSize: ScreenUtil().setSp(10),
                                                fontWeight: FontWeight.w400,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            SizedBox(width: ScreenUtil().setWidth(4)),
                                            Text(
                                              request.businessName ?? '',
                                              style: TextStyle(
                                                fontSize: ScreenUtil().setSp(10),
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Divider(),
                                        Text(
                                          'Generado por',
                                          style: TextStyle(
                                            fontSize: ScreenUtil().setSp(10),
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        SizedBox(height: ScreenUtil().setHeight(4)),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(width: ScreenUtil().setWidth(4)),
                                            Expanded(
                                              child: Text(
                                                request.personCreatedName ?? '',
                                                style: TextStyle(
                                                  fontSize: ScreenUtil().setSp(10),
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  width: ScreenUtil().setWidth(6),
                                  height: ScreenUtil().setHeight(60),
                                  decoration: BoxDecoration(
                                    color: Colors.orangeAccent,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      bottomLeft: Radius.circular(5),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
