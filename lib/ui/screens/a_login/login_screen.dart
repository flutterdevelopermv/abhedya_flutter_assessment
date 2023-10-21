// ignore_for_file: use_build_context_synchronously

import 'package:abhedya_flutter_assessment/a_utils/extensions.dart';
import 'package:abhedya_flutter_assessment/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../../../a_utils/colors.dart';
import '../../../a_utils/text_formatters.dart';
import '../../routes/go_routes.dart';
import '../../widgets/lottie_widgets.dart';
import '../b_main/main_screen.dart';
import 'bloc/login_bloc.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final userTC = TextEditingController();
  final pswdTC = TextEditingController();
  final Gradient gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [HexColor("#B93B72"), HexColor("#CA6A6B")]);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          decoration: BoxDecoration(gradient: gradient),
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
                  padding:
                      EdgeInsets.symmetric(horizontal: 48.s, vertical: 20.s),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.s),
                          topRight: Radius.circular(30.s)),
                      color: Colors.white),
                  child: BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      return Column(
                        children: [
                          const Align(
                            alignment: Alignment.topLeft,
                            child: TextW("Login",
                                textScaleFactor: 2, isBold: true),
                          ),
                          const Spacer(),
                          usernameW(),
                          const SizedBox(height: 25),
                          passwordW(context, state),
                          const Spacer(),
                          errorW(state),
                          const Spacer(),
                          continueW(context),
                          const Spacer(flex: 2),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget continueW(BuildContext context) {
    return InkWell(
      child: Container(
        height: 45,
        width: 200,
        decoration: BoxDecoration(
            gradient: gradient, borderRadius: BorderRadius.circular(15)),
        child: const Center(
          child: TextW("Continue",
              isBold: true,
              isHeading: true,
              isWhite: true,
              textAlign: TextAlign.center),
        ),
      ),
      onTap: () async {
        await Future.delayed(const Duration(milliseconds: 300));
        String errorText = "";
        if (userTC.text.length > 2 && pswdTC.text.length > 2) {
        
          Routes.navigateTo(context,
              routeName: Routes.main, screen: MainScreen(userTC.text));
          userTC.dispose();
          pswdTC.dispose();
        } else {
          errorText = "Invalid Credentials";
        }
        context.read<LoginBloc>().add(LoginButtonErrorEvent(errorText));
      },
    );
  }

  Widget errorW(LoginState state) {
    return TextW(state is LoginButtonErrorSate ? state.message : "",
        color: Colors.red);
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
  Widget passwordW(BuildContext context, LoginState state) {
    bool obscureText = true;
    if (state is LoginPasswordObscureState) {
      obscureText = state.obscureText;
    }

    return TextField(
      controller: pswdTC,
      inputFormatters: [TrimTextFormatter()],
      obscureText: obscureText,
      decoration: InputDecoration(
          border: fieldBoarder(),
          prefixIcon: Icon(MdiIcons.key, color: Colors.black54),
          labelText: "password",
          suffixIcon: IconButton(
              onPressed: () {
                context
                    .read<LoginBloc>()
                    .add(LoginPasswordToggleEvent(!obscureText));
              },
              icon: Icon(obscureText ? MdiIcons.eyeOffOutline : MdiIcons.eye,
                  color: Colors.black26))),
    );
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
