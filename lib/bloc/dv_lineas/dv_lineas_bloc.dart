import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:app_vale_cv/models/dv_lineas.dart';

part 'dv_lineas_state.dart';
part 'dv_lineas_event.dart';

class DvLineaBloc extends Bloc<DvLineasEvent, DvLineasState> {
  DvLineaBloc() : super(DvLineasIntialState()) {
    on<GetLineas>((event, emit) => emit(DvLineasSetState(event.data)));
  }
}
