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
    final userBloc = ProviderBloc.data(context);
    userBloc.obtenerUser();
    return StreamBuilder<UserModel>(
      stream: userBloc.userStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container(
            margin: EdgeInsets.only(left: ScreenUtil().setWidth(8)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: ScreenUtil().setWidth(80),
                  height: ScreenUtil().setHeight(80),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(
                      'assets/images/icon.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return Container(
          margin: EdgeInsets.only(left: ScreenUtil().setWidth(8)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: ScreenUtil().setSp(30),
                child: Container(
                  width: ScreenUtil().setWidth(60),
                  height: ScreenUtil().setHeight(60),
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
                            color: Colors.indigo,
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
                  fontSize: ScreenUtil().setSp(14),
                ),
              ),
              Text(
                '${snapshot.data!.roleName}',
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.w500,
                  fontSize: ScreenUtil().setSp(12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
