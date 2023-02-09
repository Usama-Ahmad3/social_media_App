import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_media/res/color.dart';

class InputTextField extends StatelessWidget {
  const InputTextField(
      {Key? key,
      required this.myController,
      required this.focusNode,
      required this.onFileSubmittedValue,
      required this.onValidator,
      required this.keyboardType,
      required this.hint,
      required this.obscureText,
      this.enable = true,
      this.autoFocus = false})
      : super(key: key);
  final TextEditingController myController;
  final FocusNode focusNode;
  final FormFieldSetter onFileSubmittedValue;
  final FormFieldValidator onValidator;
  final TextInputType keyboardType;
  final String hint;
  final bool obscureText;
  final bool enable, autoFocus;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: TextFormField(
        controller: myController,
        focusNode: focusNode,
        onFieldSubmitted: onFileSubmittedValue,
        validator: onValidator,
        keyboardType: keyboardType,
        obscureText: obscureText,
        enabled: enable,
        style: Theme.of(context)
            .textTheme
            .bodyText2!
            .copyWith(height: 0, fontSize: 19),
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(15),
            hintText: hint,
            hintStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
                height: 0,
                color: AppColors.primaryTextTextColor.withOpacity(0.8)),
            border: const OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.textFieldDefaultFocus),
                borderRadius: BorderRadius.all(Radius.circular(8))),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.secondaryColor),
                borderRadius: BorderRadius.all(Radius.circular(8))),
            errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.alertColor),
                borderRadius: BorderRadius.all(Radius.circular(8))),
            enabledBorder: const OutlineInputBorder(
                borderSide:
                    BorderSide(color: AppColors.textFieldDefaultBorderColor),
                borderRadius: BorderRadius.all(Radius.circular(8)))),
      ),
    );
  }
}
