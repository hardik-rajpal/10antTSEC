import 'package:ten_ant/cubits/user_auth.dart';
import 'package:ten_ant/utils/constants.dart';
import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final IconData iconData;
  final String text;
  final Function onTap;
  const MenuItem(
      {required this.iconData,
      required this.text,
      required this.onTap,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        child: InkWell(
      onTap: () {
        Navigator.of(context).pop();
        onTap();
      },
      child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(children: [
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Icon(iconData, color: Colors.black),
            ),
            Text(
              text,
              style: const TextStyle(fontSize: 20),
            )
          ])),
    ));
  }
}

class MainDrawerWidget extends StatefulWidget {
  final UserAuthCubit userCubit;
  const MainDrawerWidget({Key? key, required this.userCubit}) : super(key: key);

  @override
  State<MainDrawerWidget> createState() => MainDrawerWidgetState();
}

class MainDrawerWidgetState extends State<MainDrawerWidget> {
  static const String landLordMode = 'landlordMode';
  static const String tenantMode = 'tenantMode';
  String appMode = tenantMode;
  @override
  void initState() {
    widget.userCubit.stream.listen((event) {
      if (mounted) {
        setState(() {
          appMode = event.isTenantMode ? tenantMode : landLordMode;
        });
      }
    });
    appMode = widget.userCubit.state.isTenantMode ? tenantMode : landLordMode;
    super.initState();
  }

  @override
  void dispose() {
    widget.userCubit.stream.drain();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            color: Colors.greenAccent[200],
            width: double.infinity,
            height: 300,
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Switch(
                          value: (appMode == tenantMode),
                          onChanged: (value) {
                            if (mounted) {
                              setState(() {
                                if (value) {
                                  appMode = tenantMode;
                                  widget.userCubit.invertTenantMode();
                                } else {
                                  appMode = landLordMode;
                                  widget.userCubit.invertTenantMode();
                                }
                              });
                            }
                          }),
                      Text(
                        (appMode == tenantMode)
                            ? 'Tenant Mode'
                            : 'Landlord Mode',
                        style: Styles.textStyle1,
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      height: 70,
                      decoration: const BoxDecoration(
                          shape: BoxShape.rectangle,
                          image: DecorationImage(
                              image: AssetImage('images/10ant2.png'))),
                    ),
                    const Text('10ANT',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        )),
                    const Text(
                      'Find your new home',
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
              padding: const EdgeInsets.only(top: 15),
              child: Column(
                children: (appMode == tenantMode)
                    ? [
                        MenuItem(
                          iconData: Icons.house_outlined,
                          text: 'Flat Feed',
                          onTap: () {
                            Navigator.of(context)
                                .pushReplacementNamed(MainDrawer.flatfeed);
                          },
                        ),
                        MenuItem(
                          iconData: Icons.person_add_alt_sharp,
                          text: 'Roomie Feed',
                          onTap: () {
                            Navigator.of(context)
                                .pushReplacementNamed(MainDrawer.roomiefeed);
                          },
                        ),
                        MenuItem(
                            iconData: Icons.person_2,
                            text: 'Profile',
                            onTap: () {
                              Navigator.of(context)
                                  .pushReplacementNamed(MainDrawer.profile);
                            }),
                      ]
                    : [
                        MenuItem(
                            iconData: Icons.maps_home_work_sharp,
                            text: 'My Offerings',
                            onTap: () {
                              Navigator.of(context)
                                  .pushReplacementNamed(MainDrawer.myoffering);
                            }),
                        MenuItem(
                            iconData: Icons.person_2,
                            text: 'Profile',
                            onTap: () {
                              Navigator.of(context)
                                  .pushReplacementNamed(MainDrawer.profile);
                            }),
                      ],
              ))
        ],
      ),
    );
  }
}
