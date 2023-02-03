import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ten_ant/api/response/add_user_response.dart';
import 'package:ten_ant/api/response/roomietag.dart';
import 'package:ten_ant/api/response/roomietag_response.dart';
import 'package:ten_ant/api/response/tag.dart';
import 'package:ten_ant/cubits/user_auth.dart';
import 'package:ten_ant/services/local_data_service.dart';
import 'package:ten_ant/services/remote_data_service.dart';
import 'package:ten_ant/utils/constants.dart';

//list of dicts
/*
{option:id, category: optionIndex}
*/
class EditProfilePage extends StatefulWidget {
  final UserAuthCubit userCubit;
  const EditProfilePage({super.key, required this.userCubit});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  List<Tag> locationPriorityTags = [];
  List<String> locationPriorities = [];
  List<RoomieTagResponse> selected = [];
  List<String> roommatePriorities = [];
  List<RoomieTag> roomieTags = [];
  UserDetails details = UserDetails();
  String gender = 'Male';
  @override
  void initState() {
    details.username = widget.userCubit.state.user!.username;
    details.name = widget.userCubit.state.user!.name;
    details.email = widget.userCubit.state.user!.email;
    details.age = 18;
    details.budget = 1000;
    details.gender = gender;
    RemoteDataService().getLocationTags().then((value) {
      setState(() {
        locationPriorityTags = value;
      });
    });
    RemoteDataService().getRoommateTags().then((value) {
      setState(() {
        roomieTags = value;
      });
    });
    super.initState();
  }

  Widget _buildLocationChips(BuildContext context) {
    return Wrap(
      spacing: 8.0, // gap between adjacent chips
      runSpacing: 4.0,
      children: locationPriorityTags
          .map((e) => getChip(e.name, e.id, locationPriorities, () {
                setState(() {
                  if (!locationPriorities.contains(e.id)) {
                    locationPriorities.add(e.id);
                  } else {
                    locationPriorities.remove(e.id);
                  }
                  if (locationPriorities.length >
                      locationPriorityTags.length / 2) {
                    locationPriorities.removeAt(0);
                  }
                  details.locationPriorities = locationPriorityTags
                      .where(
                          (element) => locationPriorities.contains(element.id))
                      .toList();
                });
              }))
          .toList(),
    );
  }

  ActionChip getChip(
      String name, String id, List<String> selectedList, Function onPress) {
    return ActionChip(
      labelPadding: const EdgeInsets.all(2.0),
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            name,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(4.0),
              child: (selectedList.contains(id)
                  ? const Icon(
                      Icons.check,
                      size: 15,
                    )
                  : const Icon(
                      Icons.cancel,
                      size: 15,
                    )))
        ],
      ),
      backgroundColor:
          selectedList.contains(id) ? Colors.primaries[7] : Colors.primaries[5],
      elevation: 6.0,
      shadowColor: Colors.grey[60],
      padding: const EdgeInsets.all(8.0),
      onPressed: () {
        onPress();
      },
    );
  }

// /getRoommateSuggestions
  Widget _buildRoommateChips(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: roomieTags
          .map((tagtype) => Column(
                children: [
                  Text(
                    tagtype.name,
                    style: Styles.textStyle1,
                  ),
                  Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: tagtype.options
                        .map((e) =>
                            getChip(e, tagtype.id + e, roommatePriorities, () {
                              setState(() {
                                if (!roommatePriorities
                                    .contains(tagtype.id + e)) {
                                  roommatePriorities.add(tagtype.id + e);
                                  RoomieTagResponse r = RoomieTagResponse();
                                  r.category = tagtype.options
                                      .indexWhere((element) => e == element);
                                  r.option = tagtype.id;
                                  selected.add(r);
                                } else {
                                  roommatePriorities.remove(tagtype.id + e);
                                  selected.remove(selected.firstWhere(
                                      (element) =>
                                          (element.option +
                                              tagtype
                                                  .options[element.category]) ==
                                          (tagtype.id + e)));
                                }
                                if (roommatePriorities
                                        .where((element) =>
                                            element.startsWith(tagtype.id))
                                        .length >
                                    1) {
                                  String toremove =
                                      roommatePriorities.firstWhere((element) =>
                                          element.startsWith(tagtype.id));
                                  roommatePriorities.remove(toremove);
                                  selected.remove(selected.firstWhere(
                                      (element) => element.option
                                          .startsWith(tagtype.id)));
                                  RoomieTagResponse r = RoomieTagResponse();
                                  r.category = tagtype.options.indexOf(e);
                                  r.option = tagtype.id;
                                  selected.add(r);
                                }
                                details.roommatePriorities = selected;
                              });
                            }))
                        .toList(),
                  ),
                ],
              ))
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Edit Profile")),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        validator: (headline) {
                          if (headline == null || headline.isEmpty) {
                            return "Cant be empty";
                          }
                          return null;
                        },
                        initialValue: widget.userCubit.state.user!.username,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.person),
                          labelText: 'Username',
                        ),
                        onChanged: (value) {
                          details.username = value;
                        },
                      ),
                      TextFormField(
                        initialValue: widget.userCubit.state.user!.name,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.person_2_outlined),
                          labelText: 'Full Name',
                        ),
                        onChanged: (value) {
                          details.name = value;
                        },
                      ),
                      TextFormField(
                        initialValue: widget.userCubit.state.user!.email,
                        decoration: const InputDecoration(
                          icon: FaIcon(FontAwesomeIcons.at),
                          labelText: 'Email',
                        ),
                        onChanged: (value) {
                          details.email = value;
                        },
                      ),
                      TextFormField(
                        initialValue: '18',
                        decoration: const InputDecoration(
                          icon: FaIcon(FontAwesomeIcons.hashtag),
                          labelText: 'Age',
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          details.age = int.parse(value);
                        },
                      ),
                      Row(
                        children: [
                          const Text(
                            'Gender: ',
                            style: Styles.textStyle1,
                          ),
                          DropdownButton<String>(
                              value: gender,
                              onChanged: (String? choice) {
                                if (choice != null) {
                                  setState(() {
                                    gender = choice;
                                    details.gender = choice;
                                  });
                                }
                              },
                              items: ['Male', 'Female', 'Other']
                                  .map((e) => DropdownMenuItem<String>(
                                      value: e, child: Text(e)))
                                  .toList()),
                        ],
                      ),
                      TextFormField(
                        initialValue: '1000',
                        decoration: const InputDecoration(
                          icon: FaIcon(FontAwesomeIcons.rupeeSign),
                          labelText: 'Budget',
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          details.budget = int.parse(value);
                        },
                      ),
                      Center(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                            const Text('Location Priorities',
                                style: Styles.textStyleHeading),
                            _buildLocationChips(context),
                            _buildRoommateChips(context)
                          ])),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Processing Data')),
                                );
                                UserDetails newDetails =
                                    (await RemoteDataService()
                                        .registerUser(details));
                                widget.userCubit.userid = newDetails.id!;
                                widget.userCubit.state.user!.uuid =
                                    newDetails.id!;
                                await LocalDataService().saveAuthenticatedUser(
                                    widget.userCubit.state.user!);
                                widget.userCubit.setActiveUser(
                                    widget.userCubit.state.user!);
                                log('userid: ' + newDetails.id!);
                                Navigator.of(context)
                                    .pushReplacementNamed(MainDrawer.flatfeed);
                              }
                            },
                            child: const Text('Submit'),
                          ),
                          // SizedBox(width: 10.0, height: 10.0,),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Cancel'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ))));
  }
}
