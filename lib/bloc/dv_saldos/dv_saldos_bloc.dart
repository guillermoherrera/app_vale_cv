import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:app_vale_cv/models/dv_saldos.dart';

part 'dv_saldos_state.dart';
part 'dv_saldos_event.dart';

class DvSaldoBloc extends Bloc<DvSaldosEvent, DvSaldosState> {
  DvSaldoBloc() : super(DvSaldosIntialState()) {
    on<GetSld>((event, emit) => emit(DvSaldosSetState(event.data)));
  }
}
