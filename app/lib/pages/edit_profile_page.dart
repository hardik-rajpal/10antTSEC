import 'package:flutter/material.dart';
import 'package:ten_ant/cubits/user_auth.dart';

class EditProfilePage extends StatefulWidget {
  final UserAuthCubit userCubit;
  const EditProfilePage({super.key, required this.userCubit});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();

  final interests = [
    'afffffffffffffffffffaa',
    'bffffffffffffffffffffffffbb',
    'rrr',
    'ffff',
    'eded',
    'ffedf'
  ];
  final selected = [0, 0, 0, 0, 0, 0];
  var number = 0;

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

  final TextEditingController _locController = TextEditingController();

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
                        controller: _locController,
                        validator: (headline) {
                          if (headline == null || headline.isEmpty) {
                            return "Cant be empty";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          icon: Icon(Icons.person),
                          hintText: 'Enter the location (url) of your flat',
                          labelText: 'Username',
                        ),
                      ),
                      TextFormField(
                        // initialValue: widget.userCubit.state,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.person_2_outlined),
                          hintText: 'Enter the district',
                          labelText: 'Full Name',
                        ),
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          icon: Icon(Icons.contact_emergency),
                          hintText: 'Enter your contact',
                          labelText: 'Contact',
                        ),
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          icon: Icon(Icons.description),
                          hintText: 'Enter a description',
                          labelText: 'Description',
                        ),
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          icon: Icon(Icons.streetview),
                          hintText: 'Enter street address',
                          labelText: 'Street Address',
                        ),
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          icon: Icon(Icons.bedroom_baby),
                          hintText: 'Enter specifications (bhk)',
                          labelText: 'Bhk',
                        ),
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          icon: Icon(Icons.money),
                          hintText: 'Enter preferred rent',
                          labelText: 'Rent',
                        ),
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          icon: Icon(Icons.area_chart),
                          hintText: 'Enter area',
                          labelText: 'Area',
                        ),
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          icon: Icon(Icons.money),
                          hintText: 'Enter preferred rent',
                          labelText: 'Rent',
                        ),
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          icon: Icon(Icons.three_g_mobiledata),
                          hintText: 'Enter number of toilets',
                          labelText: 'Toilets',
                        ),
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          icon: Icon(Icons.airplanemode_inactive_sharp),
                          hintText: 'Enter amenities other',
                          labelText: 'Amentities',
                        ),
                      ),
                      Center(
                          child:
                              Column(children: <Widget>[_buildChips(context)])),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Processing Data')),
                                );
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
                      // new Container(
                      //     padding: const EdgeInsets.only(left: 150.0, top: 40.0),
                      //     child: Flat(
                      //       child: const Text('Submit'),
                      //         onPressed: null,
                      //     )),
                    ],
                  ),
                ))));
  }
}
