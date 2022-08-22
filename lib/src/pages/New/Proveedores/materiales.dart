import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soal_app/src/bloc/provider_bloc.dart';
import 'package:soal_app/src/models/materiales_proveedor_model.dart';
import 'package:soal_app/src/models/proveedores_model.dart';
import 'package:soal_app/src/widgets/show_loading.dart';
import 'package:soal_app/src/widgets/widgets.dart';

class Materiales extends StatelessWidget {
  const Materiales({Key? key, required this.proveedor}) : super(key: key);
  final ProveedorModel proveedor;

  @override
  Widget build(BuildContext context) {
    final materialsBloc = ProviderBloc.provee(context);
    materialsBloc.getMaterialsProveedoresById(proveedor.idProveedor!);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Materiales',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          SizedBox(height: ScreenUtil().setHeight(8)),
          Text(
            'Materiales asignados a ${proveedor.nombre}',
            style: TextStyle(
              fontSize: ScreenUtil().setSp(16),
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: ScreenUtil().setHeight(10)),
          Expanded(
            child: StreamBuilder<List<MaterialesProveedorModel>>(
              stream: materialsBloc.materialsProveedoresStream,
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
                        return recursoItem(snapshot.data![index]);
                      },
                    );
                  } else {
                    return Center(
                      child: Text('No existen materiales asignados a este proveedor'),
                    );
                  }
                } else {
                  return ShowLoadding(active: true, color: Colors.transparent);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget recursoItem(MaterialesProveedorModel material) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: cards(
        child: Column(
          children: [
            rows(titulo: 'Código:', data: material.recursoCodigo ?? '', st: 9, sd: 10, crossAxisAlignment: CrossAxisAlignment.start),
            SizedBox(height: ScreenUtil().setHeight(4)),
            Text(
              material.recursoNombre ?? '',
              style: TextStyle(
                fontSize: ScreenUtil().setSp(11),
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: ScreenUtil().setHeight(4)),
            rows(titulo: 'Unidad de Medida:', data: material.umMaterial ?? '', st: 9, sd: 10, crossAxisAlignment: CrossAxisAlignment.start),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: ScreenUtil().setWidth(150),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Precio en Soles',
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(11),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: ScreenUtil().setHeight(6)),
                      Text(
                        'Sin IGV.:',
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(9),
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        material.solesMaterial ?? '',
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(11),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: ScreenUtil().setHeight(6)),
                      Text(
                        'Con IGV.:',
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(9),
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        material.igvSolesMaterial ?? '',
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(11),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 1,
                  height: ScreenUtil().setHeight(50),
                  color: Colors.grey[300],
                ),
                Container(
                  width: ScreenUtil().setWidth(150),
                  child: Column(
                    children: [
                      Text(
                        'Precio en Dólares',
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(11),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: ScreenUtil().setHeight(6)),
                      Text(
                        'Sin IGV.:',
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(9),
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        material.dolaresMaterial ?? '',
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(11),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: ScreenUtil().setHeight(6)),
                      Text(
                        'Con IGV.:',
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(9),
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        material.igvDolaresMaterial ?? '',
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(11),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
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
