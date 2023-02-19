import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:softareo_chat/shared/styles/colors.dart';
import 'package:softareo_chat/shared/styles/texts.dart';
import '../../models/loginModel.dart';
import '../../modules/messengerScreen.dart';
import '../styles/iconBroken.dart';
import 'components.dart';

class BuildChatItem extends StatelessWidget {
  const BuildChatItem({Key? key, required this.loginModel, required this.index})
      : super(key: key);
  final LoginModel loginModel;
  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigateTo(
            context,
            MessengerScreen(
              loginModel: loginModel,
            ));
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 5),
        color: SoftareoColors.softareoCelestialBlue,
        child: Padding(
          padding: const EdgeInsets.only(left: 2, right: 2, bottom: 4, top: 4),
          child: Row(
            children: [
              CircleAvatar(
                radius: 34.0,
                backgroundColor: SoftareoColors.softareoRoyalBlue,
                child: CircleAvatar(
                  radius: 32.0,
                  backgroundImage: NetworkImage(loginModel.profileImage),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SoftareoNormalTexts(norText: loginModel.name,color: SoftareoColors.softareoGhostWhite,fs: 16,),
                    ///////////////////////////
                    // i will display here th last message
                    SoftareoHints(hint: 'last message',color: SoftareoColors.softareoRoyalBlue,)
                  ],
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  IconBroken.More_Circle,
                  color: SoftareoColors.softareoGhostWhite,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
