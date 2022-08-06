import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soal_app/src/bloc/data_user.dart';
import 'package:soal_app/src/bloc/provider_bloc.dart';

class InfoUser extends StatelessWidget {
  const InfoUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dataBloc = ProviderBloc.data(context);
    dataBloc.obtenerUser();

    return StreamBuilder(
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
          );
        } else {
          return Container();
        }
      },
    );
  }
}
