import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soal_app/core/sharedpreferences/storage_manager.dart';
import 'package:soal_app/core/util/constants.dart';
import 'package:soal_app/src/bloc/data_user.dart';
import 'package:soal_app/src/bloc/provider_bloc.dart';

class CuentaPage extends StatefulWidget {
  const CuentaPage({Key? key}) : super(key: key);

  @override
  _CuentaPageState createState() => _CuentaPageState();
}

class _CuentaPageState extends State<CuentaPage> {
  @override
  Widget build(BuildContext context) {
    final dataBloc = ProviderBloc.data(context);
    dataBloc.obtenerUser();

    return Scaffold(
      body: StreamBuilder(
          stream: dataBloc.userStream,
          builder: (context, AsyncSnapshot<UserModel> snapshot) {
            if (snapshot.hasData) {
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: ScreenUtil().setHeight(50),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: ScreenUtil().setSp(60),
                          child: Container(
                            width: ScreenUtil().setWidth(120),
                            height: ScreenUtil().setHeight(120),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: CachedNetworkImage(
                                placeholder: (context, url) => Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  //child: Image(image: AssetImage('assets/img/loading.gif'), fit: BoxFit.cover),
                                ),
                                errorWidget: (context, url, error) => Container(
                                  child: Container(
                                    child: SvgPicture.asset(
                                      'assets/svg/userPicture.svg',
                                      fit: BoxFit.cover,
                                      width: ScreenUtil().setWidth(150),
                                      height: ScreenUtil().setHeight(150),
                                    ),
                                  ),
                                ),
                                imageUrl: '${snapshot.data!.userImage}',
                                imageBuilder: (context, imageProvider) => Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.green, width: ScreenUtil().setWidth(3)),
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(20),
                    ),
                    Text(
                      'Nombre',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: ScreenUtil().setSp(18),
                      ),
                    ),
                    Text(
                      '${snapshot.data!.personName} ${snapshot.data!.personSurname}',
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: ScreenUtil().setSp(16),
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(20),
                    ),
                    Text(
                      'Usuario',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: ScreenUtil().setSp(18),
                      ),
                    ),
                    Text(
                      '${snapshot.data!.userNickname}',
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: ScreenUtil().setSp(16),
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(20),
                    ),
                    Text(
                      'Email',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: ScreenUtil().setSp(18),
                      ),
                    ),
                    Text(
                      '${snapshot.data!.userEmail}',
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: ScreenUtil().setSp(16),
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(20),
                    ),
                    Text(
                      'Rol',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: ScreenUtil().setSp(18),
                      ),
                    ),
                    Text(
                      '${snapshot.data!.roleName}',
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: ScreenUtil().setSp(16),
                      ),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () async {
                        await StorageManager.deleteAllData();
                        Navigator.pushNamedAndRemoveUntil(context, LOGIN_ROUTE, (route) => false);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(8)),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.red),
                        ),
                        child: Center(
                          child: Text(
                            'Cerrar sessión',
                            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(40),
                    ),
                  ],
                ),
              );
            } else {
              return Container();
            }
          }),
    );
  }
}
