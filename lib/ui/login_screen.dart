import 'package:abhedya_flutter_assessment/a_utils/extensions.dart';
import 'package:abhedya_flutter_assessment/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../a_utils/colors.dart';
import '../a_utils/text_formatters.dart';
import 'widgets/lottie_widgets.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final userTC = TextEditingController();
  final pswdTC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const TextW('Login')),
      body: Container(
        width: Get.width,
        height: Get.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [HexColor("#B93B72"), HexColor("#CA6A6B")]),
        ),
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: Lotties.loginMale(),
            ),
            Expanded(
              flex: 7,
              child: Container(
                width: double.maxFinite,
                height: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 48.s, vertical: 20.s),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.s),
                        topRight: Radius.circular(30.s)),
                    color: Colors.white),
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.topLeft,
                      child: TextW("Welcome", textScaleFactor: 2, isBold: true),
                    ),
                    const Spacer(flex: 1),
                    usernameW(),
                    const SizedBox(height: 25),
                    passwordW(),
                    const Spacer(flex: 2),
                    ElevatedButton(
                        onPressed: () async {
                          if (userTC.text.length > 2 &&
                              pswdTC.text.length > 2) {
                            // Navigator.of(context).pushNamedAndRemoveUntil(
                            //     '/main', (route) => false);
                            context.goNamed("main",
                                pathParameters: {'username': userTC.text});

                            userTC.dispose();
                            pswdTC.dispose();
                            // Get.to(MainScreen(userTC.text));
                          } else {}
                        },
                        child: const TextW("Login")),
                    const Spacer(flex: 2),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //
  Widget usernameW() {
    return TextField(
      controller: userTC,
      inputFormatters: [TrimTextFormatter()],
      decoration: InputDecoration(
          border: fieldBoarder(),
          prefixIcon: Icon(MdiIcons.account, color: Colors.black54),
          labelText: "username"),
    );
  }

  //
  Widget passwordW() {
    bool isObscure = true;
    return StatefulBuilder(builder: (context, setState) {
      return TextField(
        controller: pswdTC,
        inputFormatters: [TrimTextFormatter()],
        obscureText: isObscure,
        decoration: InputDecoration(
            border: fieldBoarder(),
            prefixIcon: Icon(MdiIcons.key, color: Colors.black54),
            labelText: "password",
            suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    isObscure = !isObscure;
                  });
                },
                icon: Icon(
                    isObscure == true ? MdiIcons.eyeOffOutline : MdiIcons.eye,
                    color: Colors.black26))),
      );
    });
  }

  //
  OutlineInputBorder fieldBoarder({Color? color}) {
    return OutlineInputBorder(
      borderSide: BorderSide(width: 0.5, color: color ?? Colors.black26),
      borderRadius: BorderRadius.circular(25.s),
    );
  }
}

extension GoRouterExtension on GoRouter {
  // Navigate back to a specific route
  void popUntilPath(BuildContext context, String ancestorPath) {
    while (routerDelegate.currentConfiguration.matches.last.matchedLocation !=
        ancestorPath) {
      if (!context.canPop()) {
        return;
      }
      context.pop();
    }
  }
}
