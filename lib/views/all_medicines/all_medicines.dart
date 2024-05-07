import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:pharmacy/views/all_medicines/bloc/all_medicines_bloc.dart';
import 'package:pharmacy/views/all_medicines/widgets/medicine_card.dart';

class AllMedicinesScreen extends StatelessWidget {
  AllMedicinesScreen({super.key});

  final bloc = KiwiContainer().resolve<AllMedicinesBloc>()
    ..add(GetAllMedicinesEvent());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All products'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 16.h,),
            BlocBuilder(
              bloc: bloc,
              builder: (context, state) {
                if (state is GetAllMedicinesSuccessState) {
                  return SizedBox(
                    height: (state.medicines.length*170).h,
                    child: ListView.separated(
                        itemBuilder: (context, index) =>
                            MedicineCard(medicine: state.medicines[index]),
                        separatorBuilder: (context, index) => SizedBox(
                              height: 16.h,
                            ),
                        itemCount: state.medicines.length),
                  );
                } else if (state is GetAllMedicinesFailureState) {
                  return SizedBox(
                    height: MediaQuery.sizeOf(context).height,
                    child:  Center(
                      child: Text(state.message),
                    ),
                  );
                } else {
                  return SizedBox(
                    height: MediaQuery.sizeOf(context).height,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
