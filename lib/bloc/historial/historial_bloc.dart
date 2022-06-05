import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:app_vale_cv/models/historial_cliente.dart';

part 'historial_state.dart';
part 'historial_event.dart';

class HistorialBloc extends Bloc<HistorialEvent, HistorialState> {
  HistorialBloc() : super(const HistorialIntialState()) {
    on<GetHistorial>((event, emit) => emit(HistorialSetState(event.data)));
  }
}
