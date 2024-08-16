// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CheckBoxListView extends StatefulWidget {
  CheckBoxListView({super.key, required this.items});
  List<String> items;

  @override
  State<CheckBoxListView> createState() => _CheckBoxListViewState();
}

class _CheckBoxListViewState extends State<CheckBoxListView> 
{
  late List<bool> isChecked;

  @override
  void initState() {
    // TODO: implement initState
    isChecked = List.filled(widget.items.length, false);
    super.initState();
  }
  @override
  Widget build(BuildContext context) 
  {
    return Expanded
    (
      child: ListView.builder
      (
        itemCount: widget.items.length,
        itemBuilder: ((context, index) 
        {
          return Column(
            children: 
            [
              CheckboxListTile
              (
                title: Text(widget.items[index]),
                value: isChecked[index],
                onChanged: (value)
                {
                  setState(() {
                    isChecked[index] = value ?? false;
                  });
                },
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Divider(thickness: .4),
              )
            ],
          );
        }),
      )
    );
  }
}