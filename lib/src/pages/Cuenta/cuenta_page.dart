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
      body: SafeArea(
        child: StreamBuilder(
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
                    SizedBox(height: ScreenUtil().setHeight(50)),
                    Center(
                      child: Container(
                        alignment: Alignment.center,
                        height: ScreenUtil().setHeight(200),
                        width: ScreenUtil().setWidth(200),
                        decoration: BoxDecoration(
                          // border: Border.all(
                          //   color: Color(0XFF050268),
                          //   width: ScreenUtil().setWidth(1),
                          // ),
                          color: Colors.white,
                          //shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.transparent.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                          image: DecorationImage(
                            image: new ExactAssetImage('assets/images/logo.png'),
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: ScreenUtil().setHeight(30)),
                    cards(
                      image: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: ScreenUtil().setSp(25),
                            child: Container(
                              width: ScreenUtil().setWidth(50),
                              height: ScreenUtil().setHeight(50),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: CachedNetworkImage(
                                  placeholder: (context, url) => Container(
                                    width: double.infinity,
                                    height: double.infinity,
                                  ),
                                  errorWidget: (context, url, error) => Container(
                                    child: Container(
                                      child: SvgPicture.asset(
                                        'assets/svg/userPicture.svg',
                                        fit: BoxFit.cover,
                                        color: Colors.purple,
                                        width: ScreenUtil().setWidth(150),
                                        height: ScreenUtil().setHeight(150),
                                      ),
                                    ),
                                  ),
                                  imageUrl: '${snapshot.data!.userImage}',
                                  imageBuilder: (context, imageProvider) => Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.purple, width: ScreenUtil().setWidth(3)),
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
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${snapshot.data!.personName?.split(" ").first} ${snapshot.data!.personSurname}',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: ScreenUtil().setSp(16),
                            ),
                          ),
                          Text(
                            '${snapshot.data!.roleName}',
                            style: TextStyle(
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.bold,
                              fontSize: ScreenUtil().setSp(14),
                            ),
                          ),
                        ],
                      ),
                      color: Colors.purple,
                      height: 35,
                      mtop: 6,
                    ),
                    SizedBox(height: ScreenUtil().setHeight(20)),
                    cards(
                      image: Center(
                        child: Text(
                          '@',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: ScreenUtil().setSp(25),
                          ),
                        ),
                      ),
                      child: Text(
                        '${snapshot.data!.userEmail}',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: ScreenUtil().setSp(16),
                        ),
                      ),
                      color: Colors.blue,
                      height: 25,
                      mtop: 4,
                    ),
                    SizedBox(height: ScreenUtil().setHeight(20)),
                    cards(
                      image: Center(
                        child: Icon(
                          Icons.person_outline,
                          color: Colors.orangeAccent,
                          size: ScreenUtil().setHeight(30),
                        ),
                      ),
                      child: Text(
                        '${snapshot.data!.userNickname}',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: ScreenUtil().setSp(16),
                        ),
                      ),
                      color: Colors.orangeAccent,
                      height: 25,
                      mtop: 4,
                    ),
                    Spacer(),
                    Center(
                      child: TextButton(
                        onPressed: () async {
                          await StorageManager.deleteAllData();
                          Navigator.pushNamedAndRemoveUntil(context, LOGIN_ROUTE, (route) => false);
                        },
                        child: Text(
                          'Cerrar sessión',
                          style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500, fontSize: ScreenUtil().setSp(16)),
                        ),
                      ),
                    ),
                    // InkWell(
                    //   onTap: () async {
                    //     await StorageManager.deleteAllData();
                    //     Navigator.pushNamedAndRemoveUntil(context, LOGIN_ROUTE, (route) => false);
                    //   },
                    //   child: Container(
                    //     padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(8)),
                    //     width: double.infinity,
                    //     decoration: BoxDecoration(
                    //       color: Colors.white,
                    //       borderRadius: BorderRadius.circular(10),
                    //       border: Border.all(color: Colors.red),
                    //     ),
                    //     child: Center(
                    //       child: Text(
                    //         'Cerrar sessión',
                    //         style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    SizedBox(
                      height: ScreenUtil().setHeight(40),
                    ),
                  ],
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  Widget cards({required Widget child, required Widget image, required Color color, required num height, required num mtop}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.transparent.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: ScreenUtil().setWidth(60),
            child: image,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: child,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: ScreenUtil().setHeight(mtop)),
            width: ScreenUtil().setWidth(6),
            height: ScreenUtil().setHeight(height),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                bottomLeft: Radius.circular(5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
