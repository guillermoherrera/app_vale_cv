import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import '../../models/solicitud_credito.dart';

part 'solicitud_credito_state.dart';
part 'solicitud_credito_event.dart';

class SolicitudCreditoBloc
    extends Bloc<SolicitudCreditoEvent, SolicitudCreditoState> {
  SolicitudCreditoBloc() : super(SolicitudCreditoIntialState()) {
    on<GetSolicitudCredito>(
        (event, emit) => emit(SolicitudCreditoSetState(event.data)));

    on<AddClienteID>((event, emit) {
      if (state.data == null) return;
      emit(SolicitudCreditoSetState(state.data!.copyWith(
          clienteID: event.clienteID,
          clienteNombre: event.clienteNombre,
          clienteTelefono: event.clienteTelefono,
          clienteEstatusDesc: event.clienteEstatusDesc)));
    });

    on<AddDesembolsoID>((event, emit) {
      if (state.data == null) return;
      emit(SolicitudCreditoSetState(
          state.data!.copyWith(desembolsoID: event.desembolsoID)));
    });

    on<AddPlazoImporte>(((event, emit) {
      if (state.data == null) return;
      emit(SolicitudCreditoSetState(state.data!.copyWith(
          importe: event.importe,
          plazo: event.plazo,
          tipoPlazo: event.tipoPlazo)));
    }));

    on<AddCanjeAppID>((event, emit) {
      if (state.data == null) return;
      emit(SolicitudCreditoSetState(
          state.data!.copyWith(CanjeAppId: event.CanjeAppID)));
    });

    on<AddTelefono>((event, emit) {
      if (state.data == null) return;
      emit(SolicitudCreditoSetState(
          state.data!.copyWith(clienteTelefono: event.telefono)));
    });

    on<AddCreditoID>((event, emit) {
      if (state.data == null) return;
      emit(SolicitudCreditoSetState(
          state.data!.copyWith(creditoID: event.creditoID)));
    });
  }
}
