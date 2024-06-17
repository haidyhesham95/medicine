import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:pharmacy/views/requests/bloc/request_bloc.dart';
import 'package:pharmacy/views/requests/widgets/request_card.dart';

class RequestsScreen extends StatelessWidget {
  RequestsScreen({super.key});
  final bloc=KiwiContainer().resolve<RequestBloc>()..add(GetAllRequestsEvent());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('All requests'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              SizedBox(
                height: 30.h,
              ),
              BlocBuilder(
                bloc: bloc,
                builder: (context, state) {
                  if (state is GetAllRequestsSuccessState) {
                    return SizedBox(
                      height: (state.requests.length * 170).h,
                      child: ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) =>
                              RequestCard(
                                request: state.requests[index],
                              ),
                          separatorBuilder: (context, index) => SizedBox(
                            height: 20.h,
                          ),
                          itemCount: state.requests.length),
                    );
                  } else if (state is GetAllRequestsFailureState) {
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
                        child: CircularProgressIndicator(
                          color: Color(0xFF4E97C5),
                        ),
                      ),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
