import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softareo_chat/shared/bloc/AppCubit/cubit.dart';
import 'package:softareo_chat/shared/bloc/AppCubit/states.dart';
import 'package:softareo_chat/shared/styles/colors.dart';
import 'package:softareo_chat/shared/styles/texts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //
  // @override
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 300,
              child: FlutterLogo(
                size: 150,
              ),
            ),
            SoftareoNormalTexts(
              norText: ' S O F T  C H A T  I S  L O A D I N G . .',
              color: SoftareoColors.softareoCelestialBlue,
              fw: FontWeight.w700,
              fs: 18.0,
            )
          ],
        );
      },
    );
  }
}
