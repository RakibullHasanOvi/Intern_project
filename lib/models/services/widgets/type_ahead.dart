import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

List<Myarr> persons = [];

class Myarr {
  dynamic name, number;
  Myarr(this.name, this.number);
  static List<Myarr> getSuggestions(String query) =>
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

class TAfeild extends StatefulWidget {
  const TAfeild({
    Key? key,
    required TextEditingController sugestionfieldController,
  })  : _sugestionfieldController = sugestionfieldController,
        super(key: key);

  final TextEditingController _sugestionfieldController;

  @override
  State<TAfeild> createState() => _TAfeildState();
}

class _TAfeildState extends State<TAfeild> {
  List<Contact>? _contacts;
  bool _permissionDenied = false;
  @override
  void initState() {
    super.initState();
    _fetchContacts();
  }

  Future _fetchContacts() async {
    if (!await FlutterContacts.requestPermission(readonly: true)) {
      setState(() => _permissionDenied = true);
    } else {
      final contacts = await FlutterContacts.getContacts(withProperties: true);
      setState(() => _contacts = contacts);
      for (var i = 0; i < _contacts!.length; i++) {
        // myarr.add(_contacts?[i].displayName);

        var num = _contacts?[i].phones;
        for (var j = 0; j < num!.length; j++) {
          persons.add(Myarr(_contacts?[i].displayName,
              num[j].number.replaceAll(RegExp('[^0-9]'), "")));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return TypeAheadField<Myarr>(
      minCharsForSuggestions: 2,
      textFieldConfiguration: TextFieldConfiguration(
        controller: widget._sugestionfieldController,
        onSubmitted: (Contact) {
          widget._sugestionfieldController.text = Contact;
        },
        maxLengthEnforcement: MaxLengthEnforcement.enforced,
        decoration: InputDecoration(
          // fillColor: Colors.white,
          filled: true,
          fillColor: Colors.white,
          hintText: 'Search Phonebook..',
          contentPadding: EdgeInsets.all(5),
          prefixIcon: GestureDetector(
            onTap: () {
              print('bukachondro');
            },
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              // height: 30,
              width: 50,
              // margin:
              //     const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.blue,
              ),
              child: Image.asset(
                'assets/user-plus.png',
                color: Colors.white,
              ),
            ),
          ),
          // focusedBorder: OutlineInputBorder(),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      suggestionsCallback: (pattern) async {
        return Myarr.getSuggestions(pattern);
      },
      itemBuilder: (context, suggestion) {
        return ListTile(
          leading: const Icon(Icons.person),
          title: Text(suggestion.name),
          subtitle: Text(suggestion.number),
        );
      },
      onSuggestionSelected: (suggestion) {
        widget._sugestionfieldController.text = suggestion.number;
      },
    );
  }
}
