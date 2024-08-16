// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class RadioListView extends StatefulWidget {
  RadioListView({super.key, required this.items, required this.selectedValue});
  List<String> items;
  int selectedValue;

  @override
  State<RadioListView> createState() => _RadioListViewState();
}

class _RadioListViewState extends State<RadioListView> {
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
              RadioListTile
              (
                title: Text(widget.items[index]),
                value: index, 
                groupValue: widget.selectedValue, 
                onChanged: (value)
                {
                  setState(() {
                    widget.selectedValue = value!;
                  });
                }
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