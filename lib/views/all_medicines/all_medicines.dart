import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:pharmacy/core/cache_helper.dart';
import 'package:pharmacy/core/helper_methods.dart';
import 'package:pharmacy/views/all_medicines/bloc/all_medicines_bloc.dart';
import 'package:pharmacy/views/all_medicines/widgets/medicine_card.dart';
import 'package:pharmacy/views/all_medicines/widgets/search.dart';
import 'package:pharmacy/views/requests/bloc/request_bloc.dart';

class AllMedicinesScreen extends StatelessWidget {
  AllMedicinesScreen({super.key});

  final bloc = KiwiContainer().resolve<AllMedicinesBloc>()
    ..add(GetAllMedicinesEvent());
  final bloc2 = KiwiContainer().resolve<RequestBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: Search());
            },
            icon: Icon(Icons.search),
          ),
        ],
        title: const Text('All Medicine'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 16.h,
            ),
            BlocBuilder(
              bloc: bloc,
              builder: (context, state) {
                if (state is GetAllMedicinesSuccessState) {
                  return SizedBox(
                    height: (state.medicines.length * 170).h,
                    child: ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => BlocListener(
                              bloc: bloc2,
                              listener: (context, state) {
                                if (state is RequestMedicineSuccessState) {
                                  toast(msg: state.message);
                                  bloc2.add(GetAllRequestsEvent());
                                } else if (state
                                    is RequestMedicineFailureState) {
                                  toast(msg: state.message);
                                }
                              },
                              child: MedicineCard(
                                medicine: state.medicines[index],
                                onTap: () {
                                  bloc2.add(RequestMedicineEvent(
                                      medicineId: state.medicines[index].id,
                                      userId: CacheHelper.getId()));
                                },
                              ),
                            ),
                        separatorBuilder: (context, index) => SizedBox(
                              height: 16.h,
                            ),
                        itemCount: state.medicines.length),
                  );
                } else if (state is GetAllMedicinesFailureState) {
                  return SizedBox(
                    height: MediaQuery.sizeOf(context).height,
                    child: Center(
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
