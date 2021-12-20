import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soal_app/src/models/proveedores_model.dart';

class DetailProveedor extends StatefulWidget {
  final ProveedorModel proveedor;
  const DetailProveedor({Key? key, required this.proveedor}) : super(key: key);

  @override
  _DetailProveedorState createState() => _DetailProveedorState();
}

class _DetailProveedorState extends State<DetailProveedor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: SafeArea(
              child: Row(
                children: [
                  SizedBox(width: ScreenUtil().setWidth(10)),
                 BackButton(),
                  Expanded(
                    child: Text(
                      '${widget.proveedor.nombre}',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.edit),
                    color: Colors.black,
                  ), IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.delete),
                    color: Colors.black,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
