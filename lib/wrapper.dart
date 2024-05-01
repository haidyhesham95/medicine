import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pharmacy/gen/assets.gen.dart';
import 'package:pharmacy/views/add_medicine/add_medicine.dart';
import 'package:pharmacy/views/all_medicines/all_medicines.dart';

class Wrapper extends StatefulWidget {
  Wrapper({super.key,this.currentIndex=0});
  int currentIndex ;

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  final titles=['Medicines','Add'];

  final List<String> icons=[Assets.icons.medicine,Assets.icons.add];

  final List<Widget>screens=[AllMedicinesScreen(),AddMedicineScreens()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: List.generate(icons.length, (index) => BottomNavigationBarItem(icon: SvgPicture.asset(icons[index],width: 30,height: 30,),label: titles[index])),
        currentIndex: widget.currentIndex,
        onTap: (value) {
          setState(() {
            widget.currentIndex=value;
          });
        },
      ),
      body: screens[widget.currentIndex],
    );
  }
}
