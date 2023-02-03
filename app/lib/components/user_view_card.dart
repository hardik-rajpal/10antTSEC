import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ten_ant/api/response/add_user_response.dart';
import 'package:ten_ant/components/images.dart';

class UserViewCard extends StatefulWidget {
  final UserDetails details;
  const UserViewCard({super.key, required this.details});

  @override
  State<UserViewCard> createState() => _UserViewCardState();
}

class _UserViewCardState extends State<UserViewCard> {
  late UserDetails details;
  @override
  void initState() {
    details = widget.details;
    log('email:' + details.email);
    log('gender: ' + details.gender);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 250,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.red, Colors.deepOrange.shade300],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    stops: const [0.5, 0.9],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundColor: Colors.white70,
                          minRadius: 60.0,
                          child: CircleAvatar(
                            radius: 50.0,
                            backgroundImage:
                                getCommonImageProvider(details.profilePicLink),
                          ),
                        ),
                      ],
                    ),
                    // ignore: prefer_const_constructors
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      details.name,
                      // ignore: prefer_const_constructors
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      details.username,
                      // ignore: prefer_const_constructors
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: <Widget>[
                  ListTile(
                    // ignore: prefer_const_constructors
                    title: Text(
                      'Email',
                      // ignore: prefer_const_constructors
                      style: TextStyle(
                        color: Colors.deepOrange,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      details.email,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    // ignore: prefer_const_constructors
                    title: Text(
                      'Age',
                      // ignore: prefer_const_constructors
                      style: TextStyle(
                        color: Colors.deepOrange,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      details.age.toString(),
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    // ignore: prefer_const_constructors
                    title: Text(
                      'Gender',
                      // ignore: prefer_const_constructors
                      style: TextStyle(
                        color: Colors.deepOrange,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      details.gender,
                      // ignore: prefer_const_constructors
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    // ignore: prefer_const_constructors
                    title: Text(
                      'Languages',
                      style: const TextStyle(
                        color: Colors.deepOrange,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      details.languages.join(', '),
                      // ignore: prefer_const_constructors
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    // ignore: prefer_const_constructors
                    title: Text(
                      'Budget',
                      // ignore: prefer_const_constructors
                      style: TextStyle(
                        color: Colors.deepOrange,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      details.budget.toString(),
                      // ignore: prefer_const_constructors
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
