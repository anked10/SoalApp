import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soal_app/src/bloc/provider_bloc.dart';
import 'package:soal_app/src/models/obligacion_tributaria_model.dart';
import 'package:soal_app/src/pages/Contabilidad/buscar_ot_pendientes.dart';
import 'package:soal_app/src/pages/Contabilidad/item_ot_widget.dart';
import 'package:soal_app/src/widgets/show_loading.dart';

class Contabilidad extends StatelessWidget {
  const Contabilidad({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final otBloc = ProviderBloc.ot(context);
    otBloc.getOTPendientes();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Obligaciones Tributarias Pendientes',
          style: TextStyle(
            fontSize: ScreenUtil().setSp(15),
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              otBloc.getOTPendientes();
            },
            icon: Icon(
              Icons.refresh,
              color: Colors.deepPurple,
            ),
          ),
          IconButton(
            onPressed: () {
              otBloc.searchOTPendientes('');
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return const BuscarOTPendientes();
                  },
                ),
              );
            },
            icon: Icon(
              Icons.search,
              color: Colors.deepPurple,
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          otBloc.getOTPendientes();
          return null;
        },
        child: StreamBuilder<bool>(
            stream: otBloc.cargandoStream,
            builder: (_, c) {
              if (c.hasData && !c.data!) {
                return StreamBuilder<List<ObligacionTributariaModel>>(
                    stream: otBloc.otPendientesStream,
                    builder: (_, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data!.isNotEmpty) {
                          return ListView.builder(
                            itemCount: snapshot.data!.length + 1,
                            itemBuilder: (_, index) {
                              if (index == 0) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: ScreenUtil().setWidth(16),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        'Se encontraron ${snapshot.data!.length} resultado(s)',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: ScreenUtil().setSp(10),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }

                              index = index - 1;
                              return ItemOTWidget(otP: snapshot.data![index], i: index + 1);
                            },
                          );
                        } else {
                          return const Center(
                            child: Text('No existen órdenes compra pendientes'),
                          );
                        }
                      } else {
                        return Container();
                      }
                    });
              } else {
                return ShowLoadding(
                  active: true,
                  color: Colors.transparent,
                );
              }
            }),
      ),
    );
  }
}
