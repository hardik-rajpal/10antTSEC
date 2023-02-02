import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ten_ant/components/images.dart';
import 'package:ten_ant/utils/constants.dart';

class DeleteButton extends StatelessWidget {
  final Function onConfirmDelete;
  final dynamic params;
  const DeleteButton(
      {required this.onConfirmDelete, required this.params, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        onPressed: () async {
          await onConfirmDelete();
        },
        style:
            ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),
        icon: const FaIcon(FontAwesomeIcons.trash),
        label: const Text('Delete'));
  }
}

class GreenCheckButton extends StatelessWidget {
  final String label;
  final Function onPress;
  const GreenCheckButton({required this.onPress, required this.label, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.green)),
        onPressed: () async {
          await onPress();
        },
        icon: const FaIcon(FontAwesomeIcons.check),
        label: Text(label));
  }
}

class RedCrossedButton extends StatelessWidget {
  final String label;
  final Function onPress;
  const RedCrossedButton({required this.onPress, required this.label, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        style:
            ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),
        onPressed: () async {
          await onPress();
        },
        icon: const FaIcon(FontAwesomeIcons.xmark),
        label: Text(label));
  }
}

class ReactionCountButton extends StatelessWidget {
  final FaIcon icon;
  final List<String> userList;
  const ReactionCountButton(
      {super.key, required this.icon, required this.userList});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.amber[50])),
      child: Row(
        children: [
          icon,
          Text(
            '${userList.length}',
            style: const TextStyle(color: Colors.black),
          ),
        ],
      ),
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Group Members'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: userList
                      .map((userdata) => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                    radius: 30,
                                    backgroundImage: getCachedNetworkImage(
                                        Values.imagePlaceholder)),
                              ),
                              Flexible(
                                child: Text(
                                  userdata,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ))
                      .toList(),
                ),
              );
            });
      },
    );
  }
}
