import 'package:app_vale_cv/models/vale.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'vale_detalle_state.dart';
part 'vale_detalle_event.dart';

class ValeDetalleBloc extends Bloc<ValeDetalleEvent, ValeDetalleState> {
  ValeDetalleBloc() : super(const ValeDetalleIntialState()) {
    on<GetValeDetalle>((event, emit) => emit(ValeDetalleSetState(event.data)));
  }
}
