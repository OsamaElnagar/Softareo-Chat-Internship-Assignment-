import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:bloc/bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softareo_chat/modules/chatsScreen.dart';
import 'package:softareo_chat/modules/loginScreen.dart';
import 'package:softareo_chat/modules/splash.dart';
import 'package:softareo_chat/shared/bloc/AppCubit/cubit.dart';
import 'package:softareo_chat/shared/bloc/AppCubit/states.dart';
import 'package:softareo_chat/shared/network/local/blocObserver.dart';
import 'package:softareo_chat/shared/network/local/cache_helper.dart';
import 'package:softareo_chat/shared/styles/colors.dart';

import 'shared/components/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();
  CachedNetworkImage.logLevel = CacheManagerLogLevel.debug;
  final Widget stWidget;
  uId = CacheHelper.getData('uid');
    if (uId != null) {
      stWidget =  ChatsScreen();
    } else {
      stWidget = const LoginScreen();
    }

  runApp( MyApp(stWidget: stWidget,));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.stWidget}) : super(key: key);

  final Widget stWidget;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(AppInitialState())..getUserData()..getAllUsers(),
      child:  MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AnimatedSplashScreen(
          splashIconSize: 500,
          splash: const SplashScreen(),
          centered: true,
          disableNavigation: false,
          nextScreen:stWidget,
          backgroundColor: SoftareoColors.softareoRoyalBlue,
          animationDuration: const Duration(milliseconds: 1100),
          duration: 2000,
        ),
      ),
    );
  }
}
