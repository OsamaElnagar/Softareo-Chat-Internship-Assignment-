// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../bloc/loginCubit/cubit.dart';
import '../bloc/registerCubit/cubit.dart';
import 'colors.dart';
import 'fonts.dart';

class SoftareoTextFormField extends StatelessWidget {
  SoftareoTextFormField({
    Key? key,
    required this.hintText,
    required this.controller,
    this.focusNode,
    this.label,
    this.validator,
    this.onFieldSubmitted,
    this.onChanged,
    this.keyboardType,
    this.textInputAction, this.height,
  }) : super(key: key);

  final String hintText;
  String? label;
  String? Function(String?)? validator;
  void Function(String)? onFieldSubmitted;
  void Function(String)? onChanged;
  final TextEditingController controller;
  dynamic keyboardType;
  final FocusNode? focusNode;
  TextInputAction? textInputAction;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height:height ?? 70,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.black,
      ),
      child: TextFormField(
        textInputAction: textInputAction,
        focusNode: focusNode,
        controller: controller,
        keyboardType: keyboardType,
        style: GoogleFonts.montserrat(
          color: SoftareoColors.softareoGhostWhite,
        ),
        maxLines: 1,
        decoration: InputDecoration(
         // label: WeLinkHints(hint: label!),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: SoftareoColors.softareoCerise),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: SoftareoColors.softareoGrey),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            hintText: hintText,
            hintStyle: GoogleFonts.montserrat(
                color: SoftareoColors.softareoGrey, fontWeight: FontWeight.w600),
            focusColor: SoftareoColors.softareoCerise,
            contentPadding: const EdgeInsets.all(30)),
        validator: validator,
        onFieldSubmitted: onFieldSubmitted,
        onChanged: onChanged,
      ),
    );
  }
}

class SoftareoPassFormField extends StatelessWidget {
  SoftareoPassFormField({
    Key? key,
    required this.hintText,
    required this.controller,
    this.focusNode,
    this.label,
    this.validator,
    this.onFieldSubmitted,
    this.onChanged,
    this.keyboardType,
    this.textInputAction,
    this.loginCubit,
    this.registerCubit,
  }) : super(key: key);

  final String hintText;
  String? label;
  String? Function(String?)? validator;
  void Function(String)? onFieldSubmitted;
  void Function(String)? onChanged;
  final TextEditingController controller;
  dynamic keyboardType;
  final FocusNode? focusNode;
  TextInputAction? textInputAction;
  LoginCubit? loginCubit;
  RegisterCubit? registerCubit;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.black,
      ),
      child: TextFormField(
        textInputAction: textInputAction,
        focusNode: focusNode,
        controller: controller,
        keyboardType: keyboardType,
        style: GoogleFonts.montserrat(
          color: SoftareoColors.softareoOrange,
        ),
        decoration: InputDecoration(
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: SoftareoColors.softareoCerise),
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: SoftareoColors.softareoGrey),
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          hintText: hintText,
          hintStyle: SoftareoTextStyles.softareoHintMontserrat(fs: 17.0),
          contentPadding: const EdgeInsets.all(30),
          suffixIcon: IconButton(
            onPressed: loginCubit != null
                ? loginCubit!.changePasswordVisibility
                : registerCubit!.changePasswordVisibility,
            icon: Icon(
              loginCubit != null ? loginCubit!.visible : registerCubit!.visible,
            ),
          ),
          focusColor: SoftareoColors.softareoCerise,
        ),
        obscureText:
            loginCubit != null ? loginCubit!.isShown : registerCubit!.isShown,
        validator: validator,
        onEditingComplete: () {},
        onFieldSubmitted: onFieldSubmitted,
        onChanged: onChanged,
      ),
    );
  }
}
