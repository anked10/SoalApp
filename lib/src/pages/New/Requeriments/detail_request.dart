import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soal_app/core/util/utils.dart';
import 'package:soal_app/src/bloc/provider_bloc.dart';
import 'package:soal_app/src/models/Requerimientos/request_model.dart';
import 'package:soal_app/src/models/Requerimientos/resourse_request_model.dart';
import 'package:soal_app/src/widgets/show_loading.dart';
import 'package:soal_app/src/widgets/widgets.dart';

class DetailRequest extends StatelessWidget {
  const DetailRequest({Key? key, required this.request}) : super(key: key);
  final RequestModel request;

  @override
  Widget build(BuildContext context) {
    final resourceBloc = ProviderBloc.requerimets(context);
    resourceBloc.getDetailRequest(request.requestID!);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Lista de herramientas ${(request.requestStatus == '1') ? '' : '#'}${request.requestCode ?? ''}',
          style: TextStyle(
            fontSize: ScreenUtil().setSp(13),
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.indigo),
        actions: [
          IconButton(
              onPressed: () {
                resourceBloc.getDetailRequest(request.requestID!);
              },
              icon: Icon(Icons.refresh, color: Colors.indigo)),
        ],
        elevation: 0,
      ),
      body: StreamBuilder<List<ResourseRequestModel>>(
        stream: resourceBloc.resourcesStream,
        builder: (_, snapshot) {
          if (!snapshot.hasData) return ShowLoadding(active: true, color: Colors.transparent);
          if (snapshot.data!.isEmpty) return Center(child: Text('Ocurrió un error, inténtelo nuevamente'));
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(16), vertical: ScreenUtil().setHeight(10)),
              child: Column(
                children: [
                  cards(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Fecha: ',
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(10),
                                fontWeight: FontWeight.w500,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              obtenerFecha(request.requestDate ?? ''),
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(10),
                                fontWeight: FontWeight.w500,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: ScreenUtil().setHeight(4)),
                        Text(
                          request.proyectName ?? '',
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(14),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Divider(),
                        SizedBox(height: ScreenUtil().setHeight(4)),
                        rows(
                            titulo: 'Solicitado por:',
                            data: request.personCreatedName ?? '',
                            st: 10,
                            sd: 11,
                            crossAxisAlignment: CrossAxisAlignment.start),
                        (request.requestStatus == '1') ? Container() : SizedBox(height: ScreenUtil().setHeight(4)),
                        (request.requestStatus == '1')
                            ? Container()
                            : rows(
                                titulo: 'Aprobado por:',
                                data: request.userAprobeName ?? '',
                                st: 10,
                                sd: 11,
                                crossAxisAlignment: CrossAxisAlignment.start),
                        SizedBox(
                          height: ScreenUtil().setHeight(6),
                        ),
                      ],
                    ),
                    fondo: Colors.white,
                    color: Colors.green,
                    height: 40,
                    mtop: 15,
                  ),
                  SizedBox(height: ScreenUtil().setHeight(20)),
                  ExpansionTile(
                    initiallyExpanded: true,
                    maintainState: true,
                    title: Text(
                      'Recursos',
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(16),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    children: snapshot.data!.asMap().entries.map((item) {
                      int idx = item.key;
                      return resourceItem(item.value, idx + 1);
                    }).toList(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget resourceItem(ResourseRequestModel resource, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          SizedBox(
            width: ScreenUtil().setWidth(20),
            child: Text(index.toString()),
          ),
          Expanded(
            child: cards(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        rows(titulo: 'Descripción:', data: resource.resourceName ?? '', st: 10, sd: 12, crossAxisAlignment: CrossAxisAlignment.start),
                        SizedBox(height: ScreenUtil().setHeight(4)),
                        rows(titulo: 'Unidad:', data: resource.measureName ?? '', st: 10, sd: 12, crossAxisAlignment: CrossAxisAlignment.start),
                        SizedBox(height: ScreenUtil().setHeight(4)),
                        rows(
                            titulo: 'Cantidad',
                            data: resource.requestDetailQuantity ?? '',
                            st: 12,
                            sd: 12,
                            crossAxisAlignment: CrossAxisAlignment.start),
                      ],
                    ),
                  ),
                ],
              ),
              fondo: Colors.white,
              color: Colors.indigo,
              height: 35,
              mtop: 10,
            ),
          ),
        ],
      ),
    );
  }
}
