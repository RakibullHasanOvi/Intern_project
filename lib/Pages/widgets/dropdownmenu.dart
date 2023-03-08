import 'package:flutter/material.dart';

class DropdownMenuWidget extends StatefulWidget {
  const DropdownMenuWidget({Key? key}) : super(key: key);

  @override
  State<DropdownMenuWidget> createState() => _DropdownMenuWidgetState();
}

class _DropdownMenuWidgetState extends State<DropdownMenuWidget> {
  String value = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DropdownButton<String>(
            style: const TextStyle(
              fontSize: 15,
              color: Color(0xFF000000),
            ),
            menuMaxHeight: 150,
            borderRadius: BorderRadius.circular(15),
            dropdownColor: Colors.white,
            elevation: 0,
            icon: const Icon(
              Icons.keyboard_arrow_down_outlined,
            ),
            items: const [
              DropdownMenuItem<String>(
                value: 'Personal',
                child: Text('Personal'),
              ),
              DropdownMenuItem<String>(
                value: 'Agent',
                child: Text('Agent'),
              ),
            ],
            onChanged: (_value) {
              if (_value!.isEmpty) {
              } else {}
              setState(
                () {
                  value = _value.toString();
                },
              );
            },
            hint: const Text(
              'Select',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF000000),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(
              top: 5,
            ),
            child: Text(
              value,
              // textAlign: TextAlign.start,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: Color(0xFF000000),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
