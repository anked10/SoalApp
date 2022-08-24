import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:soal_app/core/util/utils.dart';
import 'package:soal_app/src/api/proveedores_api.dart';
import 'package:soal_app/src/bloc/provider_bloc.dart';
import 'package:soal_app/src/models/materiales_proveedor_model.dart';
import 'package:soal_app/src/models/proveedores_model.dart';
import 'package:soal_app/src/pages/New/Proveedores/upload_document.dart';
import 'package:soal_app/src/widgets/show_loading.dart';
import 'package:soal_app/src/widgets/text_field.dart';
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
        actions: [
          IconButton(
            onPressed: () {
              materialsBloc.getMaterialsProveedoresById(proveedor.idProveedor!);
            },
            icon: Icon(
              Icons.refresh,
              color: Colors.black,
            ),
          ),
        ],
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
              child: StreamBuilder<bool>(
            stream: materialsBloc.cargandoMStream,
            builder: (_, c) {
              if (c.hasData && c.data!) {
                return ShowLoadding(active: true, color: Colors.transparent);
              }
              return StreamBuilder<List<MaterialesProveedorModel>>(
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
                          return recursoItem(context, snapshot.data![index]);
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
              );
            },
          )),
        ],
      ),
    );
  }

  Widget recursoItem(BuildContext context, MaterialesProveedorModel material) {
    return FocusedMenuHolder(
      blurBackgroundColor: Colors.black.withOpacity(0.2),
      blurSize: 0,
      animateMenuItems: true,
      onPressed: () {},
      openWithTap: true,
      menuWidth: ScreenUtil().setWidth(210),
      menuItems: [
        FocusedMenuItem(
          title: Expanded(
            child: Text(
              "Editar precio",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: ScreenUtil().setSp(18),
                letterSpacing: ScreenUtil().setSp(0.016),
                color: Colors.black,
              ),
            ),
          ),
          trailingIcon: Icon(
            Icons.insert_drive_file_sharp,
            color: Colors.grey,
            size: ScreenUtil().setHeight(20),
          ),
          onPressed: () {
            editPriceMaterial(context, material);
          },
        ),
        FocusedMenuItem(
          title: Expanded(
            child: Text(
              "Eliminar",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: ScreenUtil().setSp(18),
                letterSpacing: ScreenUtil().setSp(0.016),
                color: Colors.redAccent,
              ),
            ),
          ),
          trailingIcon: Icon(
            Icons.close,
            color: Colors.redAccent,
            size: ScreenUtil().setHeight(20),
          ),
          onPressed: () async {},
        ),
      ],
      child: Padding(
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
      ),
    );
  }

  void editPriceMaterial(BuildContext context, MaterialesProveedorModel material) {
    final nameController = TextEditingController();
    final umController = TextEditingController();
    final priceSolesController = TextEditingController();
    final priceSolesIGVController = TextEditingController();
    final priceDollarController = TextEditingController();
    final priceDollarIGVController = TextEditingController();

    final _controller = ControllerFile();

    nameController.text = material.recursoNombre ?? '';
    umController.text = material.umMaterial ?? '';
    priceSolesController.text = material.solesMaterial ?? '';
    priceSolesIGVController.text = material.igvSolesMaterial ?? '';
    priceDollarController.text = material.dolaresMaterial ?? '';
    priceDollarIGVController.text = material.igvDolaresMaterial ?? '';
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Stack(
          children: [
            GestureDetector(
              child: Container(
                color: const Color.fromRGBO(0, 0, 0, 0.001),
                child: GestureDetector(
                  onTap: () {},
                  child: DraggableScrollableSheet(
                    initialChildSize: 0.99,
                    minChildSize: 0.3,
                    maxChildSize: 0.99,
                    builder: (_, controller) {
                      return Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25.0),
                            topRight: Radius.circular(25.0),
                          ),
                        ),
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: ScreenUtil().setWidth(24),
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: ScreenUtil().setHeight(16),
                                ),
                                Center(
                                  child: Container(
                                    width: ScreenUtil().setWidth(100),
                                    height: ScreenUtil().setHeight(5),
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: ScreenUtil().setHeight(20),
                                ),
                                Text(
                                  'Editar Precios',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: ScreenUtil().setSp(18),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  height: ScreenUtil().setHeight(20),
                                ),
                                TextFieldSelect(
                                  label: 'Recurso',
                                  hingText: '',
                                  controller: nameController,
                                  readOnly: true,
                                  icon: true,
                                ),
                                SizedBox(
                                  height: ScreenUtil().setHeight(20),
                                ),
                                TextFieldSelect(
                                  label: 'Unidad de Medida',
                                  hingText: '',
                                  controller: umController,
                                  readOnly: true,
                                  icon: true,
                                ),
                                SizedBox(
                                  height: ScreenUtil().setHeight(20),
                                ),
                                TextFieldSelect(
                                  label: 'Precio en Soles sin IGV',
                                  hingText: '',
                                  keyboardType: TextInputType.number,
                                  controller: priceSolesController,
                                  widget: Icon(
                                    Icons.edit,
                                    color: Colors.indigo,
                                  ),
                                  icon: true,
                                  readOnly: false,
                                  onchange: (value) {
                                    if (value.isNotEmpty) {
                                      priceSolesIGVController.text = ((double.parse(value) * 0.18) + (double.parse(value))).round().toString();
                                    } else {
                                      priceSolesIGVController.text = '0';
                                    }
                                  },
                                ),
                                SizedBox(
                                  height: ScreenUtil().setHeight(20),
                                ),
                                TextFieldSelect(
                                  label: 'Precio en Soles con IGV (18%)',
                                  hingText: '',
                                  controller: priceSolesIGVController,
                                  readOnly: true,
                                  icon: true,
                                ),
                                SizedBox(
                                  height: ScreenUtil().setHeight(20),
                                ),
                                TextFieldSelect(
                                  label: 'Precio en Dólares sin IGV',
                                  hingText: '',
                                  controller: priceDollarController,
                                  widget: Icon(
                                    Icons.edit,
                                    color: Colors.indigo,
                                  ),
                                  icon: true,
                                  readOnly: false,
                                  onchange: (value) {
                                    if (value.isNotEmpty) {
                                      priceDollarIGVController.text = ((double.parse(value) * 0.18) + (double.parse(value))).round().toString();
                                    } else {
                                      priceDollarIGVController.text = '0';
                                    }
                                  },
                                ),
                                SizedBox(
                                  height: ScreenUtil().setHeight(20),
                                ),
                                TextFieldSelect(
                                  label: 'Precio en Dólares con IGV (18%)',
                                  hingText: '',
                                  controller: priceDollarIGVController,
                                  icon: false,
                                  readOnly: true,
                                ),
                                SizedBox(
                                  height: ScreenUtil().setHeight(20),
                                ),
                                ElevatedButton.icon(
                                  onPressed: () async {
                                    if (priceSolesController.text.isEmpty) showToast2('El Precio en Soles sin IGV no debe estar vacío', Colors.red);
                                    if (priceDollarController.text.isEmpty)
                                      showToast2('El Precio en Dólares sin IGV no debe estar vacío', Colors.red);

                                    final _api = ProveedoresApi();
                                    final recurso = MaterialesProveedorModel();
                                    recurso.idMaterial = material.idMaterial;
                                    recurso.idRecurso = material.idRecurso;
                                    recurso.umMaterial = material.umMaterial;
                                    recurso.solesMaterial = priceSolesController.text;
                                    recurso.igvSolesMaterial = priceSolesIGVController.text;
                                    recurso.dolaresMaterial = priceDollarController.text;
                                    recurso.igvDolaresMaterial = priceDollarIGVController.text;
                                    _controller.changeCargando(true);
                                    final res = await _api.editPriceMaterial(recurso);
                                    _controller.changeCargando(false);

                                    if (res.code != 1) return showToast2('Ocurrió un error, inténtelo nuevamente', Colors.redAccent);
                                    showToast2('Precios editados correctamente', Colors.green);
                                    Navigator.pop(context);
                                    final materialsBloc = ProviderBloc.provee(context);
                                    materialsBloc.getMaterialsProveedoresById(proveedor.idProveedor!);
                                  },
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18.0),
                                      ),
                                    ),
                                    backgroundColor: MaterialStateProperty.all(Colors.indigo),
                                    padding: MaterialStateProperty.all<EdgeInsets>(
                                      EdgeInsets.symmetric(
                                        horizontal: ScreenUtil().setWidth(15),
                                        vertical: ScreenUtil().setHeight(4),
                                      ),
                                    ),
                                  ),
                                  icon: Icon(
                                    Icons.check,
                                    size: ScreenUtil().setHeight(25),
                                  ),
                                  label: Text(
                                    'Guardar',
                                    style: TextStyle(fontSize: ScreenUtil().setSp(20), fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            AnimatedBuilder(
                animation: _controller,
                builder: (context, snapshot) {
                  return ShowLoadding(
                    active: _controller.cargando,
                    color: Colors.black.withOpacity(0.4),
                  );
                }),
          ],
        );
      },
    );
  }
}
