import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:pharmacy/core/helper_methods.dart';
import 'package:pharmacy/gen/assets.gen.dart';
import 'package:pharmacy/views/add_medicine/bloc/add_medicine_bloc.dart';
import 'package:pharmacy/views/all_medicines/bloc/all_medicines_bloc.dart';
import 'package:pharmacy/views/auth/widget/button.dart';

import '../auth/widget/text_field.dart';

class AddMedicineScreens extends StatefulWidget {
  const AddMedicineScreens({super.key});

  @override
  State<AddMedicineScreens> createState() => _AddMedicineScreensState();
}

class _AddMedicineScreensState extends State<AddMedicineScreens> {
  final bloc = KiwiContainer().resolve<AddMedicineBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 250, 255),
      appBar: AppBar(
        backgroundColor: const Color(0xFF4DA8CF).withOpacity(0.9),
        title: const Text('Add Medicine',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            )),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 16),
        child: Form(
          key: bloc.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 20.h,
              ),
              Container(
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    border:
                        Border.all(color: const Color(0xFF4DA8CF), width: 1.5),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 4),
                        blurRadius: 4,
                        spreadRadius: 0,
                        color: Colors.black.withOpacity(0.15),
                      )
                    ]),
                child: InkWell(
                  onTap: () {
                    bloc.pickImage.imagePickerDialog(
                      context: context,
                      onSubmit: (file, name) {
                        setState(() {
                          bloc.imageFile = file;
                          bloc.imageName = name;
                        });
                      },
                    );
                  },
                  child: bloc.imageFile == null
                      ? Center(
                          child: Image.asset(
                          Assets.images.addImage.path,
                          fit: BoxFit.cover,
                          color: const Color(0xFF4DA8CF),
                          height: 130,
                          width: 130,
                        ))
                      : Center(
                          child:
                              Image.file(bloc.imageFile!, fit: BoxFit.cover)),
                ),
              ),
              SizedBox(
                height: 50.h,
              ),
              textField(
                hintText: 'Name',
                controller: bloc.name,
                validator: (value) {
                  if (value == '') {
                    return 'please enter your name';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 16.h,
              ),
              textField(
                hintText: 'Medicine Name',
                controller: bloc.description,
                validator: (value) {
                  if (value == '') {
                    return 'please enter description';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 16.h,
              ),
              textField(
                hintText: 'Your Number',
                controller: bloc.price,
                validator: (value) {
                  if (value == '') {
                    return 'please enter your number';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 16.h,
              ),
              textField(
                hintText: 'Your location',
                controller: bloc.location,
                validator: (value) {
                  if (value == '') {
                    return 'please enter your location';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 25.h,
              ),
              BlocListener(
                bloc: bloc,
                listener: (context, state) {
                  if (state is AddMedicineSuccessState) {
                    toast(msg: state.message);
                    setState(() {
                      bloc.imageFile = null;
                      bloc.name.clear();
                      bloc.price.clear();
                      bloc.description.clear();
                      bloc.location.clear();
                    });
                    KiwiContainer()
                        .resolve<AllMedicinesBloc>()
                        .add(GetAllMedicinesEvent());
                  }
                },
                child: SizedBox(
                  width: 343.w,
                  height: 50.h,
                  child: buttonWidget(
                      onTap: () {
                        if (bloc.formKey.currentState!.validate()) {
                          if (bloc.imageFile == null) {
                            toast(msg: 'choose image');
                          } else {
                            bloc.add(AddMedicineNowEvent(
                              name: bloc.name.text,
                              price: bloc.price.text,
                              description: bloc.description.text,
                              image: bloc.imageFile!,
                              imageName: bloc.imageName,
                              location: bloc.location.text,
                            ));
                          }
                        }
                      },
                      text: 'Save',
                      fontSize: 18.sp,
                      radius: 15.0.r),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
