import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

List<Myarr> persons = [];

class Myarr {
  dynamic name, number;
  Myarr(this.name, this.number);
  static List<Myarr> getSuggestions(dynamic query) =>
      List.of(persons).where((user) {
        final userLower = user.name.toLowerCase();
        final queryLower = query.toLowerCase();
        final userNumber = user.number;
        final queryNumber = query;
        return userLower.contains(queryLower) ||
            userNumber.contains(queryNumber);
      }).toList();
}

var myarr = [];

class FlutterContactsExample extends StatefulWidget {
  const FlutterContactsExample({Key? key}) : super(key: key);

  @override
  _FlutterContactsExampleState createState() => _FlutterContactsExampleState();
}

class _FlutterContactsExampleState extends State<FlutterContactsExample> {
  List<Contact>? _contacts;

  @override
  void initState() {
    super.initState();
    _fetchContacts();
  }

  Future _fetchContacts() async {
    if (!await FlutterContacts.requestPermission(readonly: true)) {
    } else {
      final contacts = await FlutterContacts.getContacts(withProperties: true);
      setState(() => _contacts = contacts);
      for (var i = 0; i < _contacts!.length; i++) {
        // myarr.add(_contacts?[i].displayName);

        var num = _contacts?[i].phones;
        for (var j = 0; j < num!.length; j++) {
          persons.add(Myarr(_contacts?[i].displayName, num[j].number));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
          home: GestureDetector(
        onTap: () {
          // for (var i = 0; i < _contacts!.length; i++) {
          //   // myarr.add(_contacts?[i].displayName);
          //   persons.add(Myarr(_contacts?[i].displayName));
          //   // print(myarr);
          // }
        },
        child: Scaffold(
            appBar: AppBar(title: const Text('flutter_contacts_example')),
            body: ListView(
              children: [
                TypeAheadField<Myarr>(
                  textFieldConfiguration: const TextFieldConfiguration(
                      autofocus: true,
                      // style: DefaultTextStyle.of(context)
                      //     .style
                      //     .copyWith(fontStyle: FontStyle.italic),
                      decoration:
                          InputDecoration(border: OutlineInputBorder())),
                  suggestionsCallback: (pattern) async {
                    return await Myarr.getSuggestions(pattern);
                  },
                  itemBuilder: (context, suggestion) {
                    return ListTile(
                      leading: const Icon(Icons.shopping_cart),
                      title: Text(suggestion.name),
                      subtitle: Text(suggestion.number),
                    );
                  },
                  onSuggestionSelected: (suggestion) {},
                ),
              ],
            )),
      ));
}
