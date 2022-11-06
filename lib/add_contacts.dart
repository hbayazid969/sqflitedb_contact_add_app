import 'package:contact_app_sqflitedb/contact.dart';
import 'package:contact_app_sqflitedb/db_helper.dart';
import 'package:contact_app_sqflitedb/demo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class AddContact extends StatefulWidget {
  AddContact({Key? key, this.contact}) : super(key: key);

  final Contact? contact;
  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _contactController = TextEditingController();

  @override
  void initState() {
    if (widget.contact != null) {
      _nameController.text = widget.contact!.name!;
      _nameController.text = widget.contact!.contact!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('THis is GUlistan')),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            _buildTextField(_nameController, 'Name'),
            SizedBox(
              height: 10,
            ),
            _buildTextField(_contactController, 'Contact'),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () async {
                  await DBHelper.createContact(Contact(
                      name: _nameController.text,
                      contact: _contactController.text));
                },
                child: Text('Add Contact'))
          ],
        ),
      ),
    );
  }

  TextField _buildTextField(TextEditingController _cotroller, String hint) {
    return TextField(
      controller: _cotroller,
      decoration: InputDecoration(
          labelText: hint,
          hintText: hint,
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(15.0))),
    );
  }
}
