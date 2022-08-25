import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soal_app/src/bloc/provider_bloc.dart';
import 'package:soal_app/src/models/almacenModel.dart';
import 'package:soal_app/src/pages/Home/menu_widget.dart';
import 'package:soal_app/src/widgets/show_loading.dart';
import 'package:soal_app/src/widgets/widgets.dart';

class StockAlmacen extends StatefulWidget {
  const StockAlmacen({Key? key}) : super(key: key);

  @override
  State<StockAlmacen> createState() => _StockAlmacenState();
}

class _StockAlmacenState extends State<StockAlmacen> {
  String idSede = '';
  @override
  Widget build(BuildContext context) {
    final almacenBloc = ProviderBloc.almacen(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const MenuWidget(),
        title: Text(
          'Stock Almacén',
          style: TextStyle(
            fontSize: ScreenUtil().setSp(18),
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              almacenBloc.getStockAlmacen('');
            },
            icon: Icon(
              Icons.refresh,
              color: Colors.indigo,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
              color: Colors.indigo,
            ),
          ),
        ],
        elevation: 0,
      ),
      body: StreamBuilder<bool>(
        stream: almacenBloc.cargandoStream,
        builder: (_, c) {
          if (c.hasData && !c.data!) {
            return StreamBuilder<List<AlmacenModel>>(
                stream: almacenBloc.stockRecursoAlmacenStream,
                builder: (_, snapshot) {
                  if (!snapshot.hasData) return Container();
                  if (snapshot.data!.isEmpty) return Text('Sin recursos disponibles');

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
                      return recursoItem(snapshot.data![index]);
                    },
                  );
                });
          } else {
            return ShowLoadding(active: true, color: Colors.transparent);
          }
        },
      ),
    );
  }

  Widget recursoItem(AlmacenModel material) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: cards(
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  rows(titulo: 'Código:', data: material.recursoCodigo ?? '', st: 9, sd: 10, crossAxisAlignment: CrossAxisAlignment.start),
                  SizedBox(height: ScreenUtil().setHeight(4)),
                  rows(titulo: 'Clase:', data: material.logisticaClaseNombre ?? '', st: 9, sd: 10, crossAxisAlignment: CrossAxisAlignment.start),
                  SizedBox(height: ScreenUtil().setHeight(4)),
                  Text(
                    material.recursoNombre ?? '',
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(11),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(4)),
                  Divider(),
                  rows(titulo: 'Tipo:', data: material.logisticaTipoNombre ?? '', st: 9, sd: 10, crossAxisAlignment: CrossAxisAlignment.start),
                  (idSede.isNotEmpty && idSede != '') ? Container() : SizedBox(height: ScreenUtil().setHeight(4)),
                  (idSede.isNotEmpty && idSede != '')
                      ? Container()
                      : rows(titulo: 'Sede:', data: material.sedeNombre ?? '', st: 9, sd: 10, crossAxisAlignment: CrossAxisAlignment.start),
                ],
              ),
            ),
            Container(
              width: ScreenUtil().setWidth(80),
              child: Column(
                children: [
                  Text(
                    'Stock',
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(11),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    material.almacenStock ?? '',
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(15),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    material.almacenUnidad ?? '',
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(12),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        fondo: Colors.white,
        color: Colors.indigo,
        height: 80,
        mtop: 20,
      ),
    );
  }
}
