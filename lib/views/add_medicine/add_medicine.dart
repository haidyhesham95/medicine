import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:pharmacy/core/helper_methods.dart';
import 'package:pharmacy/gen/assets.gen.dart';
import 'package:pharmacy/views/add_medicine/bloc/add_medicine_bloc.dart';
import 'package:pharmacy/views/all_medicines/bloc/all_medicines_bloc.dart';

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
      appBar: AppBar(
        title: const Text('Add Medicine'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsetsDirectional.symmetric(horizontal: 16),
        child: Form(
          key: bloc.formKey,
          child: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: bloc.imageFile == null
                    ? Container(
                        width: 150.0.w,
                        height: 150.0.h,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(Assets.images.addImage.path),
                              fit: BoxFit.cover),
                        ),
                      )
                    : Container(
                        width: 150.0.w,
                        height: 150.0.h,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: FileImage(bloc.imageFile!),
                              fit: BoxFit.cover),
                        ),
                      ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
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
                  child: const Text('Upload Image'),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              TextFormField(
                controller: bloc.name,
                validator: (value) {
                  if (value == '') {
                    return 'please enter your name';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: 'Name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.r))),
              ),
               SizedBox(
                height: 16.h,
              ),
              TextFormField(
                controller: bloc.description,
                validator: (value) {
                  if (value == '') {
                    return 'please enter description';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: 'Description',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.r))),
              ),
              SizedBox(
                height: 16.h,
              ),
              TextFormField(
                controller: bloc.price,
                validator: (value) {
                  if (value == '') {
                    return 'please enter price';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: 'Price',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.r))),
              ),
              SizedBox(
                height: 16.h,
              ),
              BlocListener(
                bloc:bloc,
                listener: (context, state) {
                  if(state is AddMedicineSuccessState){
                    toast(msg: state.message);
                    setState(() {
                      bloc.imageFile=null;
                      bloc.name.clear();
                      bloc.price.clear();
                      bloc.description.clear();
                    });
                    KiwiContainer().resolve<AllMedicinesBloc>().add(GetAllMedicinesEvent());
                  }
                },
                child: ElevatedButton(
                    onPressed: () {
                      if (bloc.formKey.currentState!.validate()) {
                        if (bloc.imageFile == null) {
                          toast(msg: 'choose image');
                        } else {
                          bloc.add(AddMedicineNowEvent(
                              name: bloc.name.text,
                              price: bloc.price.text,
                              description: bloc.description.text,
                              image: bloc.imageFile!,
                              imageName: bloc.imageName));
                        }
                      }
                    },
                    child: const Text('Save')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
