import 'package:cardapio_ufam/bloc/login_bloc.dart';
import 'package:cardapio_ufam/screens/login_screen.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  static const mainColor = Color.fromRGBO(198, 126, 20, 1);
  static const lightMainColor = Color.fromRGBO(234, 157, 19, 1);
  static const textColor = Color.fromRGBO(94, 94, 94, 1);

  static const timeTextStyle = TextStyle(
    color: textColor,
    fontSize: 16,
    letterSpacing: 0.5,
  );

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: lightMainColor,
      width: MediaQuery.of(context).size.width * 0.8,
      child: SafeArea(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage(
                        "assets/imgs/logo.png",
                      ),
                      width: 90,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("CARDÁPIO",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 28.5,
                                fontFamily: "Serif_JP")),
                        Text(
                          "UFAM",
                          style: TextStyle(
                            color: mainColor,
                            fontSize: 28.5,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Roboto_Slab",
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Container(
                  height: 16,
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: textColor),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: textColor,
                      ),
                    ),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Horários de Funcionamento:",
                        style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          letterSpacing: 0.65,
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Desjejum:",
                              style: timeTextStyle,
                            ),
                            Text(
                              "6:30h às   8:30h",
                              style: timeTextStyle,
                            ),
                          ]),

                      SizedBox(
                        height: 10,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Almoço:",
                              style: timeTextStyle,
                            ),
                            Text(
                              "11:00h às 14:00h",
                              style: timeTextStyle,
                            ),
                          ]),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Jantar:",
                              style: timeTextStyle,
                            ),
                            Text(
                              "17:30h às 20:30h",
                              style: timeTextStyle,
                            ),
                          ]),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) {
                          LoginBloc().signOut();
                          return const LoginScreen(
                            signOut: true,
                          );
                        }),
                      );
                    },
                    child: const Text(
                      "SAIR",
                      style: TextStyle(
                        color: lightMainColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child: Image.asset("assets/imgs/logo_ru.png", height: 150,),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
