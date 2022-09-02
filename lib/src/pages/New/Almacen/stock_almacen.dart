import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soal_app/src/bloc/provider_bloc.dart';
import 'package:soal_app/src/models/almacenModel.dart';
import 'package:soal_app/src/models/sedesModel.dart';
import 'package:soal_app/src/pages/Home/menu_widget.dart';
import 'package:soal_app/src/widgets/show_loading.dart';
import 'package:soal_app/src/widgets/text_field.dart';
import 'package:soal_app/src/widgets/widgets.dart';

class StockAlmacen extends StatefulWidget {
  const StockAlmacen({Key? key}) : super(key: key);

  @override
  State<StockAlmacen> createState() => _StockAlmacenState();
}

class _StockAlmacenState extends State<StockAlmacen> {
  String idSede = '';
  final _sedeNameController = TextEditingController();
  final _wordKeyController = TextEditingController();

  @override
  void initState() {
    Future.delayed(const Duration(microseconds: 100), () async {
      filtro();
    });
    super.initState();
  }

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
              almacenBloc.getStockAlmacen(idSede, _wordKeyController.text.trim());
            },
            icon: Icon(
              Icons.refresh,
              color: Colors.indigo,
            ),
          ),
          IconButton(
            onPressed: () {
              filtro();
            },
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
                  if (snapshot.data!.isEmpty)
                    return Center(
                        child: Text('Sin recursos disponibles para ' +
                            "${(idSede.isNotEmpty && idSede != '') ? _sedeNameController.text : 'Todas las Sedes'}"));

                  return ListView.builder(
                    itemCount: snapshot.data!.length + 1,
                    itemBuilder: (_, index) {
                      if (index == 0) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setWidth(16),
                          ),
                          child: Column(
                            children: [
                              Text(
                                (idSede.isNotEmpty && idSede != '') ? _sedeNameController.text : 'Todas las Sedes',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: ScreenUtil().setSp(14),
                                ),
                              ),
                              SizedBox(height: ScreenUtil().setHeight(8)),
                              Row(
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
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
                    textAlign: TextAlign.center,
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
        height: 60,
        mtop: 20,
      ),
    );
  }

  void filtro() {
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
                    initialChildSize: 0.8,
                    minChildSize: 0.3,
                    maxChildSize: 0.9,
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
                                  'Filtro',
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
                                  label: 'Sede',
                                  hingText: 'Seleccionar Sede',
                                  controller: _sedeNameController,
                                  widget: Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Colors.indigo,
                                  ),
                                  icon: true,
                                  readOnly: true,
                                  ontap: () {
                                    FocusScope.of(context).unfocus();
                                    _selectSede(context);
                                  },
                                ),
                                SizedBox(
                                  height: ScreenUtil().setHeight(20),
                                ),
                                TextFieldSelect(
                                  label: 'Referencia',
                                  hingText: '',
                                  controller: _wordKeyController,
                                  widget: Icon(
                                    Icons.edit,
                                    color: Colors.indigo,
                                  ),
                                  icon: true,
                                  readOnly: false,
                                ),
                                SizedBox(
                                  height: ScreenUtil().setHeight(20),
                                ),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    final almacenBloc = ProviderBloc.almacen(context);
                                    almacenBloc.getStockAlmacen(idSede, _wordKeyController.text.trim());
                                    Navigator.pop(context);
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
                                    Icons.search,
                                    size: ScreenUtil().setHeight(25),
                                  ),
                                  label: Text(
                                    'Buscar ahora',
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
          ],
        );
      },
    );
  }

  void _selectSede(BuildContext context) {
    final almacenBloc = ProviderBloc.almacen(context);
    almacenBloc.getSedes();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return GestureDetector(
          child: Container(
            color: const Color.fromRGBO(0, 0, 0, 0.001),
            child: GestureDetector(
              onTap: () {},
              child: DraggableScrollableSheet(
                initialChildSize: 0.7,
                minChildSize: 0.2,
                maxChildSize: 0.9,
                builder: (_, controller) {
                  return Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25.0),
                        topRight: Radius.circular(25.0),
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.remove,
                          color: Colors.grey[600],
                        ),
                        Text(
                          'Seleccionar Estado',
                          style: TextStyle(
                            color: const Color(0xff5a5a5a),
                            fontWeight: FontWeight.w600,
                            fontSize: ScreenUtil().setSp(20),
                          ),
                        ),
                        const Divider(
                          thickness: 1,
                          color: Colors.black,
                        ),
                        Expanded(
                          child: StreamBuilder<List<SedesModel>>(
                              stream: almacenBloc.sedesStream,
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: CupertinoActivityIndicator(),
                                  );
                                }

                                if (snapshot.data!.isEmpty) {
                                  return Center(
                                    child: Text('Sin información disponible'),
                                  );
                                }

                                return ListView.builder(
                                  controller: controller,
                                  itemCount: snapshot.data!.length + 1,
                                  itemBuilder: (_, index) {
                                    if (index == 0) {
                                      return InkWell(
                                        onTap: () {
                                          idSede = '';
                                          _sedeNameController.clear();

                                          Navigator.pop(context);
                                        },
                                        child: Card(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: Text('Todas las Sedes'),
                                          ),
                                        ),
                                      );
                                    }
                                    index = index - 1;
                                    var sede = snapshot.data![index];
                                    return InkWell(
                                      onTap: () {
                                        idSede = sede.idSede.toString();
                                        _sedeNameController.text = sede.sedeNombre.toString().trim();

                                        Navigator.pop(context);
                                      },
                                      child: Card(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Text(sede.sedeNombre.toString().trim()),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
