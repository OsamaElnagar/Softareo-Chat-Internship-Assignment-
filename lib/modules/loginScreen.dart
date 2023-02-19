import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softareo_chat/modules/registerScreen.dart';
import 'package:softareo_chat/shared/bloc/AppCubit/cubit.dart';
import 'package:softareo_chat/shared/bloc/loginCubit/states.dart';
import 'package:softareo_chat/shared/components/components.dart';
import 'package:softareo_chat/shared/network/local/cache_helper.dart';
import '../shared/bloc/loginCubit/cubit.dart';
import '../shared/components/auth_items/auth_banner.dart';
import '../shared/components/auth_items/auth_bottom_bar.dart';

import '../shared/components/constants.dart';
import '../shared/styles/backgrounds.dart';
import '../shared/styles/form_fields.dart';
import '../shared/styles/strings.dart';
import 'chatsScreen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    FocusNode emailNode = FocusNode();
    FocusNode passwordNode = FocusNode();
    var formKey = GlobalKey<FormState>();

    return BlocProvider(
      create: (context) => LoginCubit(LoginInitialState()),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            CacheHelper.saveLoginData(key: 'uid', value: state.uId)
                .then((value) {
              uId = CacheHelper.getData('uid');
              pint(uId.toString());
            }).catchError((onError) {
              pint(onError.toString());
            });

            AppCubit.get(context).getUserData();
            AppCubit.get(context).getAllUsers();
            navigate2(context, ChatsScreen());
            showToast(msg: 'login successfully', state: ToastStates.success);
          }
          if (state is LoginErrorState) {
            showToast(msg: 'Wrong email or password', state: ToastStates.error);
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              body: GestureDetector(
                onTap: () => unFocusNodes([emailNode, passwordNode]),
                child: Stack(
                  children: [
                    Backgrounds.authBackground(),
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              const WeLinkAuthBanner(
                                headline: SoftareoLoginStrings.loginHeadline,
                                tour: SoftareoLoginStrings.loginYourAccount,
                              ),
                              const WeLinkSpacer(),
                              AuthDecoratedContainer(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    children: [
                                      const WeLinkSpacer(),
                                      SoftareoTextFormField(
                                        label: 'Email field',
                                        hintText: 'email',
                                        focusNode: emailNode,
                                        controller: emailController,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return ' Email must not be empty';
                                          }
                                          return null;
                                        },
                                        textInputAction: TextInputAction.next,
                                      ),
                                      const WeLinkSpacer(),
                                      SoftareoPassFormField(
                                        label: 'Password field',
                                        hintText: 'password',
                                        focusNode: passwordNode,
                                        controller: passwordController,
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return ' Password must not be empty';
                                          }
                                          return null;
                                        },
                                        textInputAction: TextInputAction.go,
                                        loginCubit: LoginCubit.get(context),
                                        onChanged: (s) {
                                          if (LoginCubit.get(context).isShown ==
                                              false) {
                                            LoginCubit.get(context)
                                                .changePasswordVisibility();
                                          }
                                        },
                                        onFieldSubmitted: (value) {
                                          if (formKey.currentState!
                                              .validate()) {
                                            FocusScope.of(context).unfocus();
                                          }
                                        },
                                      ),
                                      TextButton(
                                        onPressed: () {},
                                        child: const Text(
                                          'forgot password?',
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                      const WeLinkSpacer(),
                                      ConditionalBuilder(
                                        condition: state is! LoginLoadingState,
                                        fallback: (context) => Stack(
                                          children: [
                                            Center(
                                              child: gradientButton(
                                                title: 'LOGIN',
                                                context: context,
                                              ),
                                            ),
                                            Center(
                                              child: CircularProgressIndicator(
                                                backgroundColor: Colors.black
                                                    .withOpacity(.8),
                                              ),
                                            ),
                                          ],
                                        ),
                                        builder: (context) => gradientButton(
                                          title: 'LOGIN',
                                          context: context,
                                          onPressed: () {
                                            if (formKey.currentState!
                                                .validate()) {
                                              LoginCubit.get(context).userLogin(
                                                email: emailController.text
                                                    .replaceAll(' ', '')
                                                    .toString(),
                                                password:
                                                    passwordController.text,
                                              );
                                            }
                                          },
                                        ),
                                      ),
                                      const WeLinkSpacer(),
                                    ],
                                  ),
                                ),
                              ),
                              const WeLinkSpacer(),
                              AuthBottomBar(
                                question: SoftareoLoginStrings.donHaveAccount,
                                decision: SoftareoLoginStrings.signup,
                                onPressed: () =>
                                    navigate2(context, RegisterScreen()),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
