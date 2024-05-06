import 'package:cardapio_ufam/bloc/login_bloc.dart';
import 'package:cardapio_ufam/repositories/token_repository.dart';
import 'package:cardapio_ufam/screens/main_screen.dart';
import 'package:cardapio_ufam/widgets/error_alert.dart';
import 'package:cardapio_ufam/widgets/input_field.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.signOut});

  final bool signOut;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final tokenRepository = TokenRepository();
  final _loginBloc = LoginBloc();

  static const mainColor = Color.fromRGBO(198, 126, 20, 1);static const lightMainColor = Color.fromRGBO(234, 157, 19, 1);

  @override
  void initState() {
    super.initState();

    tokenRepository.getData().then((data) {
      DateTime dt1 = DateTime.parse(data);
      DateTime dt2 = DateTime.now();
      dt1 = dt1.add(const Duration(hours: 12));

      if(dt2.isBefore(dt1)) {
        tokenRepository.getToken().then((token) {
          _loginBloc.setToken(token, data, widget.signOut);
        });
      } else {
        _loginBloc.setToken("", data, widget.signOut);
      }
    });

    _loginBloc.outStatus.listen((state) {
      switch(state) {
        case LoginStatus.start:
          break;
        case LoginStatus.idle:
          tokenRepository.saveToken(_loginBloc.getToken, null);
          break;
        case LoginStatus.loading:
          break;
        case LoginStatus.success:
          tokenRepository.saveToken(_loginBloc.getToken, _loginBloc.getDate);
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MainScreen(token: _loginBloc.getToken,),),);
          break;
        case LoginStatus.fail:
          showDialog(context: context, builder: (context) => const ErrorAlert());
          break;
      }
    });

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 96),
        child: StreamBuilder<LoginStatus>(
          stream: _loginBloc.outStatus,
          initialData: LoginStatus.idle,
          builder: (context, snapshot) {
            switch(snapshot.data!) {
              case LoginStatus.loading:
                return const Center(child: CircularProgressIndicator(),);
              case LoginStatus.start:
              case LoginStatus.idle:
              case LoginStatus.success:
              case LoginStatus.fail:
                return Padding(
                padding: const EdgeInsets.all(32.0),
                child: Stack(alignment: Alignment.center,
                  children: [
                    Container(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              image: AssetImage(
                                "assets/imgs/logo.png",
                              ),
                              width: 120,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("CARDÁPIO",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 38,
                                        fontFamily: "Serif_JP")),
                                Text("UFAM",
                                    style: TextStyle(
                                      color: mainColor,
                                      fontSize: 38,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Roboto_Slab",
                                    )),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                        const Text(
                          "Login",
                          style: TextStyle(
                              color: mainColor,
                              fontSize: 38,
                              fontFamily: "Roboto_Slab"),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        InputField(
                          hint: "CPF",
                          obscure: false,
                          inputType: TextInputType.number,
                          stream: _loginBloc.outCpf,
                          onChanged: _loginBloc.changeCpf,
                          needMask: true,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        InputField(
                          hint: "SENHA",
                          obscure: true,
                          inputType: TextInputType.text,
                          stream: _loginBloc.outPassword,
                          onChanged: _loginBloc.changePassword,
                          needMask: false,
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        StreamBuilder<bool>(
                            stream: _loginBloc.outSubmitValue,
                            builder: (context, snapshot) {
                              return SizedBox(
                                height: 45,
                                child: ElevatedButton(
                                    onPressed: snapshot.hasData ? _loginBloc.submit : null,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: lightMainColor,
                                      disabledBackgroundColor: lightMainColor.withAlpha(100),
                                    ),
                                    child: const Text(
                                      "ENTRAR",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )),
                              );
                            }
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }

          }
        ),
      ),
    );
  }
}
