import 'package:flutter/material.dart';
import 'package:ten_ant/components/drawer.dart';
import 'package:ten_ant/components/flat_view_card.dart';
import 'package:ten_ant/components/images.dart';
import 'package:ten_ant/cubits/user_auth.dart';
import 'package:ten_ant/landlord/add_flats.dart';
import 'package:ten_ant/landlord/stats_flats.dart';
import 'package:ten_ant/landlord/view_flat_one.dart';
import 'package:ten_ant/models/common.dart';
import 'package:ten_ant/services/remote_data_service.dart';
import 'package:ten_ant/utils/constants.dart';

class ViewFlats extends StatefulWidget {
  final UserAuthCubit userCubit;
  const ViewFlats({super.key, required this.userCubit});

  @override
  State<ViewFlats> createState() => _ViewFlatsState();
}

class _ViewFlatsState extends State<ViewFlats> {
  List<Flat> flats = [];
  bool flatsLoaded = false;
  @override
  void initState() {
    RemoteDataService()
        .getMyFlats(widget.userCubit.state.user!.uuid)
        .then((values) {
      setState(() {
        flats = values;
        flatsLoaded = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('My Offerings')),
        drawer: MainDrawerWidget(userCubit: widget.userCubit),
        body: (flatsLoaded)
            ? ListView.builder(itemBuilder: (context, index) {
                if (index < flats.length) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return ViewSingleFlatPage(
                            flat: flats[index], userCubit: widget.userCubit);
                      }));
                    },
                    child: Card(
                        color: Colors.amber[100],
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Image(
                              image:
                                  getCachedNetworkImage(flats[index].photos[0]),
                              width: 100,
                              height: 100,
                            ),
                            Text(
                              flats[index].name,
                              style: Styles.textStyle1,
                            )
                          ],
                        )),
                  );
                } else {
                  return null;
                }
              })
            : const CircularProgressIndicator(),
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
}
