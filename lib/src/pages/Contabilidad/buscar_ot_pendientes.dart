import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soal_app/src/bloc/provider_bloc.dart';
import 'package:soal_app/src/models/obligacion_tributaria_model.dart';
import 'package:soal_app/src/pages/Contabilidad/item_ot_widget.dart';
import 'package:soal_app/src/widgets/text_field_search.dart';

class BuscarOTPendientes extends StatefulWidget {
  const BuscarOTPendientes({Key? key}) : super(key: key);

  @override
  State<BuscarOTPendientes> createState() => _BuscarOTPendientesState();
}

class _BuscarOTPendientesState extends State<BuscarOTPendientes> {
  final _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final otBloc = ProviderBloc.ot(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Obligaciones Tributarias Pendientes',
          style: TextStyle(
            fontSize: ScreenUtil().setSp(15),
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          TextFieldSearch(
            label: 'Buscar...',
            controller: _searchController,
            onChanged: (value) {
              otBloc.searchOTPendientes(value);
            },
          ),
          SizedBox(height: ScreenUtil().setHeight(20)),
          Expanded(
            child: StreamBuilder<List<ObligacionTributariaModel>>(
                stream: otBloc.searchOTPendientesStream,
                builder: (_, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.isNotEmpty) {
                      return Expanded(
                        child: ListView.builder(
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
                        ),
                      );
                    } else {
                      return const Center(
                        child: Text('Sin resultados'),
                      );
                    }
                  } else {
                    return Container();
                  }
                }),
          ),
        ],
      ),
    );
  }
}
