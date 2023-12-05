import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:pdv_project_teste_1/Models/Produto.dart';

class DropDownMenuWidget extends StatefulWidget {
  final List<String> _values;
  final Function(String) addProductList;
  DropDownMenuWidget({
    super.key,
    required values,
    required this.addProductList,
  }) : _values = values;

  @override
  State<DropDownMenuWidget> createState() => _DropDownMenuWidgetState();
}

class _DropDownMenuWidgetState extends State<DropDownMenuWidget> {
  String? _dropMenuItem;

  @override
  void initState() {
    super.initState();
    _dropMenuItem = widget._values.first;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: DropdownButton(
            style: TextStyle(fontSize: 20),
            value: _dropMenuItem,
            items: widget._values.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem(
                value: value,
                child: Text(
                  value,
                ),
              );
            }).toList(),
            onChanged: (String? value) {
              setState(() {
                _dropMenuItem = value!;
              });
            },
          ),
        ),
        IconButton(
          onPressed: () => widget.addProductList(_dropMenuItem!),
          icon: Icon(
            Icons.add,
          ),
          iconSize: 50,
        ),
      ],
    );
  }
}
