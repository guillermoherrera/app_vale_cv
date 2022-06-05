import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/cliente.dart';

part 'cliente_state.dart';
part 'cliente_event.dart';

class ClienteBloc extends Bloc<ClienteEvent, ClienteState> {
  ClienteBloc() : super(const ClienteIntialState()) {
    on<GetCliente>((event, emit) => emit(ClienteSetState(event.data)));
  }
}
