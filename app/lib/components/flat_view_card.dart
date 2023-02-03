import 'package:flutter/material.dart';
import 'package:ten_ant/api/request/add_flat_request.dart';

class FlatViewCard extends StatefulWidget {
  final Flat data;
  const FlatViewCard({super.key, required this.data});

  @override
  State<FlatViewCard> createState() => _FlatViewCardState();
}

class _FlatViewCardState extends State<FlatViewCard> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      ...widget.data.pictures
                          .sublist(0, 3)
                          .map((e) => Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Image.network(
                                  e,
                                  width:
                                      MediaQuery.of(context).size.width / 1.1,
                                ),
                              ))
                          .toList(),
                    ],
                  ),
                  // ignore: prefer_const_constructors
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.data.street,
                    // ignore: prefer_const_constructors
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    widget.data.description,
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
                    'Street Address',
                    // ignore: prefer_const_constructors
                    style: TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    widget.data.street,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                const Divider(),
                ListTile(
                  // ignore: prefer_const_constructors
                  title: Text(
                    'District',
                    // ignore: prefer_const_constructors
                    style: TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    widget.data.district,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                const Divider(),
                ListTile(
                  // ignore: prefer_const_constructors
                  title: Text(
                    'Contact',
                    // ignore: prefer_const_constructors
                    style: TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    widget.data.contact,
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
                    'Description',
                    style: const TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    widget.data.description,
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
                    'BHK',
                    // ignore: prefer_const_constructors
                    style: TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    widget.data.bhk.toString(),
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
                    'Rent',
                    // ignore: prefer_const_constructors
                    style: TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    widget.data.rent.toString(),
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
                    'Area',
                    // ignore: prefer_const_constructors
                    style: TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    widget.data.area.toString(),
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
                    'Toilets',
                    // ignore: prefer_const_constructors
                    style: TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    widget.data.toilets.toString(),
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
                      'Amenities',
                      // ignore: prefer_const_constructors
                      style: TextStyle(
                        color: Colors.deepOrange,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      children: <Widget>[
                        Text(widget.data.amenities[0]),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: widget.data.amenities.length,
                          itemBuilder: (context, index) {
                            return Text(widget.data.amenities[index]);
                          },
                        )
                      ],
                    )),
                ListTile(
                    // ignore: prefer_const_constructors
                    title: Text(
                      'Features',
                      // ignore: prefer_const_constructors
                      style: TextStyle(
                        color: Colors.deepOrange,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      children: <Widget>[
                        Text(widget.data.features[0]),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: widget.data.features.length,
                          itemBuilder: (context, index) {
                            return Text(widget.data.features[index]);
                          },
                        )
                      ],
                    )),
              ],
            ),
            // Text(
            //   widget.data.name,
            //   style: Styles.textStyle1,
            // ),
            // Image(
            //   width: 200,
            //   height: 200,
            //   image: getCachedNetworkImage(widget.data.profilePicLink),
            // ),
          ],
        ),
      ),
    );
  }
}
