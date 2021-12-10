import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soal_app/core/util/constants.dart';
import 'package:soal_app/core/util/utils.dart';
import 'package:soal_app/src/api/login_api.dart';
import 'package:soal_app/src/widgets/show_loading.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _passwdController = TextEditingController();

  final _controller = ControllerLogin();

  @override
  void dispose() {
    _usuarioController.dispose();
    _passwdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: ScreenUtil().setHeight(50),
                    ),
                    Text(
                      'Bienvenido ',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: ScreenUtil().setSp(24),
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(10),
                    ),
                    
                    Container(
                      height: ScreenUtil().setHeight(200),
                      width: double.infinity,
                      child: Image(
                        image: AssetImage('assets/images/logo.png'),
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(40),
                    ),
                    Text(
                      'Iniciar sesión',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: ScreenUtil().setSp(19),
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(40),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(24)),
                      child: TextField(
                        maxLines: 1,
                        controller: _usuarioController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: 'Usuario',
                          hintStyle: TextStyle(
                            color: Color(0XFF808080),
                            fontWeight: FontWeight.w400,
                            fontSize: ScreenUtil().setSp(16),
                            fontStyle: FontStyle.normal,
                          ),
                          filled: true,
                          fillColor: Color(0XFFEEEEEE),
                          contentPadding:
                              EdgeInsets.only(left: ScreenUtil().setWidth(10), top: ScreenUtil().setHeight(5), bottom: ScreenUtil().setHeight(1)),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Color(0XFFEEEEEE), width: ScreenUtil().setWidth(1)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Color(0XFFEEEEEE), width: ScreenUtil().setWidth(1)),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Color(0XFFEEEEEE), width: ScreenUtil().setWidth(1)),
                          ),
                        ),
                        style: TextStyle(
                          color: Color(0XFF585858),
                          fontWeight: FontWeight.w400,
                          fontSize: ScreenUtil().setSp(16),
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(16),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(24)),
                      child: TextField(
                        maxLines: 1,
                        controller: _passwdController,
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Contraseña',
                          hintStyle: TextStyle(
                            color: Color(0XFF808080),
                            fontWeight: FontWeight.w400,
                            fontSize: ScreenUtil().setSp(16),
                            fontStyle: FontStyle.normal,
                          ),
                          filled: true,
                          fillColor: Color(0XFFEEEEEE),
                          contentPadding:
                              EdgeInsets.only(left: ScreenUtil().setWidth(10), top: ScreenUtil().setHeight(5), bottom: ScreenUtil().setHeight(1)),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Color(0XFFEEEEEE), width: ScreenUtil().setWidth(1)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Color(0XFFEEEEEE), width: ScreenUtil().setWidth(1)),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Color(0XFFEEEEEE), width: ScreenUtil().setWidth(1)),
                          ),
                        ),
                        style: TextStyle(
                          color: Color(0XFF585858),
                          fontWeight: FontWeight.w400,
                          fontSize: ScreenUtil().setSp(16),
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(50),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(24)),
                      width: double.infinity,
                      child: MaterialButton(
                        height: ScreenUtil().setHeight(48),
                        color: Color(0XFF2684FE),
                        textColor: Colors.white,
                        elevation: 0,
                        onPressed: () async {
                          if (_usuarioController.text.length > 0) {
                            if (_passwdController.text.length > 0) {
                              _controller.changeLoadding(true);
                              final _login = LoginApi();
                              final res = await _login.login(_usuarioController.text, _passwdController.text);

                              if (res.code == 1) {
                                Navigator.pushNamed(context, HOME_ROUTE);
                              } else {
                                showToast2(res.message, Colors.black);
                              }
                              _controller.changeLoadding(false);
                            } else {
                              showToast2('Ingrese su contraseña', Colors.black);
                            }
                          } else {
                            showToast2('Ingrese su usuario', Colors.black);
                          }
                          //
                        },
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(100),
                          ),
                        ),
                        child: Text(
                          'Ingresar',
                          style: Theme.of(context).textTheme.button!.copyWith(
                                color: Colors.white,
                                fontSize: ScreenUtil().setSp(16),
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(16),
                    ),
                    Text(
                      '¿Olvidó la contraseña?',
                      style: TextStyle(
                        color: Color(0XFF2684FE),
                        fontWeight: FontWeight.w500,
                        fontSize: ScreenUtil().setSp(12),
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(150),
                    ),
                  ],
                ),
              ),
            ),
            AnimatedBuilder(
                animation: _controller,
                builder: (context, snapshot) {
                  return ShowLoadding(
                    active: _controller.loadding,
                  );
                }),
          ],
        ),
      ),
    );
  }
}

class ControllerLogin extends ChangeNotifier {
  bool loadding = false;
  void changeLoadding(bool v) {
    loadding = v;
    notifyListeners();
  }
}
