import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class UserProductTile extends StatelessWidget {
  final String title;
  final String imageUrl;
  const UserProductTile(
      {super.key, required this.imageUrl, required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      title: Text(title),
      trailing: Container(
        width: 100,
        child: Row(children: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.edit),
            color: Theme.of(context).primaryColor,
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.delete),
            color: Theme.of(context).errorColor,
          ),
        ]),
      ),
    );
  }
}
