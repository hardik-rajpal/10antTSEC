import 'package:flutter/material.dart';
import 'package:ten_ant/api/request/add_flat_request.dart';
import 'package:ten_ant/api/response/tag.dart';
import 'package:ten_ant/services/remote_data_service.dart';

class AddFlats extends StatefulWidget {
  const AddFlats({super.key});

  @override
  State<AddFlats> createState() => _AddFlatsState();
}

class _AddFlatsState extends State<AddFlats> {
  final _formKey = GlobalKey<FormState>();
  Flat currReq = Flat();
  List<Tag> locationPriorityTags = [];
  List<String> locationPriorities = [];
  List interests = ['1', '2', '3', '4', '5', '6'];
  final selected = [0, 0, 0, 0, 0, 0];
  var number = 0;
  @override
  void initState() {
    RemoteDataService().getLocationTags().then((value) {
      setState(() {
        locationPriorityTags = value;
      });
    });
    super.initState();
  }

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
                currReq.features.add(interests[i]);
              }
            } else {
              selected[i] = 0;
              number -= 1;
              currReq.features.remove(interests[i]);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Add Flat")),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                          margin:
                              const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 10.0),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              icon: Icon(Icons.location_on_outlined),
                              hintText: 'Enter the location (url) of your flat',
                              labelText: 'Location',
                            ),
                            autocorrect: true,
                            onChanged: (value) {
                              setState(() {
                                currReq.location = value;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Location cannot be empty';
                              }
                              return null;
                            },
                          )),
                      Container(
                          margin:
                              const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 10.0),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              icon: Icon(Icons.location_city),
                              hintText: 'Enter the district',
                              labelText: 'District',
                            ),
                            autocorrect: true,
                            onChanged: (value) {
                              setState(() {
                                currReq.district = value;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'District cannot be empty';
                              }
                              return null;
                            },
                          )),
                      Container(
                          margin:
                              const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 10.0),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              icon: Icon(Icons.contact_emergency),
                              hintText: 'Enter your contact',
                              labelText: 'Contact',
                            ),
                            autocorrect: true,
                            onChanged: (value) {
                              setState(() {
                                currReq.contact = value;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Contact cannot be empty';
                              }
                              return null;
                            },
                          )),
                      Container(
                          margin:
                              const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 10.0),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              icon: Icon(Icons.description),
                              hintText: 'Enter a description',
                              labelText: 'Description',
                            ),
                            autocorrect: true,
                            onChanged: (value) {
                              setState(() {
                                currReq.description = value;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Description cannot be empty';
                              }
                              return null;
                            },
                          )),
                      Container(
                          margin:
                              const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 10.0),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              icon: Icon(Icons.streetview),
                              hintText: 'Enter street address',
                              labelText: 'Street Address',
                            ),
                            autocorrect: true,
                            onChanged: (value) {
                              setState(() {
                                currReq.street = value;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Street cannot be empty';
                              }
                              return null;
                            },
                          )),
                      Container(
                          margin:
                              const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 10.0),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              icon: Icon(Icons.bedroom_baby),
                              hintText: 'Enter specifications (bhk)',
                              labelText: 'Bhk',
                            ),
                            autocorrect: true,
                            onChanged: (value) {
                              setState(() {
                                currReq.bhk = int.parse(value);
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'bhk cannot be empty';
                              }
                              return null;
                            },
                          )),
                      Container(
                          margin:
                              const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 10.0),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              icon: Icon(Icons.money),
                              hintText: 'Enter preferred rent',
                              labelText: 'Rent',
                            ),
                            autocorrect: true,
                            onChanged: (value) {
                              setState(() {
                                currReq.rent = int.parse(value);
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Rent cannot be empty';
                              }
                              return null;
                            },
                          )),
                      Container(
                          margin:
                              const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 10.0),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              icon: Icon(Icons.area_chart),
                              hintText: 'Enter area',
                              labelText: 'Area',
                            ),
                            autocorrect: true,
                            onChanged: (value) {
                              setState(() {
                                currReq.area = int.parse(value);
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Area cannot be empty';
                              }
                              return null;
                            },
                          )),
                      Container(
                          margin:
                              const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 10.0),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              icon: Icon(Icons.money),
                              hintText: 'Enter preferred rent',
                              labelText: 'Rent',
                            ),
                            autocorrect: true,
                            onChanged: (value) {
                              setState(() {
                                currReq.rent = int.parse(value);
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Rent cannot be empty';
                              }
                              return null;
                            },
                          )),
                      Container(
                          margin:
                              const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 10.0),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              icon: Icon(Icons.three_g_mobiledata),
                              hintText: 'Enter number of toilets',
                              labelText: 'Toilets',
                            ),
                            autocorrect: true,
                            onChanged: (value) {
                              setState(() {
                                currReq.toilets = int.parse(value);
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Toilets cannot be empty';
                              }
                              return null;
                            },
                          )),
                      Container(
                          margin:
                              const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 10.0),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              icon: Icon(Icons.airplanemode_inactive_sharp),
                              hintText: 'Enter amenities other',
                              labelText: 'Amentities',
                            ),
                            autocorrect: true,
                            onChanged: (value) {
                              setState(() {
                                currReq.amenities.add(value);
                              });
                            },
                            validator: (value) {
                              // if (value == null || value.isEmpty) {
                              //   return 'amenities cannot be empty';
                              // }
                              return null;
                            },
                          )),
                      Container(
                          margin:
                              const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 10.0),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              icon: Icon(Icons.airplanemode_inactive_sharp),
                              hintText: 'Enter amenities other',
                              labelText: '',
                            ),
                            autocorrect: true,
                            onChanged: (value) {
                              setState(() {
                                currReq.amenities.add(value);
                              });
                            },
                            validator: (value) {
                              // if (value == null || value.isEmpty) {
                              //   return 'amenities cannot be empty';
                              // }
                              return null;
                            },
                          )),
                      Container(
                          margin:
                              const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 10.0),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              icon: Icon(Icons.airplanemode_inactive_sharp),
                              hintText: 'Enter amenities other',
                              labelText: '',
                            ),
                            autocorrect: true,
                            onChanged: (value) {
                              setState(() {
                                currReq.amenities.add(value);
                              });
                            },
                            validator: (value) {
                              // if (value == null || value.isEmpty) {
                              //   return 'amenities cannot be empty';
                              // }
                              return null;
                            },
                          )),
                      Center(
                          child:
                              Column(children: <Widget>[_buildChips(context)])),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                var resp =
                                    await RemoteDataService().addFlat(currReq);
                                // ignore: unrelated_type_equality_checks
                                if (resp == "success") {
                                  Navigator.of(context).pop();
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text('Error'),
                                    duration: Duration(seconds: 10),
                                  ));
                                }
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
