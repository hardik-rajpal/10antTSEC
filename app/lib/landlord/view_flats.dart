import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:ten_ant/landlord/add_flats.dart';
import 'package:ten_ant/landlord/view_flat_one.dart';
import 'package:ten_ant/landlord/stats_flats.dart';

class ViewFlats extends StatefulWidget {
  const ViewFlats({super.key});

  @override
  State<ViewFlats> createState() => _ViewFlatsState();
}

class Data {
  Map fetched_data = {
    "data": [
      {"id": 1, "name": "Arivallu", "image": "images/sky.jpeg"},
      {"id": 2, "name": "Chennai acclom", "image": "images/sky.jpeg"},
      {"id": 3, "name": "myaps", "image": "images/sky.jpeg"}
    ]
  };
  List _data = [];

  Data() {
    _data = fetched_data["data"];
  }

  int getId(int index) {
    return _data[index]["id"];
  }

  String getName(int index) {
    return _data[index]["name"];
  }

  String getImage(int index) {
    return _data[index]["image"];
  }

  int getLength() {
    return _data.length;
  }
}

class _ViewFlatsState extends State<ViewFlats> {
  Data _data = new Data();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey,
        body: ListView.builder(
          padding: const EdgeInsets.all(5.5),
          itemCount: _data.getLength(),
          itemBuilder: _itemBuilder,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (BuildContext context) {
              return const AddFlats();
            }));
          },
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    return InkWell(
      child: Card(
        margin: const EdgeInsets.all(5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Image.asset(_data.getImage(index)),
              title: Text(_data.getName(index)),
              subtitle: Text(_data.getId(index).toString()),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return const StatsFlats();
                }));
              },
            ),
          ],
        ),
      ),
      // onTap: () => MaterialPageRoute(
      //     builder: (context) =>
      //         SecondRoute(id: _data.getId(index), name: _data.getName(index))),
    );
  }
}
