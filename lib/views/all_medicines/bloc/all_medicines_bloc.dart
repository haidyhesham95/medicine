import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'all_medicines_event.dart';
part 'all_medicines_state.dart';

class AllMedicinesBloc extends Bloc<AllMedicinesEvent, AllMedicinesState> {
  AllMedicinesBloc() : super(AllMedicinesInitial()) {
    on<AllMedicinesEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
