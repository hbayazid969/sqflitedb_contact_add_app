import 'package:contact_app_sqflitedb/add_contacts.dart';
import 'package:contact_app_sqflitedb/contact.dart';
import 'package:contact_app_sqflitedb/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Demo extends StatefulWidget {
  const Demo({Key? key}) : super(key: key);

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Local DB')),
      body: FutureBuilder<List<Contact>>(
          future: DBHelper.readContact(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Contact>> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(
                      height: 15,
                    ),
                    Text('Loading ......')
                  ],
                ),
              );
            }
            return snapshot.data!.isEmpty
                ? Center(
                    child: Text('Empty'),
                  )
                : ListView(
                    children: snapshot.data!.map((contacts) {
                      return Center(
                        child: Card(
                            elevation: 10,
                            child: ListTile(
                              title: Text('${contacts.name}'),
                              subtitle: Text('${contacts.contact}'),
                            )),
                      );
                    }).toList(),
                  );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final dynamic refresh = await Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => AddContact()));
          setState(() {});

          // if (refresh) {
          //   setState(() {});
          // }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
