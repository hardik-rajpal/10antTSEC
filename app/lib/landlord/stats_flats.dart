import 'package:flutter/material.dart';

class StatsFlats extends StatefulWidget {
  const StatsFlats({super.key});

  @override
  State<StatsFlats> createState() => _StatsFlatsState();
}

class _StatsFlatsState extends State<StatsFlats> {
  List fooList = ['one', 'two', 'three', 'four', 'five'];
  List filteredList = [];
  @override
  void initState() {
    super.initState();
    filteredList = fooList;
  }

  void filter(String inputString) {
    filteredList =
        fooList.where((i) => i.toLowerCase().contains(inputString)).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(title: const Text("Add Flat")),
            body: Padding(
                padding: const EdgeInsets.all(30.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                          height: 20,
                          child: Column(children: [
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: const [
                                  Icon(Icons.check),
                                  Icon(Icons.close),
                                  Icon(Icons.question_mark)
                                ]),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: const [
                                  Text("12"),
                                  Text("2222"),
                                  Text("e2"),
                                ])
                          ])),
                      SizedBox(
                        height: 10,
                        child: Column(children: [
                          TextField(
                            decoration: const InputDecoration(
                              hintText: 'Search ',
                              hintStyle: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            onChanged: (text) {
                              text = text.toLowerCase();
                              filter(text);
                            },
                          ),
                          SingleChildScrollView(
                            child: ListView.builder(
                              padding: const EdgeInsets.all(5.5),
                              itemCount: 5,
                              itemBuilder: _itemBuilder,
                              //(BuildContext context, int index) =>
                              //     ListTile(
                              //   title: Text(filteredList[index]),
                              // onTap: () {
                              //   Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) => Display(
                              //         text: filteredList[index],
                              //       ),
                              //     ),
                              //   );
                              // },
                              // ),
                            ),
                          ),
                        ]),
                      )
                    ],
                  ),
                ))));
  }
}

Widget _itemBuilder(BuildContext context, int index) {
  return InkWell(
    child: Card(
      margin: const EdgeInsets.all(5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: const Text("index"),
            onTap: () {},
          ),
        ],
      ),
    ),
    // onTap: () => MaterialPageRoute(
    //     builder: (context) =>
    //         SecondRoute(id: _data.getId(index), name: _data.getName(index))),
  );
}

class Display extends StatelessWidget {
  final String text;

  const Display({super.key, required this.text});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(text),
      ),
    );
  }
}
