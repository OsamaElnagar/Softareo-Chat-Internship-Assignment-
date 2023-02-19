// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softareo_chat/models/loginModel.dart';
import 'package:softareo_chat/shared/bloc/AppCubit/cubit.dart';
import 'package:softareo_chat/shared/bloc/AppCubit/states.dart';
import 'package:softareo_chat/shared/styles/colors.dart';
import 'package:softareo_chat/shared/styles/iconBroken.dart';

import '../shared/components/build_message_items.dart';

class MessengerScreen extends StatelessWidget {
  LoginModel loginModel;

  MessengerScreen({Key? key, required this.loginModel}) : super(key: key);

  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      AppCubit.get(context).getMessages(receiverId: loginModel.uId);
      return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          var cubit = AppCubit.get(context);
          if (state is AppSendMessageSuccessState) {}
        },
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          return Scaffold(
            backgroundColor: SoftareoColors.softareoRoyalBlue,
            appBar: AppBar(
              leadingWidth: 36,
              title: Row(
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundImage: NetworkImage(loginModel.profileImage),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Expanded(
                      child: Text(loginModel.name,
                          style: const TextStyle(fontSize: 16.0),
                          overflow: TextOverflow.ellipsis)),
                ],
              ),
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  IconBroken.Arrow___Left_2,
                  size: 30,
                ),
              ),
              actions: [
                IconButton(onPressed: () {}, icon: const Icon(IconBroken.Call)),
                IconButton(
                    onPressed: () {}, icon: const Icon(IconBroken.Video)),
              ],
            ),
            body: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    reverse: true,
                    child: ListView.separated(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          var messages = cubit.messages[index];
                          // sent message in topEnd.
                          // received message in topStart.
                          if (cubit.loginModel!.uId == messages.senderId) {
                            return MessageBuilder(
                                chatsModel: messages,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                alignmentDirectional:
                                    AlignmentDirectional.topEnd,
                                radius: const BorderRadiusDirectional.only(
                                  bottomEnd: Radius.circular(15),
                                  topEnd: Radius.circular(0),
                                  topStart: Radius.circular(10),
                                  bottomStart: Radius.circular(0),
                                ),
                                color: SoftareoColors.softareoOrange);
                          }
                          return MessageBuilder(
                              chatsModel: messages,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              alignmentDirectional:
                                  AlignmentDirectional.topStart,
                              radius: const BorderRadiusDirectional.only(
                                bottomEnd: Radius.circular(0),
                                topEnd: Radius.circular(10),
                                topStart: Radius.circular(0),
                                bottomStart: Radius.circular(15),
                              ),
                              color: SoftareoColors.softareoCerise);
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 5,
                          );
                        },
                        itemCount: cubit.messages.length),
                  ),
                ),
                if (cubit.messageImageFile != null && state is !AppSendMessageWithImageLoadingState)
                  Expanded(
                    child: Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        Container(
                          width: 280,
                          height: 350,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Image(
                            image: FileImage(cubit.messageImageFile!),
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                              radius: 20,
                              child: IconButton(
                                  onPressed: () {
                                    cubit.undoGetMessageImage();
                                  },
                                  icon: const Icon(Icons.close))),
                        )
                      ],
                    ),
                  ),
                if (state is AppSendMessageWithImageLoadingState )
                  Expanded(
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        Container(
                          width: 240,
                          height: 240,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image: FileImage(cubit.messageImageFile!),
                              ),
                              color: SoftareoColors.softareoCerise,
                              borderRadius: const BorderRadiusDirectional.only(
                                bottomEnd: Radius.circular(5),
                                topEnd: Radius.circular(5),
                                topStart: Radius.circular(5),
                                bottomStart: Radius.circular(5),
                              )),
                          // child: Column(
                          //   crossAxisAlignment: CrossAxisAlignment.end,
                          //   children: [
                          //     Padding(
                          //       padding: const EdgeInsets.only(
                          //           left: 8.0,
                          //           right: 4.0,
                          //           top: 1.0,
                          //           bottom: 2.0),
                          //       child: Text(
                          //         messageController.text,
                          //         style: const TextStyle(color: Colors.white),
                          //       ),
                          //     ),
                          //     const Padding(
                          //       padding: EdgeInsets.only(
                          //           left: 20.0,
                          //           right: 2.0,
                          //           top: 8.0,
                          //           bottom: 8.0),
                          //       child: Text(
                          //         'loading',
                          //         style: TextStyle(
                          //             color: Colors.grey,
                          //             fontSize: 10,
                          //             height: .5),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                        ),
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.red,
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.cloud_upload),
                          ),
                        ),
                      ],
                    ),
                  ),
                Container(
                  color: Colors.black.withOpacity(.2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: 8.0, bottom: 8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.black54),
                            child: TextFormField(
                              controller: messageController,
                              decoration: InputDecoration(
                                  suffixIcon: InkWell(
                                    onTap: () {
                                      showModalBottomSheet(
                                          backgroundColor: Colors.black54,
                                          context: context,
                                          builder: (context) {
                                            return SizedBox(
                                              height: 90,
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Column(
                                                    children: [
                                                      IconButton(
                                                        onPressed: () {
                                                          cubit
                                                              .getCameraMessageImage();
                                                        },
                                                        icon: const Icon(
                                                          IconBroken.Camera,
                                                          size: 35,
                                                          color: Colors.blue,
                                                        ),
                                                      ),
                                                      const Text(
                                                        'Camera',
                                                        style: TextStyle(
                                                            color: Colors.blue),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    width: 30,
                                                  ),
                                                  Column(
                                                    children: [
                                                      IconButton(
                                                        onPressed: () {
                                                          cubit
                                                              .getGalleryMessageImage();
                                                        },
                                                        icon: const Icon(
                                                          IconBroken.Image_2,
                                                          size: 35,
                                                          color:
                                                              Colors.deepPurple,
                                                        ),
                                                      ),
                                                      const Text(
                                                        'Gallery',
                                                        style: TextStyle(
                                                            color: Colors
                                                                .deepPurple),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            );
                                          });
                                    },
                                    child: const Icon(
                                      IconBroken.Image,
                                      color: Colors.white,
                                    ),
                                  ),
                                  hintText: 'Type your message',
                                  hintStyle:
                                      const TextStyle(color: Colors.white),
                                  border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.horizontal(
                                    right: Radius.circular(20),
                                    left: Radius.circular(20),
                                  ))),
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                              cursorColor: Colors.deepPurple,
                              onFieldSubmitted: (v) {},
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                        child: Container(
                          decoration: const BoxDecoration(
                              color: Colors.deepPurple,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: IconButton(
                            onPressed: () {
                              if (cubit.messageImageFile != null ||
                                  messageController.text != '') {
                                if (cubit.messageImageFile != null) {
                                  cubit.sendMessageWithImage(
                                    receiverId: loginModel.uId,
                                    textMessage: messageController.text,
                                    messageDateTime:
                                        DateTime.now().toLocal().toString(),
                                  );
                                } else {
                                  cubit.senMessage(
                                    receiverId: loginModel.uId,
                                    textMessage: messageController.text,
                                    messageDateTime:
                                        DateTime.now().toLocal().toString(),
                                  );
                                }
                              }
                              messageController.clear();
                              FocusScope.of(context).unfocus();
                            },
                            icon: const Icon(
                              IconBroken.Send,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
  }
}
