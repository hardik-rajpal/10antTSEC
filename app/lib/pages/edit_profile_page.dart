import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ten_ant/api/response/add_user_response.dart';
import 'package:ten_ant/cubits/user_auth.dart';
import 'package:ten_ant/services/remote_data_service.dart';
import 'package:ten_ant/utils/constants.dart';

class EditProfilePage extends StatefulWidget {
  final UserAuthCubit userCubit;
  const EditProfilePage({super.key, required this.userCubit});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();

  final interests = [
    'writing',
    'reading',
    'shows',
  ];
  final selected = [0, 0, 0, 0, 0, 0];
  var number = 0;
  UserDetails details = UserDetails();
  Widget _buildChips(BuildContext context) {
    List<Widget> w = [];
    int length = interests.length;
    for (int i = 0; i < length; i++) {
      w.add(ActionChip(
        labelPadding: const EdgeInsets.all(2.0),
        label: Text(
          interests[i],
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor:
            selected[i] == 1 ? Colors.primaries[4] : Colors.primaries[3],
        elevation: 6.0,
        shadowColor: Colors.grey[60],
        padding: const EdgeInsets.all(8.0),
        onPressed: () {
          setState(() {
            if (selected[i] == 0) {
              if (number != 3) {
                number += 1;
                selected[i] = 1;
              }
            } else {
              selected[i] = 0;
              number -= 1;
            }
          });
        },
      ));
    }
    return Wrap(
      spacing: 8.0, // gap between adjacent chips
      runSpacing: 4.0,
      children: w,
    );
  }

  String gender = '';
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
                                      value: 'Male', child: Text(e)))
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
                          child:
                              Column(children: <Widget>[_buildChips(context)])),
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
                                await RemoteDataService().registerUser(details);
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
