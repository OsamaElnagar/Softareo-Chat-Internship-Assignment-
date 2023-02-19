// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:softareo_chat/shared/bloc/AppCubit/cubit.dart';
import 'package:softareo_chat/shared/bloc/AppCubit/states.dart';
import 'package:softareo_chat/shared/components/constants.dart';
import 'package:softareo_chat/shared/styles/paddings.dart';
import '../shared/components/build_chat_item.dart';
import '../shared/components/components.dart';
import '../shared/components/my_loading.dart';
import '../shared/styles/colors.dart';
import '../shared/styles/form_fields.dart';
import '../shared/styles/iconBroken.dart';

class ChatsScreen extends StatefulWidget {
  ChatsScreen({Key? key}) : super(key: key);

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  TextEditingController searchUserController = TextEditingController();

  RefreshController refreshController = RefreshController(initialRefresh: true);

  getUsers() async {
    setState(() {
      AppCubit.get(context).allUsers.clear();
    });
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      AppCubit.get(context).getAllUsers();
    });
    refreshController.refreshCompleted();
  }

  @override
  void initState() {
    getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          backgroundColor: SoftareoColors.softareoRoyalBlue,
          appBar: AppBar(
            backgroundColor: SoftareoColors.softareoCelestialBlue,
            title: const Text('Messages'),
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () {
                    pint('users count: ${cubit.allUsers.length}');
                    pint('user uid: $uId');
                    cubit.wannaSearch(context);
                    FocusScope.of(context).requestFocus(cubit.searchUserNode);
                  },
                  icon: const Icon(IconBroken.Search)),
              IconButton(
                  onPressed: () {
                    logOut(context);
                  },
                  icon: const Icon(IconBroken.Logout)),
            ],
          ),
          body: SmartRefresher(
            controller: refreshController,
            header: WaterDropHeader(
              waterDropColor: Colors.green.shade700,
              refresh: const MyLoading(),
              complete: Container(),
              completeDuration: Duration.zero,
            ),
            onRefresh: () => getUsers(),
            child: SafeArea(
              child: GestureDetector(
                onTap: () => unFocusNodes([]),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      children: [
                        if (cubit.wannaSearchForUser)
                          SoftareoPaddings.softareoAuthPadding(
                            child: SoftareoTextFormField(
                              height: 60,
                              label: 'Search for a Softareo Chat',
                              hintText: 'Search for a Softareo Chat',
                              focusNode: cubit.searchUserNode,
                              controller: searchUserController,
                              keyboardType: TextInputType.name,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return ' name must not be empty';
                                }
                                return null;
                              },
                              textInputAction: TextInputAction.next,
                            ),
                          ),
                        ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) => BuildChatItem(
                              loginModel: AppCubit.get(context).allUsers[index],
                              index: index),
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 2,
                          ),
                          itemCount: AppCubit.get(context).allUsers.length,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
