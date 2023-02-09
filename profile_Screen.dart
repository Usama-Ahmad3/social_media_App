import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media/res/color.dart';
import 'package:social_media/res/components/roundbutton.dart';
import 'package:social_media/view_model/pickImage_controller/pickImage_controller.dart';
import 'package:social_media/view_model/splash_services/session_manager.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ref = FirebaseDatabase.instance.ref('user');
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: ChangeNotifierProvider(
          create: (_) => ImagePickController(),
          child: Consumer<ImagePickController>(
            builder: (BuildContext context, value, Widget? child) {
              return SafeArea(
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: StreamBuilder(
                      stream: ref
                          .child(SessionController().userid.toString())
                          .onValue,
                      builder: (context, AsyncSnapshot snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasData) {
                          Map<dynamic, dynamic> map =
                              snapshot.data.snapshot.value;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
                              Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    child: Center(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: AppColors.secondaryColor,
                                                width: 5)),
                                        height: 130,
                                        width: 130,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: value.image == null
                                              ? map['profile'].toString() == ''
                                                  ? const Icon(
                                                      Icons.person,
                                                      size: 80,
                                                    )
                                                  : Image.network(
                                                      map['profile'].toString(),
                                                      fit: BoxFit.cover,
                                                      loadingBuilder: (context,
                                                          child,
                                                          loadingProgress) {
                                                        if (loadingProgress ==
                                                            null) return child;
                                                        return const Center(
                                                            child:
                                                                CircularProgressIndicator());
                                                      },
                                                      errorBuilder: (context,
                                                              error,
                                                              stackTrace) =>
                                                          const Icon(
                                                        Icons.error_outline,
                                                        color: AppColors
                                                            .alertColor,
                                                      ),
                                                    )
                                              : Image.file(
                                                  value.image!.absolute),
                                        ),
                                      ),
                                    ),
                                  ),
                                  CircleAvatar(
                                    backgroundColor: AppColors.primaryIconColor,
                                    radius: 15,
                                    child: InkWell(
                                        onTap: () {
                                          value.dialog(context);
                                        },
                                        child: const Icon(
                                          Icons.add,
                                          color: Colors.white,
                                        )),
                                  )
                                ],
                              ),
                              const SizedBox(height: 40),
                              InkWell(
                                onTap: () {
                                  value.showusername(context, map['username'],
                                      'Update Username');
                                },
                                child: ReUseAbleRow(
                                    iconData: Icons.person,
                                    title: 'username',
                                    value: map['username']),
                              ),
                              InkWell(
                                onTap: () {
                                  value.showphone(
                                    context,
                                    map['phone'],
                                    'Update phone',
                                  );
                                },
                                child: ReUseAbleRow(
                                    iconData: Icons.phone,
                                    title: 'phone',
                                    value: map['phone'] == ''
                                        ? 'xxxx-xxxx-xxxx'
                                        : map['phone']),
                              ),
                              ReUseAbleRow(
                                  iconData: Icons.email_outlined,
                                  title: 'Email',
                                  value: map['email']),
                              const SizedBox(height: 30),
                              RoundButton(
                                  title: 'LogOut',
                                  loading: loading,
                                  ontap: () {
                                    value.signout(context);
                                  })
                            ],
                          );
                        } else {
                          return Center(
                              child: Text(
                            'Something Went Wrong',
                            style: Theme.of(context).textTheme.subtitle1,
                          ));
                        }
                      },
                    )),
              );
            },
          ),
        ));
  }
}

class ReUseAbleRow extends StatelessWidget {
  final String title, value;
  final IconData iconData;
  const ReUseAbleRow(
      {Key? key,
      required this.iconData,
      required this.title,
      required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(title),
          leading: Icon(iconData),
          subtitle: Text(value),
        ),
        const Divider(
          color: AppColors.dividedColor,
          thickness: 0.5,
        )
      ],
    );
  }
}
