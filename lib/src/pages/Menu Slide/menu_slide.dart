import 'package:flutter/material.dart';
import 'package:soal_app/core/sharedpreferences/storage_manager.dart';
import 'package:soal_app/src/pages/Menu%20Slide/items_model.dart';
import 'package:soal_app/src/pages/Menu%20Slide/page.dart';

class Drawers extends StatefulWidget {
  const Drawers({Key? key}) : super(key: key);

  @override
  State<Drawers> createState() => _DrawersState();
}

class _DrawersState extends State<Drawers> {
  List<ItemsModel>? items;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        String? idRol = await StorageManager.readData('idRoleUser');
        //ROL GERENCIAS id=3
        switch (idRol) {
          case '2':
            items = menuSuperAdmin;
            break;
          case '3':
            items = menuGerencia;
            break;
          default:
            items = menuOtros;
            break;
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(context),
            _buildItems(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      color: Colors.blue.shade700,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 32,
            backgroundImage: NetworkImage('https://intranet.proonix.com.pe/styles/soal-icono.png'),
          )
        ],
      ),
    );
  }

  Widget _buildItems(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      child: Wrap(
        runSpacing: 16,
        children: [
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => PageInicio()),
              );
            },
          ),
        ],
      ),
    );
  }
}
