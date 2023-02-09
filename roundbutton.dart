import 'package:flutter/material.dart';
import 'package:social_media/res/color.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final bool loading;
  final VoidCallback ontap;
  final Color color, textColor;
  const RoundButton(
      {Key? key,
      required this.title,
      this.loading = false,
      required this.ontap,
      this.color = AppColors.primaryColor,
      this.textColor = AppColors.primaryColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: loading ? null : ontap,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(50)),
        child: loading
            ? const Center(
                child: CircularProgressIndicator(
                color: Colors.white,
              ))
            : Center(
                child: Text(title,
                    style: Theme.of(context)
                        .textTheme
                        .headline2!
                        .copyWith(fontSize: 16, color: Colors.white))),
      ),
    );
  }
}
