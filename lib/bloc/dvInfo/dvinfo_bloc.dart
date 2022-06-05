import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:app_vale_cv/models/dvinfo.dart';

part 'dvinfo_state.dart';
part 'dvinfo_event.dart';

class DvinfoBloc extends Bloc<DvinfoEvent, DvinfoState> {
  DvinfoBloc() : super(const DvinfoIntialState()) {
    on<GetDvInfo>((event, emit) => emit(DvinfoSetState(event.data)));
  }
}
